variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "s3_bucket_name" {
  description = "Unique S3 bucket name"
  default     = "jenkins-terraform-demo-bucket-12345"
}