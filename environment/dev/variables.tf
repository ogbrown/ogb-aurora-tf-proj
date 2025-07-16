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

variable "bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}