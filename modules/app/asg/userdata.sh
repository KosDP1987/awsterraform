#!/usr/bin/env bash
sudo apt update -y
sudo apt install -y nginx
aws s3 cp s3://nginx-configuration-dev/sr/nginx.conf /etc/nginx/nginx.conf
sudo service nginx start
