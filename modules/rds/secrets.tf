resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()-_=+[]{}<>?~" # Specify valid special characters
}

resource "aws_secretsmanager_secret" "aurora_db_secret" {
  name = "${var.cluster_identifier}-secret"
  description = "Master credentials for Aurora PostgreSQL"
}

resource "aws_secretsmanager_secret_version" "aurora_db_secret_version" {
  secret_id     = aws_secretsmanager_secret.aurora_db_secret.id
  secret_string = jsonencode({
    username = var.master_user
    password = random_password.db_password.result
  })
}


# resource "aws_secretsmanager_secret_version" "aurora_secret_version" {
#   secret_id = aws_secretsmanager_secret.aurora_secret.id
#   secret_string = jsonencode({
#     username = var.master_username
#     password = random_password.master_password.result
#   })
# }

# locals {
#   secret_data = jsondecode(aws_secretsmanager_secret_version.aurora_secret.secret_string)
# }

# resource "aws_secretsmanager_secret_rotation" "aurora_secret" {
#   secret_id           = aws_secretsmanager_secret.aurora_secret.id
#   rotation_lambda_arn = var.rotation_lambda_arn
#   rotation_rules {
#     automatically_after_days = 30
#   }
# }

# resource "aws_secretsmanager_secret_rotation" "aurora_rotation" {
#   secret_id = aws_secretsmanager_secret.aurora_secret.id

#   rotation_lambda_arn = var.rotation_lambda_arn
#   rotation_rules {
#     automatically_after_days = 30
#   }

#   depends_on = [aws_rds_cluster.aurora_pg]
# }