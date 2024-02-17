terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

provider "aws" {
  alias   = "from"
  region  = var.region
  profile = var.from_profile_name
}

provider "aws" {
  alias   = "to"
  region  = var.region
  profile = var.to_profile_name
}
