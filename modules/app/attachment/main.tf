########-----------attach autoscaling group to elb   #

resource "aws_autoscaling_attachment" "attachment" {
  autoscaling_group_name = "${var.asg}"
  elb                    = "${var.elb}"
}
