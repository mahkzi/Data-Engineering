# Data Engineering — Coderhouse

Repositorio general del curso de **Data Engineering**, organizado como un espacio de trabajo modular donde cada entrega y etapa del proyecto se desarrolla en su propia carpeta, construyendo progresivamente una arquitectura de datos orientada a lakehouse y procesamiento de streaming.

## ¿De qué trata este repositorio?

A lo largo del cursado, este repositorio reúne la evolución práctica de la plataforma de datos: desde el andamiaje inicial de infraestructura como código y gobernanza hasta los componentes de ingesta, procesamiento y almacenamiento de datos.

El enfoque de trabajo busca mantener buenas prácticas de ingeniería de datos y DataOps:
* **Infraestructura modular y reproducible:** separación entre entornos y módulos reutilizables (`network`, `identity`, etc.) en lugar de configuraciones monolíticas o hardcodeadas.
* **Entorno local con emulación cloud:** uso de **LocalStack** (`http://localhost:4566`) junto con **Docker Compose** (LocalStack, PostgreSQL y Apache Flink) para probar y desplegar localmente sin depender de una cuenta de AWS real.
* **Seguridad y control de estado:** backend remoto para Terraform en S3 con cifrado y bloqueo de estado en DynamoDB, políticas IAM con menor privilegio y exclusión de secretos o archivos temporales mediante `.gitignore`.

## Estructura del repositorio

Cada entrega o módulo principal se segmenta en su propia carpeta en la raíz del repositorio:

* `Primera-pre-entrega/`: **Infraestructura Base con Entorno de Desarrollo e IAM Core**. Incluye la configuración de Docker Compose, backend remoto en S3 + DynamoDB, módulos de red (`network` con VPC, subredes privadas y S3 Gateway Endpoint) e identidad (`identity` con roles para procesamiento y auditoría), entorno `dev`, `README.md` específico y `PLAN_OUTPUT.md`.
* *Próximas entregas* (por ejemplo `Segunda-pre-entrega/`, `Entrega-final/`, etc.): se irán agregando en carpetas independientes dentro de este mismo repositorio a medida que avance el curso.

## Requisitos generales y puesta en marcha

Para trabajar sobre los proyectos del repositorio en entorno local se requiere:
* **Docker Desktop** en ejecución (se recomienda asignar al menos 8 GB de RAM).
* **Terraform** (`>= 1.5.0`), **AWS CLI** y **Python** (`>= 3.10`) con `terraform-local` (`tflocal`).
* Una cuenta y token de **LocalStack** configurados en un archivo `.env` local (nunca versionado en Git).

Para los pasos detallados de cada entrega —como levantar los contenedores, inicializar el backend y aplicar la infraestructura—, consultá el `README.md` dentro de la carpeta correspondiente (por ejemplo, `Primera-pre-entrega/README.md`).
