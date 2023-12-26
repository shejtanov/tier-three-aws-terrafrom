resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "private_app_subnet" {
  count = length(var.private_app_subnets_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnets_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "private-app-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "private_db_subnet" {
  count = length(var.private_db_subnets_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnets_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "private-db-${var.azs[count.index]}"
  }
}