#############################--EC2 instance data-------#########################
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
##########################---launch_configuration----#######################
resource "aws_launch_configuration" "asg_conf" {
  name_prefix = "demo-add-01-${terraform.workspace}"
  image_id = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  security_groups = ["${var.sg-ec2}"]
  iam_instance_profile = "${var.instance_profile}"
  user_data = "${file("/home/kos/awsterraform/modules/app/asg/userdata.sh")}"

  associate_public_ip_address = true
}

#####################---ASG create---############################
resource "aws_autoscaling_group" "asg" {
  name = "demo-app-dev"
  max_size = 2
  min_size = 1
  launch_configuration = "${aws_launch_configuration.asg_conf.name}"
  availability_zones = "${var.availability_zones}"
  vpc_zone_identifier = "${var.public_subnets}"
  tag {
    key = "Name"
    propagate_at_launch = true
    value = "demo-app-01-${terraform.workspace}"
  }
}
