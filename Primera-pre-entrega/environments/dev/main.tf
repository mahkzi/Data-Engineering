module "network" {
  source = "../../modules/network"

  project_name         = var.project_name
  env                  = var.env
  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "identity" {
  source = "../../modules/identity"

  project_name          = var.project_name
  env                   = var.env
  lakehouse_bucket_name = var.lakehouse_bucket_name
  lakehouse_prefix      = var.lakehouse_prefix
}
