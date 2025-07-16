variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}
variable "vpc_id" {}
variable "aurora_security_group_id" {}
variable "cluster_identifier" {}
variable "master_user" {}
variable "instance_class" {}
variable "instance_count" {
  default = 1
}
variable "db_subnet_group_name" {}

variable "rotation_lambda_arn" {}
variable "tags" {
  type = map(string)
}

variable "db_user" {
  description = "Database user for the RDS instance"
  type        = string
}

variable "db_user_password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the database to create in the RDS instance"
  type        = string
}