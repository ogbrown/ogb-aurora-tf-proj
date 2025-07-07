output "vpc_id" {
  value = data.aws_vpc.selected.id
}

output "subnet_group_name" {
  value = aws_db_subnet_group.aurora.name
}

output "aurora_sg_id" {
  value = aws_security_group.aurora.id
}





