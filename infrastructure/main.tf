provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"
  azs = ["eu-north-1a", "eu-north-1b"]
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  private_app_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  private_db_subnets_cidr = ["10.0.5.0/24", "10.0.6.0/24"]
}

module "igw" {
  source = "./modules/igw"

  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "nat_gateway" {
  source = "./modules/nat_gateway"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_ids[0] # Assuming the first public subnet
  private_subnet_ids = module.vpc.private_app_subnet_ids
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security_groups.alb_sg_id  // Passing the ALB SG ID to the ALB module
}

module "asg_web" {
  source = "./modules/asg_web"

  web_ami_id                 = "ami-12345"  // Replace with the actual AMI ID
  web_instance_type          = "t3.micro"
  web_subnet_ids             = module.vpc.public_subnet_ids
  web_asg_min_size           = 1
  web_asg_max_size           = 3
  web_asg_desired_capacity   = 2
}

module "ecr" {
  source = "./modules/ecr"
}

module "iam_user" {
  source = "./modules/iam_user"
}

module "iam_ecs" {
  source = "./modules/ecs_iam"
}

module "ecs" {
  source = "./modules/ecs"
  
  ecs_execution_role_arn = module.iam_ecs.ecs_execution_role_arn
  backend_image = "${module.ecr.repository_url}:latest"
}

module "rds" {
  source = "./modules/rds"
  db_name     = "mydatabase"
  db_user     = "myuser"
  db_password = "mypassword"
  db_security_group_id = module.security_groups.db_sg_id
  db_subnet_ids = module.vpc.private_db_subnet_ids
}

module "s3_frontend" {
  source = "./modules/s3_frontend"
}

# module "cloudfront_frontend" {
#   source = "./modules/cloudfront_frontend"
# }