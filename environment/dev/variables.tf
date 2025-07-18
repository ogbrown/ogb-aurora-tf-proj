variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"

}


variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}
variable "tags" {
  type = map(string)
}

variable "master_user" {
  description = "Master username for the RDS instance"
  type        = string
}

variable "aurora_db_master_secret_name" {
  description = "Name of the AWS Secrets Manager secret for the Aurora DB master credentials"
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

variable "db_name" {
  description = "Name of the database to create in the RDS instance"
  type        = string
}

variable "cluster_identifier_suffix" {
  description = "Suffix for the cluster identifier to ensure uniqueness"
  type        = string

}


variable "vpc_name" {
  description = "Name of the VPC to use for the Aurora cluster"
  type        = string
}

variable "general_kms_key_alias" {
  description = "Alias of my KMS Key for Encrypt Decrypt operations"
  type        = string
}