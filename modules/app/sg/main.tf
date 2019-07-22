############################------SG-----####################################
resource "aws_security_group" "sg-elb" {
  name = "ELB" ## elastic load balancer
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-elb-${terraform.workspace}"
    env = "${terraform.workspace}"}
}
#----------------------------------sg-ec2------------------------------------#
resource "aws_security_group" "sg-ec2" {
  name = "EC2"
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-ec2-${terraform.workspace}"
    env = "${terraform.workspace}"}
}
#---------------rule for SG allow trafic from ELB----------------------#

resource "aws_security_group_rule" "allow_1" {

  from_port = 0
  protocol = "tcp"
  security_group_id = "${aws_security_group.sg-ec2.id}"
  to_port = 65535
  type = "ingress"
  source_security_group_id = "${aws_security_group.sg-elb.id}"
}

#---------------------rule for ELB----allow trafic from EC2-------------#
resource "aws_security_group_rule" "allow_2" {
  from_port = 0
  protocol = "tcp"
  security_group_id = "${aws_security_group.sg-elb.id}"
  to_port = 65535
  type = "ingress"
  source_security_group_id = "${aws_security_group.sg-ec2.id}"
}
