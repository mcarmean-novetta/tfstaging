bucket_name = "mcarmean-tf-dynamic-blocks-123"
bucket_tags = {
  tagged    = "yes"
  terraform = "ofCourse"
}
bucket_acl = "private"

lifecycle_rules = [{
  id                                     = "noexp"
  enabled                                = "true"
  prefix                                 = "thePrefix/"
  tags                                   = null
  abort_incomplete_multipart_upload_days = 7

  expiration = null

  transition = [{
        days = 30
        storage_class = "STANDARD_IA"
    },
    {
        days = 90
        storage_class = "GLACIER"
    }]
  },
  {
    id                                     = "expiredobjdel"
    enabled                                = "true"
    prefix                                 = null
    tags                                   = { lcp = "testing", lcp2 = "mapWorked" }
    abort_incomplete_multipart_upload_days = null

    expiration = {
      date = null
      days = 45
      expired_object_delete_marker = true
    }

    transition = [{
        days = 31
        storage_class = "STANDARD_IA"
    }]
  },
  {
    id                                     = "thisIsMyTransitionRule"
    enabled                                = "true"
    prefix                                 = "thePrefix4/"
    tags                                   = null
    abort_incomplete_multipart_upload_days = 7

    expiration = {
      date = null
      days = 95
      expired_object_delete_marker = null
    }

    transition = [{
        days = 45
        storage_class = "STANDARD_IA"
    }]
}]