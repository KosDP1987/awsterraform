#variable "aws_profile" { default = "default" }
variable "aws_profile" { default = "AWS_Admin" }
variable "aws_region" { default = "us-east-2" }


variable "public_cidr" { type = "list" }
variable "privat_cidr" { type = "list" }
variable "availability_zones" { type = "list" }
