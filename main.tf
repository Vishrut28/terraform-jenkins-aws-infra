provider "aws" {
  region = "ap-south-1"  # Change this to your preferred region
}

# Generate random suffix for uniqueness
resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "random_id" "role_id" {
  byte_length = 4
}

# IAM Role for EC2
resource "aws_iam_role" "my_role" {
  name = "jenkins-terraform-role-${random_id.role_id.hex}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  ami           = "ami-014e2b14bdb83e8ca"  # Ubuntu 20.04 LTS in ap-south-1
  instance_type = "t2.micro"

  tags = {
    Name = "Jenkins-Terraform-EC2"
  }
}

# S3 Bucket with unique name
resource "aws_s3_bucket" "my_bucket" {
  bucket = "jenkins-terraform-demo-bucket-${random_id.bucket_id.hex}"
}
