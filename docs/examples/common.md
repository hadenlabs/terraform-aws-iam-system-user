<!-- Space: Projects -->
<!-- Parent: TerraformAwsIamSystemUser -->
<!-- Title: Examples TerraformAwsIamSystemUser -->

<!-- Label: Examples -->
<!-- Include: ./../disclaimer.md -->
<!-- Include: ac:toc -->

### common

```hcl
  module "main" {
    source  = "hadenlabs/terraform-aws-iam-system-user/aws"
    version = "0.0.0"
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
  source  = "hadenlabs/terraform-aws-iam-system-user/aws"
  version = "0.0.0"
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
  source  = "hadenlabs/terraform-aws-iam-system-user/aws"
  version = "0.0.0"
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
