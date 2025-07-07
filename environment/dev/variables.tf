variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"

}

variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
  default     = "ogb-aurora"
}
variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Project     = "ogb-aurora-tf-proj"
    Owner       = "ogb3"
    ManagedBy   = "terraform"
  }
}

variable "master_user" {
  description = "Master username for the RDS instance"
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