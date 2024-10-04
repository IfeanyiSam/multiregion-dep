variable "region" {
  description = "The AWS region"
}

variable "environment" {
  description = "The deployment environment"
}

variable "vpc_id" {
  description = "VPC ID for the EC2 instances"
}

variable "subnet_ids" {
  description = "Subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
}

variable "instance_type" {
  description = "The instance type for EC2 instances"
  type        = string
}
