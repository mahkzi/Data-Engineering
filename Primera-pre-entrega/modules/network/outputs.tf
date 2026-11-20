output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = aws_subnet.private[*].id
}

output "s3_gateway_endpoint_id" {
  description = "ID del S3 Gateway Endpoint"
  value       = aws_vpc_endpoint.s3_gateway.id
}
