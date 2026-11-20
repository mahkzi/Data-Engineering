output "vpc_id" {
  description = "ID de la VPC creada en dev"
  value       = module.network.vpc_id
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas en dev"
  value       = module.network.private_subnet_ids
}

output "s3_gateway_endpoint_id" {
  description = "ID del S3 Gateway Endpoint en dev"
  value       = module.network.s3_gateway_endpoint_id
}

output "data_processing_role_arn" {
  description = "ARN del rol de procesamiento de datos"
  value       = module.identity.data_processing_role_arn
}

output "control_plane_audit_role_arn" {
  description = "ARN del rol de auditoría del plano de control"
  value       = module.identity.control_plane_audit_role_arn
}
