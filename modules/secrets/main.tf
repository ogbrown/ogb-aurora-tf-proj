locals {
  raw_string = var.db_name
  parts = split("-", local.raw_string)
  remaining_parts = concat([lower(local.parts[0])],[for p in slice(local.parts, 1, length(local.parts)) : title(lower(p))])
  db_name = join("", local.remaining_parts)
}

data "aws_secretsmanager_secret" "aurora_app_secret" {
  name = var.aurora_db_app_secret_name
}

resource "aws_secretsmanager_secret_version" "aurora_app_secret_version" {
  secret_id = data.aws_secretsmanager_secret.aurora_app_secret.id
  secret_string = jsonencode({
    "spring.datasource.username" : var.db_user
    "spring.datasource.password" : var.db_user_password
    "spring.datasource.url": "jdbc:postgresql://${var.db_url}:5432/${local.db_name}"
  })
}


