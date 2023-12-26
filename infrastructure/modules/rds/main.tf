resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "12.4"
  instance_class      = "db.t3.micro"
  db_name              = var.db_name
  username            = var.db_user
  password            = var.db_password
  parameter_group_name = "default.postgres12"
  skip_final_snapshot = true
  vpc_security_group_ids = [var.db_security_group_id]
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "backend-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "MyDBSubnetGroup"
  }
}