variable "instance_profile" {}
variable "sg-ec2" {}
variable "public_subnets" {
  type = "list"
}
variable "availability_zones" {
  type = "list"
}
