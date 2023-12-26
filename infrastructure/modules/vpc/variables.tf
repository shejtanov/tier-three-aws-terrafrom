variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "The list of availability zones in the region."
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "The list of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_app_subnets_cidr" {
  description = "The list of CIDR blocks for the private application subnets."
  type        = list(string)
}

variable "private_db_subnets_cidr" {
  description = "The list of CIDR blocks for the private database subnets."
  type        = list(string)
}