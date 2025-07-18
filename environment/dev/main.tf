locals {
  global_tags = merge(
    var.tags,
    {
      LastApplied = timestamp()
    }
  )
}
data "aws_caller_identity" "current" {}

data "aws_kms_key" "aurora_kms_key" {
  key_id = "alias/${var.general_kms_key_alias}" # Replace with your KMS key alias
}

module "net" {
  source = "../../modules/net"
  # pass networking vars
  aws_region         = var.aws_region
  short_project_name = var.short_project_name
  tags               = local.global_tags
  vpc_name           = var.vpc_name
}

module "rds" {
  source                       = "../../modules/rds"
  short_project_name           = var.short_project_name
  vpc_id                       = module.net.vpc_id
  aurora_security_group_id     = module.net.aurora_sg_id
  cluster_identifier           = "${var.short_project_name}-${var.cluster_identifier_suffix}"
  db_name                      = "${var.short_project_name}-${var.db_name}"
  db_user                      = var.db_user
  db_user_password             = var.db_user_password
  master_user                  = var.master_user
  aurora_db_master_secret_name = var.aurora_db_master_secret_name
  instance_class               = "db.serverless" # Required for Aurora Serverless v2
  db_subnet_group_name         = module.net.subnet_group_name
  rotation_lambda_arn          = "arn:aws:lambda:${var.aws_region}:${data.aws_caller_identity.current.account_id}:function:SecretsManagerRDSPostgreSQLRotationSingleUser"
  tags                         = local.global_tags
  kms_key_arn                  = data.aws_kms_key.aurora_kms_key.arn
}

module "secrets" {
  source                    = "../../modules/secrets"
  short_project_name        = var.short_project_name
  aurora_db_app_secret_name = var.aurora_db_app_secret_name
  kms_key_id                = data.aws_kms_key.aurora_kms_key.id
  db_name                   = "${var.short_project_name}-${var.db_name}"
  db_url                    = module.rds.cluster_endpoint
  db_user                   = var.db_user
  db_user_password          = var.db_user_password
  tags                      = local.global_tags
}

