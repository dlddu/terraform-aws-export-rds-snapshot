provider "aws" {
  region  = var.region
  profile = var.to_profile
}

data "aws_caller_identity" "to" {}

module "from" {
  source = "./from"

  region                     = var.region
  profile                    = var.from_profile
  from_snapshot_name         = var.from_snapshot_name
  intermediate_snapshot_name = var.intermediate_snapshot_name
  to_account_id              = data.aws_caller_identity.to.account_id
}

module "to" {
  source = "./to"

  region                    = var.region
  profile                   = var.to_profile
  intermediate_snapshot_arn = module.from.intermediate_snapshot_arn
  to_snapshot_name          = var.to_snapshot_name
}
