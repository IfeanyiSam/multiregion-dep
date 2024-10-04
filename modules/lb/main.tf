# modules/load_balancer/main.tf

resource "aws_globalaccelerator_accelerator" "gudlyf" {
  name            = "${var.environment}-accelerator"
  ip_address_type = "IPV4"
  enabled         = true
}

resource "aws_globalaccelerator_listener" "gudlyf" {
  accelerator_arn = aws_globalaccelerator_accelerator.gudlyf.id
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}

resource "aws_globalaccelerator_endpoint_group" "primary" {
  listener_arn = aws_globalaccelerator_listener.gudlyf.id
  

  endpoint_configuration {
    endpoint_id = aws_lb.primary.arn
    weight      = 100
  }
}

resource "aws_globalaccelerator_endpoint_group" "secondary" {
  listener_arn = aws_globalaccelerator_listener.gudlyf.id
  

  endpoint_configuration {
    endpoint_id = aws_lb.secondary.arn
    weight      = 0
  }
}

resource "aws_lb" "primary" {
  provider    = aws.primary

  name               = "${var.environment}-primary-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_primary.id]
  subnets            = var.primary_subnet_ids
}

resource "aws_lb" "secondary" {
  provider    = aws.secondary
 
  name               = "${var.environment}-secondary-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_secondary.id]
  subnets            = var.secondary_subnet_ids
}

resource "aws_security_group" "alb_primary" {
  provider    = aws.primary
  name        = "${var.environment}-primary-alb-sg"
  description = "Security group for primary ALB"
  vpc_id      = var.primary_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb_secondary" {
  provider    = aws.secondary
  name        = "${var.environment}-secondary-alb-sg"
  description = "Security group for secondary ALB"
  vpc_id      = var.secondary_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
