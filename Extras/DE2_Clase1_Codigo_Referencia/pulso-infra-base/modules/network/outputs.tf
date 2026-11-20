output "vpc_id" {
  description = "ID de la VPC de datos"
  value       = aws_vpc.this.id
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas, por AZ"
  value       = { for az, s in aws_subnet.private : az => s.id }
}

output "s3_endpoint_id" {
  description = "ID del Gateway Endpoint de S3 (para usar en bucket policies: aws:sourceVpce)"
  value       = aws_vpc_endpoint.s3.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}
