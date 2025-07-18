# ogb-aurora-tf-proj
Terraform for Aurora Postgres - Simple

Note: This project defaults to deploy in AWS to us-east-2

This project includes deployment of the following AWS resources:
- S3 Bucket - example
  - aws_s3_bucket
  - aws_s3_bucket_ownership_controls
- Networking
  - aws_security_group
  - aws_db_subnet_group
- Aurora
  - aws_rds_cluster
  - aws_rds_cluster_instance


## Useful Links

- [AWS RDS Documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
- [Terraform Resource: aws_rds_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster)
- [Connect to a PostgreSQL cluster deployed to Aurora](https://developer.hashicorp.com/terraform/enterprise/deploy/configuration/storage/connect-database/aurora)
- [Github terraform-aws-rds-aurora](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora)
- Read Later: [How to import existing Aurora PostgreSQL into terraform](https://repost.aws/questions/QUtWJJR7M4SqyXvqm-GborlQ/how-to-import-existing-aurora-postgresql-into-terraform)
- Read Later: [RDS + Aurora + MySQL + PostgreSQL + Bastion + Terraform](https://medium.com/@jerome.decoster/rds-aurora-mysql-postgresql-bastion-terraform-17c5a76aced8)