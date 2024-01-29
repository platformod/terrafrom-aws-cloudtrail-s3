variable "account_trails" {
  description = "Mapping of AWS account id's to trail arns to allow write access for "
  type = object({
    account = number
    arn     = string
  })
}

variable "name" {
  description = "A name prefix for the bucket, will have '-cloudtrail' appended"
  type        = string
}
