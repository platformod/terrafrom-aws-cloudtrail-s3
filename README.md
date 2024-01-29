# AWS {{THING}} Terraform module

Terraform module which creates AWS {{THING}} resources.

## Usage

See [`examples`](examples) directory for working examples to reference:

```hcl
module "<THING>" {
  source = "platformod/<THING>"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Thanks

Heavily inspired from the following template repos
* https://github.com/clowdhaus/terraform-aws-module-template
* https://github.com/trussworks/terraform-module-template
* https://github.com/thesis/terraform-module-template-repo

## License

MPL-2.0 Licensed. See [LICENSE](LICENSE).
