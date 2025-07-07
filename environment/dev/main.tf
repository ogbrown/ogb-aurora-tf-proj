
locals {
  global_tags = merge(
    var.tags,
    {
      LastApplied = timestamp()
    }
  )
}
data "aws_caller_identity" "current" {}
module "s3" {
  source             = "../../modules/s3"
  aws_region         = var.aws_region
  short_project_name = var.short_project_name
  bucket_name        = var.bucket_name
  tags               = local.global_tags
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
  source                   = "../../modules/rds"
  short_project_name       = var.short_project_name
  vpc_id                   = module.net.vpc_id
  aurora_security_group_id = module.net.aurora_sg_id
  cluster_identifier       = "${var.short_project_name}-202507-cheapest-v2-dev"
  db_name                  = "${var.short_project_name}-20250706-ex-db"
  master_user              = var.master_user
  instance_class           = "db.serverless" # Required for Aurora Serverless v2
  db_subnet_group_name     = module.net.subnet_group_name
  rotation_lambda_arn      = "arn:aws:lambda:${var.aws_region}:${data.aws_caller_identity.current.account_id}:function:SecretsManagerRDSPostgreSQLRotationSingleUser"
  tags                     = local.global_tags
}

