<!--


  ** DO NOT EDIT THIS FILE
  **
  ** 1) Make all changes to `provision/generator/README.yaml`
  ** 2) Run`task readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **


  -->

[![Latest Release](https://img.shields.io/github/release/hadenlabs/terraform-aws-iam-system-user)](https://github.com/hadenlabs/terraform-aws-iam-system-user/releases) [![Lint](https://img.shields.io/github/workflow/status/hadenlabs/terraform-aws-iam-system-user/lint-code)](https://github.com/hadenlabs/terraform-aws-iam-system-user/actions?workflow=lint-code) [![CI](https://img.shields.io/github/workflow/status/hadenlabs/terraform-aws-iam-system-user/ci)](https://github.com/hadenlabs/terraform-aws-iam-system-user/actions?workflow=ci) [![Test](https://img.shields.io/github/workflow/status/hadenlabs/terraform-aws-iam-system-user/test)](https://github.com/hadenlabs/terraform-aws-iam-system-user/actions?workflow=test) [![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit) [![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow)](https://conventionalcommits.org) [![KeepAChangelog](https://img.shields.io/badge/changelog-Keep%20a%20Changelog%20v1.0.0-orange)](https://keepachangelog.com) [![Terraform Version](https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases) [![AWS Provider Version](https://img.shields.io/badge/AWS-3%20and%202.0+-F8991D.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-aws/releases)

# terraform-aws-iam-system-user

terraform-aws-iam-system-user for project

## Requirements

This is a list of plugins that need to be installed previously to enjoy all the goodies of this configuration:

- [gomplate](https://github.com/hairyhenderson/gomplate)
- [terraform](https://github.com/hashicorp/terraform)
- [python](https://www.python.org)
- [taskfile](https://github.com/go-task/task)

## Usage

# How to use this project

```hcl
  module "main" {
    source  = "hadenlabs/iam-system-user/aws"
    version = "0.1.0"
    namespace  = "gitlab"
    stage      = "dev"
    name       = "bot"
  }
```

Full working examples can be found in [examples](./examples) folder.

## Examples

<!-- Space: Projects -->
<!-- Parent: TerraformAwsIamSystemUser -->
<!-- Title: Examples TerraformAwsIamSystemUser -->

<!-- Label: Examples -->
<!-- Include: ./../disclaimer.md -->
<!-- Include: ac:toc -->

### common

```hcl
  module "main" {
    source  = "hadenlabs/iam-system-user/aws"
    version = "0.1.0"
  }
```

### Basic

#### data

```hcl
data "aws_iam_policy_document" "base_s3" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListObjects",
      "s3:ListBucket",
    ]
    effect = "Allow"

    resources = [
      "arn:aws:s3:::hadenlabs-core-backup",
    ]

  }
}

data "aws_iam_policy_document" "s3_policy" {
  source_json = data.aws_iam_policy_document.base_s3.json

  statement {
    actions = [
      "s3:ListAllMyBuckets"
    ]

    effect = "Allow"
    resources = [
      "arn:aws:s3:::*"
    ]

  }
}

module "s3_user" {
  source  = "hadenlabs/iam-system-user/aws"
  version = "0.1.0"
  namespace  = "gitlab"
  stage      = "dev"
  name       = "bot"

  policy_arns_map = {
    logs = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  }

  inline_policies_map = {
    s3 = data.aws_iam_policy_document.s3_policy.json
  }
}

```

#### use fullname

```hcl
data "aws_iam_policy_document" "base_s3" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListObjects",
      "s3:ListBucket",
    ]
    effect = "Allow"

    resources = [
      "arn:aws:s3:::hadenlabs-core-backup",
    ]

  }
}

data "aws_iam_policy_document" "s3_policy" {
  source_json = data.aws_iam_policy_document.base_s3.json

  statement {
    actions = [
      "s3:ListAllMyBuckets"
    ]

    effect = "Allow"
    resources = [
      "arn:aws:s3:::*"
    ]

  }
}

module "s3_user" {
  source  = "hadenlabs/iam-system-user/aws"
  version = "0.1.0"
  namespace  = "gitlab"
  stage      = "dev"
  name       = "bot"
  use_fullname = true

  policy_arns_map = {
    logs = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  }

  inline_policies_map = {
    s3 = data.aws_iam_policy_document.s3_policy.json
  }
}

```

 <!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version           |
| ------------------------------------------------------------------------ | ----------------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.12.20, < 2.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 2.51, < 4.0    |

## Providers

| Name                                             | Version        |
| ------------------------------------------------ | -------------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 2.51, < 4.0 |

## Modules

| Name                                            | Source              | Version |
| ----------------------------------------------- | ------------------- | ------- |
| <a name="module_tags"></a> [tags](#module_tags) | hadenlabs/tags/null | >=0.2   |

## Resources

| Name | Type |
| --- | --- |
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.inline_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy_attachment.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | :-: |
| <a name="input_create_iam_access_key"></a> [create_iam_access_key](#input_create_iam_access_key) | Whether or not to create IAM access keys | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force_destroy](#input_force_destroy) | Destroy the user even if it has non-Terraform-managed IAM access keys, login profile or MFA devices | `bool` | `false` | no |
| <a name="input_inline_policies"></a> [inline_policies](#input_inline_policies) | Inline policies to attach to our created user | `list(string)` | `[]` | no |
| <a name="input_inline_policies_map"></a> [inline_policies_map](#input_inline_policies_map) | Inline policies to attach (descriptive key => policy) | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input_name) | name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_path"></a> [path](#input_path) | Path in which to create the user | `string` | `"/system/"` | no |
| <a name="input_permissions_boundary"></a> [permissions_boundary](#input_permissions_boundary) | Permissions Boundary ARN to attach to our created user | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy_arns](#input_policy_arns) | Policy ARNs to attach to our created user | `list(string)` | `[]` | no |
| <a name="input_policy_arns_map"></a> [policy_arns_map](#input_policy_arns_map) | Policy ARNs to attach (descriptive key => arn) | `map(string)` | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input_prefix) | prefix name for user | `string` | `"system"` | no |
| <a name="input_stage"></a> [stage](#input_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_use_fullname"></a> [use_fullname](#input_use_fullname) | If set to 'true' then the full ID for the IAM user name (e.g. `[var.namespace]-[var.stage]-[var.name]`) will be used. | `bool` | `false` | no |

## Outputs

| Name | Description |
| --- | --- |
| <a name="output_access_key_id"></a> [access_key_id](#output_access_key_id) | The access key ID |
| <a name="output_enabled"></a> [enabled](#output_enabled) | Enabled property of module |
| <a name="output_secret_access_key"></a> [secret_access_key](#output_secret_access_key) | The secret access key. This will be written to the state file in plain-text |
| <a name="output_use_fullname"></a> [use_fullname](#output_use_fullname) | return if enabled use fullname |
| <a name="output_user_arn"></a> [user_arn](#output_user_arn) | The ARN assigned by AWS for this user |
| <a name="output_user_name"></a> [user_name](#output_user_name) | Normalized IAM user name |
| <a name="output_user_unique_id"></a> [user_unique_id](#output_user_unique_id) | The unique ID assigned by AWS |

<!-- END_TF_DOCS -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/hadenlabs/terraform-aws-iam-system-user/issues).

## Contributing

See [Contributing](./docs/contributing.md).

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)](https://semver.org/).

Using the given version number of `MAJOR.MINOR.PATCH`, we apply the following constructs:

1. Use the `MAJOR` version for incompatible changes.
1. Use the `MINOR` version when adding functionality in a backwards compatible manner.
1. Use the `PATCH` version when introducing backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- In the context of initial development, backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- In the context of pre-release, backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## Copyright

Copyright © 2018-2022 [Hadenlabs](https://hadenlabs.com)

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## License

The code and styles are licensed under the LGPL-3.0 license [See project license.](LICENSE).

## Don't forget to 🌟 Star 🌟 the repo if you like terraform-aws-iam-system-user

[Your feedback is appreciated](https://github.com/hadenlabs/terraform-aws-iam-system-user/issues)
