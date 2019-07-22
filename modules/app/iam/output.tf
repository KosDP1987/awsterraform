##############################- output instance profile for role attachment -############################

output "instance_profile" {
  value = "${aws_iam_instance_profile.nginx-profile.id}"
}
