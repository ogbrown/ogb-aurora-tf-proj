
tags = {
  Environment = "dev"
  Project     = "your-proj"
  Owner       = "your-name"
  ManagedBy   = "terraform"
}

short_project_name = "your-aurora"

master_user = "yourmasteruser"

vpc_name                  = "your-vpc-e2"             # Name of the VPC to use for the Aurora cluster
bucket_name               = "example-bucket-" # Name of the S3 bucket to create
cluster_identifier_suffix = "anything-dev-v2"           # Suffix for the cluster identifier to ensure uniqueness
db_name                   = "example-db"           # Name of the database to create in the RDS instance
db_user                   = "app_rw"                 # Database user for the RDS instance
db_user_password          = "replace_with_password_do_not_commit"      # Password for the database user
