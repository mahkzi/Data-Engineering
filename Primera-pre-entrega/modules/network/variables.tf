variable "project_name" {
  type        = string
  description = "Nombre base del proyecto o plataforma"
}

variable "env" {
  type        = string
  description = "Nombre del entorno (ej. dev, prod)"
}

variable "aws_region" {
  type        = string
  description = "Region de AWS / LocalStack"
}

variable "vpc_cidr" {
  type        = string
  description = "Bloque CIDR de la VPC"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Lista de CIDRs para las subredes privadas"
}

variable "azs" {
  type        = list(string)
  description = "Zonas de disponibilidad para las subredes privadas"
}
