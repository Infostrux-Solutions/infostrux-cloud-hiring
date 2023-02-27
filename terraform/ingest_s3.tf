module "ingest_s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.7.0"

  bucket = "${local.prefix}-s3-ingest-${random_string.random_str_5.id}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  #   control_object_ownership = true
  object_ownership = "BucketOwnerPreferred"

  attach_deny_insecure_transport_policy = false

  versioning = {
    enabled = false
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  # Only keep one year of logs
  lifecycle_rule = [
    {
      id      = "VPCFlowLogsRetention"
      enabled = true

      expiration = {
        days = 365
      }
    },
  ]

}

data "aws_iam_policy_document" "ingest_s3_bucket_policy" {
  statement {
    sid    = "denyInsecureTransport"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      module.ingest_s3.s3_bucket_arn,
      "${module.ingest_s3.s3_bucket_arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "ingest_s3_bucket_policy_attach" {
  bucket = module.ingest_s3.s3_bucket_id
  policy = data.aws_iam_policy_document.ingest_s3_bucket_policy.json
}
