
variable "primary_vpc_cidr" {
  description = "CIDR block for the primary VPC"
  type        = string
}

variable "secondary_vpc_cidr" {
  description = "CIDR block for the secondary VPC"
  type        = string
}

variable "primary_public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets in the primary VPC"
  type        = list(string)
}

variable "primary_private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets in the primary VPC"
  type        = list(string)
}

variable "secondary_public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets in the secondary VPC"
  type        = list(string)
}

variable "secondary_private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets in the secondary VPC"
  type        = list(string)
}

variable "primary_availability_zones" {
  description = "List of availability zones in the primary region"
  type        = list(string)
}

variable "secondary_availability_zones" {
  description = "List of availability zones in the secondary region"
  type        = list(string)
}


variable "primary_region" {
  description = "The primary AWS region"
  default     = "us-east-1"
}

variable "secondary_region" {
  description = "The secondary AWS region"
  default     = "us-west-2"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  default     = "dev"
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

variable "primary_vpc_id" {
  description = "VPC ID in the primary region"
}

variable "secondary_vpc_id" {
  description = "VPC ID in the secondary region"
}

variable "primary_subnet_ids" {
  description = "Subnet IDs in the primary region"
  type        = list(string)
}

variable "secondary_subnet_ids" {
  description = "Subnet IDs in the secondary region"
  type        = list(string)
}

variable "primary_ami_id" {
  description = "AMI ID for EC2 instances in the primary region"
}

variable "secondary_ami_id" {
  description = "AMI ID for EC2 instances in the secondary region"
}

variable "primary_subnet_cidrs" {
  description = "List of CIDR blocks for primary subnets"
  type        = list(string)
}


variable "secondary_subnet_cidrs" {
  description = "List of CIDR blocks for secondary subnets"
  type        = list(string)
}

variable "instance_type" {
  description = "The instance type for EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
}

variable "lb_internal" {
  type        = bool
  description = "Whether the load balancer is internal or not"
}

variable "alarm_email" {
  type        = string
  description = "Email address for alarm notifications"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "owner" {
  type        = string
  description = "Owner of the project"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection for resources"
}
