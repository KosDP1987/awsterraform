output "security_group" {
  value = "${aws_security_group.sg-elb.id}"
}
output "sg-ec2" {
  value = "${aws_security_group.sg-ec2.id}"
}
