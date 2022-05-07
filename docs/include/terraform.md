<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.20, < 2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.51, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.51, < 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | hadenlabs/tags/null | >=0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.inline_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy_attachment.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_iam_access_key"></a> [create\_iam\_access\_key](#input\_create\_iam\_access\_key) | Whether or not to create IAM access keys | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Destroy the user even if it has non-Terraform-managed IAM access keys, login profile or MFA devices | `bool` | `false` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | Inline policies to attach to our created user | `list(string)` | `[]` | no |
| <a name="input_inline_policies_map"></a> [inline\_policies\_map](#input\_inline\_policies\_map) | Inline policies to attach (descriptive key => policy) | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the user | `string` | `"/system/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | Permissions Boundary ARN to attach to our created user | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | Policy ARNs to attach to our created user | `list(string)` | `[]` | no |
| <a name="input_policy_arns_map"></a> [policy\_arns\_map](#input\_policy\_arns\_map) | Policy ARNs to attach (descriptive key => arn) | `map(string)` | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | prefix name for user | `string` | `"system"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_use_fullname"></a> [use\_fullname](#input\_use\_fullname) | If set to 'true' then the full ID for the IAM user name (e.g. `[var.namespace]-[var.stage]-[var.name]`) will be used. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | The access key ID |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Enabled property of module |
| <a name="output_secret_access_key"></a> [secret\_access\_key](#output\_secret\_access\_key) | The secret access key. This will be written to the state file in plain-text |
| <a name="output_use_fullname"></a> [use\_fullname](#output\_use\_fullname) | return if enabled use fullname |
| <a name="output_user_arn"></a> [user\_arn](#output\_user\_arn) | The ARN assigned by AWS for this user |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | Normalized IAM user name |
| <a name="output_user_unique_id"></a> [user\_unique\_id](#output\_user\_unique\_id) | The unique ID assigned by AWS |
<!-- END_TF_DOCS -->