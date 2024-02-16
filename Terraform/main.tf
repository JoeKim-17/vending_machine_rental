provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.2"

  name                 = "renting"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  # azs                  = ["eu-west-1"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "renting" {
  name       = "renting"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "renting"
  }
}

resource "aws_security_group" "rds" {
  name   = "renting_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "renting_rds"
  }
}

resource "aws_db_parameter_group" "renting" {
  name   = "renting"
  family = "sqlserver-ex-15.0"
}

resource "aws_db_instance" "renting" {
  identifier             = "renting"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "sqlserver-ex"
  engine_version         = "15.00.4345.5.v1"
  username               = "edu"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.renting.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.renting.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
