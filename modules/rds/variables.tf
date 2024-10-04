# modules/rds/variables.tf

variable "region" {
  description = "The AWS region"
}

variable "environment" {
  description = "The deployment environment"
}

variable "db_username" {
  description = "Username for the RDS instance"
}

variable "db_password" {
  description = "Password for the RDS instance"
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID"
}

variable "vpc_id" {
  description = "VPC ID for the RDS instance"
}

variable "subnet_ids" {
  description = "Subnet IDs for the RDS instance"
  type        = list(string)
}
