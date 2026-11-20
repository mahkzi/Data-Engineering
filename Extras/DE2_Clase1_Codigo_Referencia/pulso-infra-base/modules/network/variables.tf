variable "name_prefix" {
  description = "Prefijo de nombres, p. ej. pulso-dev"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC de datos"
  type        = string
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr debe ser un CIDR IPv4 válido, p. ej. 10.20.0.0/16."
  }
}

variable "private_subnets" {
  description = "Mapa AZ => CIDR de cada subred privada (mínimo 2 AZ)"
  type        = map(string)
  validation {
    condition     = length(var.private_subnets) >= 2
    error_message = "Se requieren al menos 2 subredes privadas en AZ distintas."
  }
}

variable "region" {
  description = "Región AWS (se usa para armar el service_name del endpoint)"
  type        = string
}

variable "tags" {
  description = "Tags comunes"
  type        = map(string)
  default     = {}
}
