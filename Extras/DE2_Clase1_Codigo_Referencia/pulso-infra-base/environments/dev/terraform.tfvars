environment = "dev"
owner       = "equipo-data-eng"
cost_center = "CC-1042"
vpc_cidr    = "10.20.0.0/16"

private_subnets = {
  "us-east-1a" = "10.20.1.0/24"
  "us-east-1b" = "10.20.2.0/24"
}

data_lake_buckets = {
  bronze = { versioning_enabled = true }
  silver = { versioning_enabled = true }
  gold   = { versioning_enabled = false }
}
