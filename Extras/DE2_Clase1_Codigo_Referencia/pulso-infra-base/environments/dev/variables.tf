variable "region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  description = "Nombre del entorno"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment debe ser dev, staging o prod."
  }
}

variable "owner" {
  type = string
}

variable "cost_center" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnets" {
  type = map(string)
}

variable "data_lake_buckets" {
  type = map(object({ versioning_enabled = bool }))
}

variable "localstack_endpoint" {
  type    = string
  default = "http://localhost:4566"
}
