output "cluster_endpoint" {
  value = aws_rds_cluster.aurora_serverless_v2.endpoint
}

output "db_name" {
  value = local.db_name
}