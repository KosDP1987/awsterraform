# awsterraform
1. Create 2 sub-directories with names “vpc” and “app”.
2. Configure remote backend for each layer (vpc, app):
	a. Create S3 bucket and DynamoDB table manually
	b. Create remote backend configuration for Terraform
	c. Create 2 workspaces: dev, pro
3. For each workspace into “vpc” directory implement Terraform recipes for networking
    layer
	a. Create new VPCs. Add environment name in names dynamically. For example:
	vpc-demo-dev, vpc-demo-pro
	b. Create private and public subnets in each AZ (6 subnets). Add environment
	name in names dynamically. For example: private-demo-dev, public-demo-pro
4. For dev workspace create ELB and security groups. Names should contain environment.
	a. ELB
	i. Type - public
	ii. Type - “Classic load balancer”
	iii. SG - SG-ELB
	iv. Tags: “Name”: “demo-app-01”
	b. Security group (SG) for ASG and ELB. Security groups should allow traffic
	between ELB and ASG. Also SG for ELB allows HTTP traffic from anywhere and
	SG for instances allows SSH traffic from anywhere. Names “SG-EC2”, “SG-ELB”
5. For dev workspace create S3 bucket. Name: nginx-configuration. Put into bucket some
     custom nginx configuration (use local-exec provisioner)
6. Create role with S3 bucket access permissions. (bucket: nginx-configuration)
7. For dev workspace create ASG and launch configuration:
	a. AMI - some ubuntu image
	b. SG - SG-EC2
	c. Size - t2.micro
	d. Subnets - public
	e. Tags: “Name”: “demo-app-01-${var.env_name}”
	f. Attach role. Instances in ASG should have access to S3 bucket with nginx
	configuration.
	g. User-data should install nginx latest version, copy nginx configuration from S3
	bucket and start service.
	h. Healthcheck ELB
8. Modify ELB recipes. ELB should do health check on 80 port
9. Attach ASG to ELB
