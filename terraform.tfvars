
# Region configuration
primary_region   = "us-west-2"
secondary_region = "us-east-1"

# Environment
environment = "production"

# VPC configuration
primary_vpc_cidr   = "10.0.0.0/16"
secondary_vpc_cidr = "10.1.0.0/16"

primary_public_subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
primary_private_subnet_cidrs   = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
secondary_public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
secondary_private_subnet_cidrs = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]


# EC2 configuration
instance_type    = "t2.micro"
primary_ami_id   = "ami-0c55b159cbfafe1f0" 
secondary_ami_id = "ami-0947d2ba12ee1ff75" 

# RDS configuration
db_instance_class = "db.t3.micro"
db_name           = "myappdb"
db_username       = "admin"
db_password       = ""


# Load Balancer configuration
lb_internal = false

# Monitoring configuration
alarm_email = ""

# Tags
project_name = "MyMultiRegionApp"
owner        = "DevOps Team"

# Other configuration
enable_deletion_protection = false
