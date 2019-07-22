
#################################--nginx.config---bucket---task3.5--##########################################

resource "aws_s3_bucket" "nginx-config-dev" {
  bucket = "nginx-config-dev"
  acl = "private"
  tags = {
    Name = "nginx-config-dev"
    Workspace = "${terraform.workspace}"
  }


  provisioner "local-exec" {
    command = "aws --profile AWS_Admin s3 cp /home/kos/awsterraform/modules/app/nginx/nginxconfig.conf s3://${aws_s3_bucket.nginx-config-dev.bucket}/sr/nginx.conf"
  }



}

