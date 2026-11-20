data "aws_caller_identity" "current" {}

# ---------- Rol de EJECUCIÓN (identidad de máquina) ----------
data "aws_iam_policy_document" "procesamiento_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      # Lambda hoy; Managed Service for Apache Flink (Clase 4) más adelante.
      identifiers = ["lambda.amazonaws.com", "kinesisanalytics.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "procesamiento" {
  name               = "${var.name_prefix}-rol-procesamiento"
  assume_role_policy = data.aws_iam_policy_document.procesamiento_trust.json
  tags               = var.tags
}

data "aws_iam_policy_document" "procesamiento_s3" {
  # ListBucket se evalúa sobre el BUCKET (no sobre objetos) y se acota con s3:prefix.
  statement {
    sid       = "ListarSoloPrefijo"
    actions   = ["s3:ListBucket"]
    resources = [var.data_bucket_arn]
    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values   = ["${var.allowed_prefix}*"]
    }
  }
  # GetObject / PutObject se evalúan sobre OBJETOS: bucket/prefijo/*
  statement {
    sid       = "LeerEscribirPrefijo"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["${var.data_bucket_arn}/${var.allowed_prefix}*"]
  }
}

resource "aws_iam_policy" "procesamiento_s3" {
  name        = "${var.name_prefix}-procesamiento-s3"
  description = "Mínimo privilegio: lectura/escritura sobre un único prefijo del data lake"
  policy      = data.aws_iam_policy_document.procesamiento_s3.json
}

resource "aws_iam_role_policy_attachment" "procesamiento_s3" {
  role       = aws_iam_role.procesamiento.name
  policy_arn = aws_iam_policy.procesamiento_s3.arn
}

# ---------- Rol de AUDITORÍA (identidad humana, solo lectura) ----------
data "aws_iam_policy_document" "auditoria_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "auditoria" {
  name               = "${var.name_prefix}-rol-auditoria"
  assume_role_policy = data.aws_iam_policy_document.auditoria_trust.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "auditoria" {
  role       = aws_iam_role.auditoria.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
