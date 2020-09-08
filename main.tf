locals {
  naming_suffix = "lambda-${var.naming_suffix}"
}

resource "aws_subnet" "lambda_subnet" {
  vpc_id                  = var.appsvpc_id
  cidr_block              = var.dq_lambda_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone       = var.az

  tags = {
    Name = "subnet-${local.naming_suffix}"
  }
}

resource "aws_subnet" "lambda_subnet_az2" {
  vpc_id                  = var.appsvpc_id
  cidr_block              = var.dq_lambda_subnet_cidr_az2
  map_public_ip_on_launch = false
  availability_zone       = var.az2

  tags = {
    Name = "az2-subnet-${local.naming_suffix}"
  }
}

resource "aws_route_table_association" "internal_tableau_rt_association" {
  subnet_id      = aws_subnet.lambda_subnet.id
  route_table_id = var.route_table_id
}

resource "aws_route_table_association" "internal_tableau_rt_association_az2" {
  subnet_id      = aws_subnet.lambda_subnet_az2.id
  route_table_id = var.route_table_id
}

resource "aws_security_group" "sgrp" {
  vpc_id = var.appsvpc_id

  ingress {
    from_port = var.rds_from_port
    to_port   = var.rds_to_port
    protocol  = var.rds_protocol

    cidr_blocks = [
      var.dq_lambda_subnet_cidr,
      var.dq_lambda_subnet_cidr_az2,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${local.naming_suffix}"
  }
}
