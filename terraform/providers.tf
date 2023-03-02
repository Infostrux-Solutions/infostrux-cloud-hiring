terraform {
  required_version = "~> 1.3"

  required_providers {
    random = "> 2.0"
    aws = {
      source  = "hashicorp/aws"
      version = "4.46.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"

  assume_role {
    role_arn = var.aws_assume_role
  }

  default_tags {
    tags = local.default_tags
  }
}
