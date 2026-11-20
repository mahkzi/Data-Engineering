variable "name_prefix" {
  description = "Prefijo de nombres (entorno), p. ej. pulso-dev"
  type        = string
}

variable "buckets" {
  description = "Buckets del data lake DENTRO de un entorno: capa => configuración"
  type = map(object({
    versioning_enabled = bool
  }))
  validation {
    condition     = alltrue([for k in keys(var.buckets) : can(regex("^[a-z0-9-]{3,20}$", k))])
    error_message = "Las claves de buckets deben ser minúsculas, números o guiones (3 a 20 caracteres)."
  }
}

variable "force_destroy" {
  description = "Permite borrar buckets con objetos (solo para entornos efímeros)"
  type        = bool
  default     = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
