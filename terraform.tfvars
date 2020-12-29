bucket_name = "mcarmean-tf-dynamic-blocks-mpu"
bucket_tags = {
  tagged    = "yes"
  terraform = "ofCourse"
}
bucket_acl = "private"

lifecycle_rules = [{
  id                                     = "thisIsMyLifecycle"
  enabled                                = "true"
  prefix                                 = "thePrefix/"
  tags                                   = null
  abort_incomplete_multipart_upload_days = 7

  expiration = [{
    days = 95
  }]

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
    id                                     = "myLifecyclePart2"
    enabled                                = "true"
    prefix                                 = null
    tags                                   = { lcp = "testing", lcp2 = "mapWorked" }
    abort_incomplete_multipart_upload_days = 0

    expiration = [{
      days = 45
    }]

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

    expiration = [{
      days = 95
    }]

    transition = [{
        days = 45
        storage_class = "STANDARD_IA"
    }]
}]