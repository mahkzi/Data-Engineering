output "vpc_id" { value = module.network.vpc_id }
output "private_subnet_ids" { value = module.network.private_subnet_ids }
output "s3_endpoint_id" { value = module.network.s3_endpoint_id }
output "bucket_arns" { value = module.data_lake.bucket_arns }
output "procesamiento_role_arn" { value = module.identity.procesamiento_role_arn }
output "auditoria_role_arn" { value = module.identity.auditoria_role_arn }
