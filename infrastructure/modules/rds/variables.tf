variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
}

variable "db_user" {
  description = "Username for the database."
}

variable "db_password" {
  description = "Password for the database."
}

variable "db_security_group_id" {
  description = "The security group ID for the RDS instance."
}

variable "db_subnet_ids" {
  description = "A list of VPC subnet IDs for the RDS instance."
  type        = list(string)
}