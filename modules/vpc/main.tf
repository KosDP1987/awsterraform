#-------------VPC/vpc--------------#
resource "aws_vpc" "vpc-demo" {
  cidr_block = "10.10.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-demo-${terraform.workspace}"
    env = "${terraform.workspace}"
  }
}
#------------------internet_gateway
resource "aws_internet_gateway" "vpc_igv" {
  vpc_id = "${aws_vpc.vpc-demo.id}"
  tags = {
    Name = "vpc-igw-${terraform.workspace}"
  }
}
#--------------route_table-----------------#
resource "aws_route_table" "vpc_public" {
  vpc_id = "${aws_vpc.vpc-demo.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_igv.id}"
  }
  tags = {
    Name = "vpc_public_rt-${terraform.workspace}"
    env = "${terraform.workspace}"
  }
}
#____________public_subnets ---------------#
resource "aws_subnet" "public" {
  count = "${length(var.public_cidr)}"
  cidr_block = "${element(var.public_cidr, count.index)}"
  vpc_id = "${aws_vpc.vpc-demo.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  tags = {
    Name = "public-demo-${terraform.workspace}-[${count.index}]"
    env = "${terraform.workspace}"
  }
}
#------------------public-subnet-assoc--------------------#
resource "aws_route_table_association" "vpc-public-assoc" {
  count = "${length(var.public_cidr)}"
  route_table_id = "${aws_route_table.vpc_public.id}"
  subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
}
#-----------------privat-subnet-assoc----------------------#
resource "aws_subnet" "privat" {
  count = "${length(var.privat_cidr)}"
  cidr_block = "${element(var.privat_cidr,count.index)}"
  vpc_id = "${aws_vpc.vpc-demo.id}"
  availability_zone = "${element(var.availability_zones,count.index)}"
  tags = {
    Name = "privat-demo-${terraform.workspace}-[${count.index}]"
    env = "${terraform.workspace}"
  }
}
