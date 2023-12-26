output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "private_app_subnet_ids" {
  value = aws_subnet.private_app_subnet.*.id
}

output "private_db_subnet_ids" {
  value = aws_subnet.private_db_subnet.*.id
}