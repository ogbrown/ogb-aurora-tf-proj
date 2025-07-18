data "aws_secretsmanager_secret" "aurora_secret" {
  name = var.aurora_db_master_secret_name
}

data "aws_secretsmanager_secret_version" "aurora_secret_version" {
  secret_id = data.aws_secretsmanager_secret.aurora_secret.id
}


