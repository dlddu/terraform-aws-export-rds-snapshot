terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.67.0"
      configuration_aliases = [aws.from, aws.to]
    }
  }
}

data "aws_caller_identity" "to" {
  provider = aws.to
}

module "from" {
  source = "./from"
  providers = {
    aws = aws.from
  }

  from_snapshot_name         = var.from_snapshot_name
  intermediate_snapshot_name = var.intermediate_snapshot_name
  to_account_id              = data.aws_caller_identity.to.account_id
}

module "to" {
  source = "./to"
  providers = {
    aws = aws.to
  }

  intermediate_snapshot_arn = module.from.intermediate_snapshot_arn
  to_snapshot_name          = var.to_snapshot_name
}
