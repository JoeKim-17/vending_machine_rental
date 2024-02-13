# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  default     = "eu-west-1"
  description = "AWS region"
}

variable "db_password" {
  description = "RDS root user password"
  sensitive   = false
}
