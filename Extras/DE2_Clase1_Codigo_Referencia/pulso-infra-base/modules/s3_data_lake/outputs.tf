output "bucket_arns" {
  description = "Mapa capa => ARN (lo consume el módulo identity y, más adelante, Firehose)"
  value       = { for k, b in aws_s3_bucket.data_lake : k => b.arn }
}

output "bucket_names" {
  value = { for k, b in aws_s3_bucket.data_lake : k => b.bucket }
}
