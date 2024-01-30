provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      Environment = "Test"
      Repo        = "platformod/terraform-aws-cloudtrail-s3"
      CI          = true
    }
  }
}

variables {
  name = "test-8388737"
  account_trails = [
    {account = 111111111111, arn = "arn:aws:cloudtrail:us-fake-1:111111111111:trail/trail-name"},
    {account = 222222222222, arn = "arn:aws:cloudtrail:us-fake-1:222222222222:trail/trail-name"},
  ]
}

run "apply" {
  command = apply

  assert {
    condition     = module.bucket.s3_bucket_id == "test-8388737-cloudtrail"
    error_message = "S3 bucket name did not match expected"
  }
}
