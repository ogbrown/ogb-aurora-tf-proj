variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}
variable "vpc_id" {}
variable "aurora_security_group_id" {}
variable "cluster_identifier" {}
variable "master_user" {}
variable "aurora_db_master_secret_name" {
  description = "Name of the AWS Secrets Manager secret for the Aurora DB master credentials"
  type        = string
}
variable "kms_key_arn" {
  description = "ARN of the KMS key to use for encryption"
  type        = string
}
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