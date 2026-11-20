terraform {
  backend "s3" {
    bucket       = "pulso-tfstate-dev"
    key          = "dev/plataforma/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true # locking nativo en S3 (Terraform >= 1.11). Reemplaza a dynamodb_table.

    # --- Solo para LocalStack: en AWS real se borran estas líneas ---
    access_key                  = "test"
    secret_key                  = "test"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    use_path_style              = true
    endpoints = {
      s3 = "http://localhost:4566"
    }
  }
}
