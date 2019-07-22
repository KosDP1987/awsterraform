# ----------------------Provider------------------------#
provider "aws" {
  #region = "$(var.aws_region)"
  #region = "default"
  region = "us-east-2"
  #profile = "$(var.aws_profile)"
  profile = "default"
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
module "vpc" {
  source = "./modules/vpc/"
  availability_zones = "${var.availability_zones}"
  aws_region = "${var.aws_region}"
  public_cidr = "${var.public_cidr}"
  privat_cidr = "${var.privat_cidr}"
}
module "sg" {
  source = "./modules/app/sg"
  vpc_id = "${module.vpc.vpc_id}"
}
module "elb" {
  source = "./modules/app/elb"
  security_group = "${module.sg.security_group}"
  public_subnets = "${module.vpc.public_subnets}"
}
module "nginx" {
  source = "./modules/app/nginx"
}
module "iam" {
  source = "./modules/app/iam"
}
module "asg" {
  source = "./modules/app/asg"
  sg-ec2 = "${module.sg.sg-ec2}"
  instance_profile = "${module.iam.instance_profile}"
  public_subnets = "${module.vpc.public_subnets}"
  availability_zones = "${var.availability_zones}"
}
module "attach" {
  source = "./modules/app/attach"
  asg = "${module.asg.asg}"
  elb ="${module.elb.elb}"
}
