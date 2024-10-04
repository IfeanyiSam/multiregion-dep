output "global_accelerator_dns_name" {
  description = "The DNS name of the Global Accelerator"
  value       = aws_globalaccelerator_accelerator.gudlyf.dns_name
}

output "primary_alb_arn" {
  description = "The ARN of the primary Application Load Balancer"
  value       = aws_lb.primary.arn
}

output "secondary_alb_arn" {
  description = "The ARN of the secondary Application Load Balancer"
  value       = aws_lb.secondary.arn
}
