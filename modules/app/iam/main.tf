#######################- IAM_role create task3.6 -########################################

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type = "Service"
    }
  }
}
resource "aws_iam_role" "nginx-configuration" {
  name = "nginx-configuration"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
  tags = {
    Name = "nginx-configuration"
  }
}
########################- policy to role -##################################################
resource "aws_iam_policy" "access" {
  name = "access"
  policy = "${file("modules/app/iam/policy.json")}"
}
########################- policy attach to role -############################################
resource "aws_iam_role_policy_attachment" "nginx" {
  policy_arn = "${aws_iam_policy.access.arn}"
  role = "${aws_iam_role.nginx-configuration.name}"
}
########################- create instance profile for roles -################################
resource "aws_iam_instance_profile" "nginx-profile" {
  name = "nginx-profile"
  role = "nginx-configuration"
}
