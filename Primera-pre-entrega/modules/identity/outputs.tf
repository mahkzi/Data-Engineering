output "data_processing_role_arn" {
  description = "ARN del rol IAM para servicios de procesamiento de datos"
  value       = aws_iam_role.data_processing.arn
}

output "control_plane_audit_role_arn" {
  description = "ARN del rol IAM de auditoría para el plano de control"
  value       = aws_iam_role.control_plane_audit.arn
}
