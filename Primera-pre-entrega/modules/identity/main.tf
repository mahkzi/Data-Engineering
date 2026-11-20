locals {
  clean_prefix = trim(var.lakehouse_prefix, "/")
}

data "aws_iam_policy_document" "processing_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "kinesisanalytics.amazonaws.com"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "data_processing" {
  name               = "${var.project_name}-${var.env}-data-processing-role"
  assume_role_policy = data.aws_iam_policy_document.processing_assume_role.json

  tags = {
    Name        = "${var.project_name}-${var.env}-data-processing-role"
    Environment = var.env
    ManagedBy   = "terraform"
  }
}

data "aws_iam_policy_document" "data_processing_s3" {
  statement {
    sid    = "ListLakehouseBucket"
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.lakehouse_bucket_name}"
    ]
  }

  statement {
    sid    = "ReadWriteLakehousePrefix"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.lakehouse_bucket_name}/${local.clean_prefix}/*"
    ]
  }
}

resource "aws_iam_role_policy" "data_processing_s3" {
  name   = "${var.project_name}-${var.env}-data-processing-s3-policy"
  role   = aws_iam_role.data_processing.id
  policy = data.aws_iam_policy_document.data_processing_s3.json
}

data "aws_iam_policy_document" "control_plane_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "control_plane_audit" {
  name               = "${var.project_name}-${var.env}-control-plane-audit-role"
  assume_role_policy = data.aws_iam_policy_document.control_plane_assume_role.json

  tags = {
    Name        = "${var.project_name}-${var.env}-control-plane-audit-role"
    Environment = var.env
    ManagedBy   = "terraform"
  }
}

data "aws_iam_policy_document" "control_plane_read_only" {
  statement {
    sid    = "AuditReadOnlyInfrastructure"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
      "dynamodb:Describe*",
      "dynamodb:List*",
      "ec2:Describe*",
      "iam:Get*",
      "iam:List*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "control_plane_read_only" {
  name   = "${var.project_name}-${var.env}-control-plane-audit-policy"
  role   = aws_iam_role.control_plane_audit.id
  policy = data.aws_iam_policy_document.control_plane_read_only.json
}
