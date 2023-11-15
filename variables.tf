variable "appsvpc_id" {
}

variable "naming_suffix" {
  default     = false
  description = "Naming suffix for tags, value passed from dq-tf-apps"
}

variable "rds_from_port" {
  default     = 5432
  description = "From port for Postgres traffic"
}

variable "rds_to_port" {
  default     = 5432
  description = "To port for Postgres traffic"
}

variable "rds_protocol" {
  default     = "tcp"
  description = "Protocol for Postgres traffic"
}

variable "dq_lambda_subnet_cidr" {
  description = "Dedicated subnet for Lambda ENIs"
}

variable "dq_lambda_subnet_cidr_az2" {
  description = "Dedicated subnet for Lambda ENIs"
}

variable "apps_vpc_id" {
  default     = false
  description = "Value obtained from Apps module"
}

variable "route_table_id" {
  default     = false
  description = "Value obtained from Apps module"
}

variable "az" {
  default     = "eu-west-2a"
  description = "Default availability zone for the subnet."
}

variable "az2" {
  default     = "eu-west-2b"
  description = "Default availability zone for the subnet."
}

