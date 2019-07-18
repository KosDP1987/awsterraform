
provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

#--------------bucket---------------#
resource "aws_s3_bucket" "backend-vpc" {
  bucket = "backend-vpc"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}

#------------create a dynamodb ---------------------

resource "aws_dynamodb_table" "dynamodb-terraform" {
  name           = "dynamodb-terraform"
  hash_key       = "LockID"
  read_capacity = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-terraform"
  }
}
