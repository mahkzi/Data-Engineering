resource "aws_s3_bucket" "data_lake" {
  for_each      = var.buckets
  bucket        = "${var.name_prefix}-${each.key}"
  force_destroy = var.force_destroy
  tags          = merge(var.tags, { Layer = each.key })
}

# Versionado solo para las capas que lo piden (filtramos el mapa con un for).
resource "aws_s3_bucket_versioning" "versioning" {
  for_each = { for k, v in var.buckets : k => v if v.versioning_enabled }
  bucket   = aws_s3_bucket.data_lake[each.key].id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  for_each = aws_s3_bucket.data_lake
  bucket   = each.value.id
  rule {
    apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
  }
}

resource "aws_s3_bucket_public_access_block" "security" {
  for_each                = aws_s3_bucket.data_lake
  bucket                  = each.value.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
