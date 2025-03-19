provider "aws" {
  region = var.aws_region  # Using variable for region
}

# EC2 Instance for Jenkins
resource "aws_instance" "my_instance" {
  ami           = "ami-0ab53a19308889b24"  # Latest Ubuntu 20.04 AMI
  instance_type = var.instance_type

  tags = {
    Name = "Jenkins-Terraform-EC2"
  }
}

# Another EC2 Instance (Optional, if you need two instances)
resource "aws_instance" "web" {
  ami           = "ami-0ab53a19308889b24"  # Latest Ubuntu 20.04 AMI
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-Instance"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name  # Ensure uniqueness
}

# IAM Role for Jenkins
resource "aws_iam_role" "my_role" {
  name = "jenkins-terraform-role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}
