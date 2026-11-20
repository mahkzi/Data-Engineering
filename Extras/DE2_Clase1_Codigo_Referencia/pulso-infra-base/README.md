# Pulso · Plataforma de datos — Infraestructura base (Pre-entrega 1)

Infraestructura como código para el entorno **dev** de la plataforma de datos de Pulso
(e-commerce ficticio). Corre contra **LocalStack**: no necesitás cuenta de AWS.

## Qué crea

| Módulo | Recursos |
|---|---|
| `bootstrap/` | Bucket del state remoto (versionado, cifrado, sin acceso público, `prevent_destroy`) |
| `modules/network` | VPC de datos, 2 subredes privadas en AZ distintas, tabla de ruteo privada, **Gateway Endpoint de S3** |
| `modules/s3_data_lake` | Buckets `bronze`, `silver`, `gold` con cifrado, bloqueo de acceso público y versionado configurable |
| `modules/identity` | Rol de **procesamiento** (Lambda / Flink) con acceso solo a `silver/eventos/*` y rol de **auditoría** de solo lectura |

## Requisitos

- Docker Desktop (o Docker Engine) en ejecución
- Terraform **>= 1.11** (por el locking nativo en S3 con `use_lockfile`)
- AWS CLI v2 (opcional, para verificar)
- Cuenta gratuita de LocalStack y su Auth Token

## Cómo levantarlo

```bash
# 1. LocalStack
export LOCALSTACK_AUTH_TOKEN=ls-xxxx
docker compose up -d
curl -s localhost:4566/_localstack/health   # s3, iam, ec2, sts deben figurar como "available" o "running"

# 2. Bucket del state (state local, una sola vez)
cd bootstrap
terraform init
terraform apply

# 3. Entorno dev (state remoto en S3 con locking nativo)
cd ../environments/dev
terraform init
terraform plan -out=dev.tfplan     # esperado: Plan: 23 to add, 0 to change, 0 to destroy
terraform apply dev.tfplan
terraform output
```

## Verificación rápida

```bash
alias awsls='aws --endpoint-url=http://localhost:4566 --region us-east-1'
awsls s3 ls                                   # 4 buckets: tfstate + bronze/silver/gold
awsls s3 ls s3://pulso-tfstate-dev --recursive  # dev/plataforma/terraform.tfstate
awsls ec2 describe-vpc-endpoints --query 'VpcEndpoints[].[VpcEndpointType,ServiceName]'
```

## Limpieza

```bash
cd environments/dev && terraform destroy
# El bucket del state tiene prevent_destroy: se borra a mano si realmente querés eliminarlo.
```

> LocalStack Hobby no persiste datos entre reinicios del contenedor: si lo reiniciás,
> volvé a correr `bootstrap` y luego `terraform init -reconfigure` en `environments/dev`.
