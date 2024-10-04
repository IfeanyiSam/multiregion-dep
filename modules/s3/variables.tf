# modules/s3/variables.tf

variable "region" {
  description = "The AWS region"
}

variable "environment" {
  description = "The deployment environment"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
}

variable "destination_bucket_arn" {
  description = "The ARN of the destination bucket for replication"
}
