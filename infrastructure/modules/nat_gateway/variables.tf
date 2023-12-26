variable "vpc_id" {
  description = "The VPC ID to which the NAT gateway will be attached."
}

variable "public_subnet_id" {
  description = "The ID of the public subnet where the NAT gateway will be created."
}

variable "private_subnet_ids" {
  description = "A list of IDs of the private subnets that will use the NAT gateway."
  type        = list(string)
}