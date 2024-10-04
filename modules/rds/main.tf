# modules/rds/main.tf

resource "aws_db_subnet_group" "gudlyf" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "gudlyf" {
  identifier        = "${var.environment}-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  multi_az          = true

  db_name  = "${var.environment}db"
  username = var.db_username
  password = var.db_password

  backup_retention_period = 7
  skip_final_snapshot     = true

  db_subnet_group_name = aws_db_subnet_group.gudlyf.name
  vpc_security_group_ids = [aws_security_group.db.id]
}

resource "aws_security_group" "db" {
  name        = "${var.environment}-db-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
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

resource "aws_route53_record" "db" {
  zone_id = var.route53_zone_id
  name    = "${var.environment}-db.example.com"
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.gudlyf.endpoint]
}
