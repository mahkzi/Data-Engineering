output "procesamiento_role_arn" { value = aws_iam_role.procesamiento.arn }
output "auditoria_role_arn" { value = aws_iam_role.auditoria.arn }
output "procesamiento_policy_json" {
  description = "Útil para revisar la política en clase"
  value       = data.aws_iam_policy_document.procesamiento_s3.json
}
