variable "short_project_name" {
  description = "Short name for the project, used in resource names"
  type        = string
}
variable "vpc_id" {}
variable "aurora_security_group_id" {}
variable "cluster_identifier" {}
variable "db_name" {}
variable "master_user" {}
variable "master_pwd" {}
variable "instance_class" {}
variable "instance_count" {
  default = 1
}
variable "db_subnet_group_name" {}

variable "rotation_lambda_arn" {}
variable "tags" {
  type = map(string)
}
