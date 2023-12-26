variable "vpc_id" {
  description = "The VPC ID to which the internet gateway will be attached."
}

variable "public_subnet_ids" {
  description = "A list of IDs of the public subnets to associate with the internet gateway."
  type        = list(string)
}