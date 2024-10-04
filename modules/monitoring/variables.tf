variable "environment" {
  description = "The deployment environment"
}

variable "primary_region" {
  description = "The primary AWS region"
}

variable "secondary_region" {
  description = "The secondary AWS region"
}

variable "primary_alb_arn" {
  description = "The ARN of the primary Application Load Balancer"
}

variable "secondary_alb_arn" {
  description = "The ARN of the secondary Application Load Balancer"
}
