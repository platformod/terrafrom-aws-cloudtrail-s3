# AWS S3 Bucket for Multi-Account Cloudtrail Storage Terraform module

Terraform module which creates an AWS S3 Bucket for Multi-Account Cloudtrail logs.  

This is an opinionated tool for setting up a central bucket in an audit account to house multiple cloudtrail logs streams.  Not recommended for trails with data events due to cost.

Features:
- AWS S3 default encryption for data at rest
- 365 day object lock in GOVERNANCE mode to prevent source file issues
- 366 day auto expiration

## Usage

```hcl
module "cloudtrail_s3" {
  source = "platformod/cloudtrail-s3"
  version = 0.CHANGE_ME

  # will get '-cloudtrail' appended
  name = "my-org-all-accounts"

  # Needs a list of maps with the accounts and trail arn that will write to this bucket.
  account_trails = [
    {account = 111111111111, arn = "arn:aws:cloudtrail:us-east-99:111111111111:trail/trail-name"},
    {account = 222222222222, arn = "arn:aws:cloudtrail:us-westish-42:222222222222:trail/trailier-name"},
  ]
}

```

- [Complete](complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.41.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_trails"></a> [account\_trails](#input\_account\_trails) | Mapping of AWS account id's to trail arns to allow write access for | <pre>list(<br>    object(<br>      {<br>        account = number<br>        arn     = string<br>      }<br>    )<br>  )</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A name prefix for the bucket, will have '-cloudtrail' appended | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The AWS ARN of the bucket |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The name of the bucket |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Tests

The tests in this repo will create and destroy real resources at AWS and incur cost.  Please be careful when running them.

## Thanks

Heavily inspired from the following repos
* https://github.com/cloudposse/terraform-aws-s3-log-storage
* https://github.com/terraform-aws-modules/terraform-aws-s3-bucket

## License

MPL-2.0 Licensed. See [LICENSE](LICENSE).
