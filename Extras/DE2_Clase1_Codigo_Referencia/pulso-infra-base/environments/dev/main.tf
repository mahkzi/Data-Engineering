locals {
  name_prefix = "pulso-${var.environment}"
}

module "network" {
  source          = "../../modules/network"
  name_prefix     = local.name_prefix
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
  region          = var.region
}

module "data_lake" {
  source        = "../../modules/s3_data_lake"
  name_prefix   = local.name_prefix
  buckets       = var.data_lake_buckets
  force_destroy = var.environment == "dev" # en prod, jamás
}

# Composición: el output de un módulo es el input del siguiente.
module "identity" {
  source          = "../../modules/identity"
  name_prefix     = local.name_prefix
  data_bucket_arn = module.data_lake.bucket_arns["silver"]
  allowed_prefix  = "eventos/"
}
