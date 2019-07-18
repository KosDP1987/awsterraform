# ----------------------Provider------------------------#
provider "aws" {
  region = "$(var.aws_region)"
  profile = "$(var.aws_profile)"
}

#---------------------- S3 backend config----------------#

terraform {
  backend "s3" {
    bucket         = "backend-vpc"
    workspace_key_prefix = "env"
    region         = "us-east-2"
    key            = "terraform.tfstate"
    dynamodb_table = "dynamodb-terraform"
  }
}

#---------------------------------------------------------#