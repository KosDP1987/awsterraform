#########################---output elb---#############################
output "elb" {
  value = "${aws_elb.elb.id}"
}
