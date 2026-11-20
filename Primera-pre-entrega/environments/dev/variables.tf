variable "project_name" {
  type        = string
  description = "Nombre base del proyecto"
}

variable "env" {
  type        = string
  description = "Entorno de despliegue"
}

variable "aws_region" {
  type        = string
  description = "Región de AWS / LocalStack"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR principal de la VPC"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs de las subredes privadas"
}

variable "azs" {
  type        = list(string)
  description = "Zonas de disponibilidad"
}

variable "lakehouse_bucket_name" {
  type        = string
  description = "Nombre del bucket S3 del lakehouse"
}

variable "lakehouse_prefix" {
  type        = string
  description = "Prefijo S3 para el rol de procesamiento"
}
