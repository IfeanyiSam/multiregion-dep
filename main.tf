provider "aws" {
  alias  = "primary"
  region = var.primary_region
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}

module "vpc_primary" {
  source = "./modules/vpc"
  providers = {
    aws = aws.primary
  }
  environment          = var.environment
  vpc_cidr             = var.primary_vpc_cidr
  public_subnet_cidrs  = var.primary_public_subnet_cidrs
  private_subnet_cidrs = var.primary_private_subnet_cidrs
  availability_zones   = var.primary_availability_zones
  enable_nat_gateway   = true
}

module "vpc_secondary" {
  source = "./modules/vpc"
  providers = {
    aws = aws.secondary
  }
  environment          = var.environment
  vpc_cidr             = var.secondary_vpc_cidr
  public_subnet_cidrs  = var.secondary_public_subnet_cidrs
  private_subnet_cidrs = var.secondary_private_subnet_cidrs
  availability_zones   = var.secondary_availability_zones
  enable_nat_gateway   = true
}

module "s3_primary" {
  source = "./modules/s3"
  providers = {
    aws = aws.primary
  }
  region                 = var.primary_region
  environment            = var.environment
  bucket_name            = "${var.environment}-${var.primary_region}-bucket"
  destination_bucket_arn = module.s3_secondary.bucket_arn
}

module "s3_secondary" {
  source = "./modules/s3"
  providers = {
    aws = aws.secondary
  }
  region                 = var.secondary_region
  environment            = var.environment
  bucket_name            = "${var.environment}-${var.secondary_region}-bucket"
  destination_bucket_arn = module.s3_primary.bucket_arn
}

module "rds_primary" {
  source = "./modules/rds"
  providers = {
    aws = aws.primary
  }
  region          = var.primary_region
  environment     = var.environment
  db_username     = var.db_username
  db_password     = var.db_password
  route53_zone_id = var.route53_zone_id
  vpc_id          = module.vpc_primary.vpc_id
  subnet_ids      = module.vpc_primary.private_subnet_ids
}

module "rds_secondary" {
  source = "./modules/rds"
  providers = {
    aws = aws.secondary
  }
  region          = var.secondary_region
  environment     = var.environment
  db_username     = var.db_username
  db_password     = var.db_password
  route53_zone_id = var.route53_zone_id
  vpc_id          = module.vpc_secondary.vpc_id
  subnet_ids      = module.vpc_secondary.private_subnet_ids
}

module "ec2_primary" {
  source = "./modules/ec2"
  providers = {
    aws = aws.primary
  }
  region        = var.primary_region
  environment   = var.environment
  instance_type = var.instance_type
  vpc_id        = module.vpc_primary.vpc_id
  subnet_ids    = module.vpc_primary.private_subnet_ids
  ami_id        = var.primary_ami_id
}

module "ec2_secondary" {
  source = "./modules/ec2"
  providers = {
    aws = aws.secondary
  }
  region        = var.secondary_region
  environment   = var.environment
  instance_type = var.instance_type
  vpc_id        = module.vpc_secondary.vpc_id
  subnet_ids    = module.vpc_secondary.private_subnet_ids
  ami_id        = var.secondary_ami_id
}

module "load_balancer" {
  source = "./modules/lb"
  providers = {
    aws.primary   = aws.primary
    aws.secondary = aws.secondary
  }
  primary_region       = var.primary_region
  secondary_region     = var.secondary_region
  environment          = var.environment
  primary_vpc_id       = module.vpc_primary.vpc_id
  secondary_vpc_id     = module.vpc_secondary.vpc_id
  primary_subnet_ids   = module.vpc_primary.public_subnet_ids
  secondary_subnet_ids = module.vpc_secondary.public_subnet_ids
}

module "monitoring" {
  source = "./modules/monitoring"
  providers = {
    aws.primary   = aws.primary
    aws.secondary = aws.secondary
  }
  primary_region    = var.primary_region
  secondary_region  = var.secondary_region
  environment       = var.environment
  primary_alb_arn   = module.load_balancer.primary_alb_arn
  secondary_alb_arn = module.load_balancer.secondary_alb_arn
}
