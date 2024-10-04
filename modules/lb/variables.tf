# modules/load_balancer/variables.tf

variable "environment" {
  description = "The deployment environment"
}

variable "primary_region" {
  description = "The primary AWS region"
}

variable "secondary_region" {
  description = "The secondary AWS region"
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
