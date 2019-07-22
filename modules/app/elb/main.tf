####################---ELB---#####################

resource "aws_elb" "elb" {
  name = "demo-app-01"
  subnets = "${var.public_subnets}"
  security_groups = ["${var.security_group}"]
  listener {
    instance_port = 80
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }
  tags = {
    Name = "demo-app-01"
    env = "${terraform.workspace}"
  }
}
