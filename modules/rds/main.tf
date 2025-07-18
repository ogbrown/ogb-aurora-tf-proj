locals {
  raw_string = var.db_name
  parts = split("-", local.raw_string)
  remaining_parts = concat([lower(local.parts[0])],[for p in slice(local.parts, 1, length(local.parts)) : title(lower(p))])
  db_name = join("", local.remaining_parts)
}

resource "aws_rds_cluster" "aurora_serverless_v2" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-postgresql"
  engine_version          = "15.4" # Use a valid and available version in your region
  database_name           = local.db_name
  master_username         = jsondecode(data.aws_secretsmanager_secret_version.aurora_secret_version.secret_string)["username"]
  master_password         = jsondecode(data.aws_secretsmanager_secret_version.aurora_secret_version.secret_string)["password"]
  backup_retention_period = 1
  preferred_backup_window = "07:00-09:00"

  storage_encrypted       = true
  kms_key_id              = var.kms_key_arn # Specify your KMS key ARN here
  skip_final_snapshot     = true

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 1.0
  }

  # VPC, subnet, and security group configuration required
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = [var.aurora_security_group_id]

  # Optional: Enable deletion protection = false to allow tear-down for dev/test
  deletion_protection     = false

  tags = var.tags
}

resource "aws_rds_cluster_instance" "aurora_serverless_v2_instance" {
  identifier              = "${var.cluster_identifier}-instance"
  cluster_identifier      = aws_rds_cluster.aurora_serverless_v2.id
  instance_class          = var.instance_class # e.g., "db.serverless" for Aurora Serverless v2
  engine                  = aws_rds_cluster.aurora_serverless_v2.engine
  engine_version          = aws_rds_cluster.aurora_serverless_v2.engine_version
  publicly_accessible     = true # set to true if you need external access
  # Only 1 instance for cheapest option
  tags = var.tags
}

resource "null_resource" "setup_app_user" {
  depends_on = [aws_rds_cluster_instance.aurora_serverless_v2_instance]

  provisioner "local-exec" {
    command = <<EOT
    PGPASSWORD="${aws_rds_cluster.aurora_serverless_v2.master_password}" psql \
      --host=${aws_rds_cluster.aurora_serverless_v2.endpoint} \
      --port=5432 \
      --username="${aws_rds_cluster.aurora_serverless_v2.master_username}" \
      --dbname=${local.db_name} \
      --file=create_app_user.sql
    EOT
  }
}