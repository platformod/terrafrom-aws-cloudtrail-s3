module "bucket" {
  #checkov:skip=CKV_TF_1:We want to use the registry, not git, for modules
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.0"

  bucket = local.bucket_name

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  acl                 = "private"
  block_public_acls   = true
  block_public_policy = true

  policy                                = data.aws_iam_policy_document.bucket.json
  attach_policy                         = true
  attach_deny_insecure_transport_policy = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  object_lock_enabled = true
  object_lock_configuration = {
    rule = {
      default_retention = {
        mode = "GOVERNANCE"
        days = 365
      }
    }
  }

  lifecycle_rule = [
    {
      id                                     = "expire_old"
      enabled                                = true
      abort_incomplete_multipart_upload_days = 7
      expiration = {
        days                         = 366
        expired_object_delete_marker = true
      }
    }
  ]

  tags = {
    Purpose = "cloudtrail"
    Name    = local.bucket_name
  }

}

# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-set-bucket-policy-for-multiple-accounts.html
data "aws_iam_policy_document" "bucket" {
  statement {
    sid = "AWSCloudTrailAclCheck"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      module.bucket.s3_bucket_arn,
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [for o in var.account_trails : o.arn]
    }
  }

  statement {
    sid = "AWSCloudTrailWrite"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [for o in var.account_trails : "${local.bucket_arn}/AWSLogs/${o.account}/*"]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [for o in var.account_trails : o.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

  }
}

data "aws_partition" "current" {}

locals {
  bucket_name = "${var.name}-cloudtrail"
  bucket_arn  = "arn:${data.aws_partition.current.partition}:s3:::${local.bucket_name}"
}
