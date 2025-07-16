resource "aws_kms_key" "secret_key" {
  description         = "KMS key for encrypting Aurora DB secret"
  enable_key_rotation = true
  tags                = var.tags
}

resource "aws_iam_role" "aurora_secret_access" {
  name = "aurora-secret-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Change this to the AWS service or account as needed
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "aurora_secret_kms_policy" {
  name        = "AuroraSecretKMSPolicy"
  description = "Policy to allow access to Aurora secret and its KMS key"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowSecretsManagerReadWrite"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecret",
          "secretsmanager:ListSecrets"
        ]
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:${var.short_project_name}-secret-*"
      },
      {
        Sid = "AllowKMSDecryptForSecret"
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ]
        Resource = "arn:aws:kms:${var.aws_region}:${data.aws_caller_identity.current.account_id}:key/${aws_kms_key.secret_key.id}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aurora_secret_access_attach" {
  role       = aws_iam_role.aurora_secret_access.name
  policy_arn = aws_iam_policy.aurora_secret_kms_policy.arn
}