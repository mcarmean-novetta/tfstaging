
provider "aws" {
  profile = "mcarmean-WR"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.bucket_acl

  tags = var.bucket_tags

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules

    content {
      id                                     = lifecycle_rule.value.id
      enabled                                = lifecycle_rule.value.enabled
      prefix                                 = lifecycle_rule.value.prefix
      tags                                   = lifecycle_rule.value.tags
      abort_incomplete_multipart_upload_days = lifecycle_rule.value.abort_incomplete_multipart_upload_days

      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration

        content {
          days = expiration.value.days
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value.transition

        content {
          days = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

    }

  }
}

/*
Error putting S3 lifecycle: InvalidRequest: AbortIncompleteMultipartUpload cannot be specified with Tags.
AbortMPU set to 0 disables. AbortMPU cannot be applied with tag filter enabled
*/


