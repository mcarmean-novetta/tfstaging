variable "bucket_name" {
  type        = string
  description = "This is the name of the bucket"
}

variable "bucket_acl" {
  type        = string
  description = "Bucket ACL setting"
  default     = "private"
}

variable "bucket_tags" {
  type = object({
    tagged    = string
    terraform = string
  })
  description = "Tags to be applied to bucket"
}

variable "lifecycle_rules" {
  type = list(object({
    id                                     = string
    enabled                                = string
    prefix                                 = string
    tags                                   = map(string)
    abort_incomplete_multipart_upload_days = number

    expiration = list(object({
      days = number
    }))

    transition = list(object({
      days = number
      storage_class = string
    }))
  }))
}
