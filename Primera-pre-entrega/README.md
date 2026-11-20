# Infraestructura Base — Pre-entrega 1 (Data Engineering)

Infraestructura como código modular con Terraform y LocalStack en `http://localhost:4566` para el entorno `dev`[cite: 2].

## Estructura del proyecto
* `docker-compose.yml`: levanta LocalStack, PostgreSQL y Apache Flink (`jobmanager` y `taskmanager`)[cite: 2].
* `modules/network`: crea la VPC, subredes privadas aisladas en distintas AZs y un S3 Gateway Endpoint asociado a la tabla de rutas privada[cite: 2].
* `modules/identity`: define el rol de procesamiento de datos (con `s3:ListBucket` en el bucket y `s3:GetObject` / `s3:PutObject` acotados a un prefijo) y el rol de auditoría de solo lectura para el plano de control[cite: 2].
* `environments/dev`: configura el backend remoto en S3 (con SSE) y DynamoDB para state locking, llama a los módulos y expone los outputs[cite: 2].
* `PLAN_OUTPUT.md`: registra las salidas de `tflocal plan`, `tflocal apply` y `aws --endpoint-url=http://localhost:4566 ec2 describe-vpc-endpoints`[cite: 2].

## Uso con LocalStack
1. Configurá `LOCALSTACK_AUTH_TOKEN` y levantá los servicios con `docker compose up -d`[cite: 2].
2. Creá el bucket S3 (con cifrado SSE) y la tabla DynamoDB usando `aws --endpoint-url=http://localhost:4566`[cite: 2].
3. Entrá a `environments/dev` y ejecutá `tflocal init`, `tflocal validate`, `tflocal plan` y `tflocal apply`[cite: 2].
