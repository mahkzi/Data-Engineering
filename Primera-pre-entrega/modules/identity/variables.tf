variable "project_name" {
  type        = string
  description = "Nombre base del proyecto o plataforma"
}

variable "env" {
  type        = string
  description = "Nombre del entorno (ej. dev, prod)"
}

variable "lakehouse_bucket_name" {
  type        = string
  description = "Nombre del bucket S3 del lakehouse"
}

variable "lakehouse_prefix" {
  type        = string
  description = "Prefijo dentro del bucket S3 acotado para lectura/escritura de datos"
}
