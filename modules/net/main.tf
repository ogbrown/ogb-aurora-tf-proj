# Get existing VPC by name tag
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["sbogb-vpc-e2"]
  }
}

# Data sources to get subnets in us-east-2c and us-east-2b
data "aws_subnet" "az_c" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "availability-zone"
    values = ["${var.aws_region}c"]
  }
}

data "aws_subnet" "az_b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "availability-zone"
    values = ["${var.aws_region}b"]
  }
}

resource "aws_security_group" "aurora" {
  name        = "${var.short_project_name}-sg"
  description = "Security group for Aurora PostgreSQL cluster"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For demonstration; restrict in production!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}


resource "aws_db_subnet_group" "aurora" {
  name       = "${var.short_project_name}-subnet-group"
  subnet_ids = [
    data.aws_subnet.az_c.id,
    data.aws_subnet.az_b.id
  ]
  tags       = var.tags
}
