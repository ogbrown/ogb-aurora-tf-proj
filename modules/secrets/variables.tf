variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
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

variable "db_url" {
  description = "URL of the database to create in the RDS instance"
  type        = string
}
variable "db_name" {
  description = "Name of the database to create in the RDS instance"
  type        = string
}

variable "tags" {
  type = map(string)
}
variable "aurora_db_app_secret_name" {
  description = "Name of the AWS Secrets Manager secret for the Aurora DB application credentials"
  type        = string
}
variable "kms_key_id" {
  description = "ID of the KMS key to use for encryption"
  type        = string
}