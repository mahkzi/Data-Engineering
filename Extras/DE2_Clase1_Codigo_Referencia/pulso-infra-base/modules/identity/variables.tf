variable "name_prefix" {
  type = string
}

variable "data_bucket_arn" {
  description = "ARN del bucket donde escribe el procesamiento"
  type        = string
}

variable "allowed_prefix" {
  description = "Prefijo (sin barra inicial) al que se limita el acceso, p. ej. silver/"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9_-]+/$", var.allowed_prefix))
    error_message = "allowed_prefix debe terminar en '/' y no empezar con '/', p. ej. silver/."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}
