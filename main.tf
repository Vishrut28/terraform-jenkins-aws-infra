provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0c2e61fdcb5495691"  # Replace with a valid AMI ID
  instance_type = var.instance_type
  tags = {
    Name = "Jenkins-Terraform-EC2"
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name  # Ensure uniqueness
}

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
