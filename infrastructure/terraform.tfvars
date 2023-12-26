access_key           = ""
secret_key           = ""

aws_region               = "eu-north-1"
vpc_cidr = "10.0.0.0/16"

azs = [
  "us-east-1a",
  "us-east-1b"
]

public_subnets_cidr = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_app_subnets_cidr = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

private_db_subnets_cidr = [
  "10.0.5.0/24",
  "10.0.6.0/24"
]
