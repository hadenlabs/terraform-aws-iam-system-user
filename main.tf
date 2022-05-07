locals {
  input = {
    create_iam_access_key = var.create_iam_access_key
    enabled               = var.enabled
    force_destroy         = var.force_destroy
    inline_policies       = var.inline_policies
    inline_policies_map   = var.inline_policies_map
    name                  = var.name
    prefix                = var.prefix
    namespace             = var.namespace
    path                  = var.path
    permissions_boundary  = var.permissions_boundary
    policy_arns           = var.policy_arns
    policy_arns_map       = var.policy_arns_map
    stage                 = var.stage
    use_fullname          = var.use_fullname
    tags                  = var.tags

  }
}

locals {

  generated = {
    create_iam_access_key = local.input.create_iam_access_key
    enabled               = local.input.enabled
    force_destroy         = local.input.force_destroy
    inline_policies       = local.input.inline_policies
    prefix                = local.input.prefix
    name                  = length(local.input.prefix) > 0 ? format("%s-%s", local.input.prefix, local.input.name) : local.input.name
    namespace             = local.input.namespace
    path                  = local.input.path
    permissions_boundary  = local.input.permissions_boundary
    policy_arns           = local.input.policy_arns
    stage                 = local.input.stage
    use_fullname          = local.input.use_fullname
    tags                  = local.input.tags
    # policies -- inline and otherwise
    inline_policies_map = merge(
      local.input.inline_policies_map,
      { for i in local.input.inline_policies : md5(i) => i }
    )
    policy_arns_map = merge(
      local.input.policy_arns_map,
      { for i in local.input.policy_arns : i => i }
    )
  }

}

locals {

  outputs = {

    create_iam_access_key = local.generated.create_iam_access_key
    enabled               = local.generated.enabled
    force_destroy         = local.generated.force_destroy
    inline_policies       = local.generated.inline_policies
    inline_policies_map   = local.generated.inline_policies_map
    namespace             = local.generated.namespace
    path                  = local.generated.path
    permissions_boundary  = local.generated.permissions_boundary
    policy_arns           = local.generated.policy_arns
    policy_arns_map       = local.generated.policy_arns_map
    stage                 = local.generated.stage
    use_fullname          = local.generated.use_fullname
    name                  = local.generated.name
    prefix                = local.generated.prefix
    tags = merge(local.generated.tags, {
      Name = local.generated.name
    })
  }
}

locals {
  username   = join("", aws_iam_user.this.*.name)
  access_key = local.outputs.create_iam_access_key ? aws_iam_access_key.this : null
}

module "tags" {
  source    = "hadenlabs/tags/null"
  version   = ">=0.2"
  namespace = local.outputs.namespace
  stage     = local.outputs.stage
  name      = local.outputs.name
  tags      = local.outputs.tags
}

# Defines a user that should be able to write to you test bucket
resource "aws_iam_user" "this" {
  depends_on = [
    module.tags,
  ]
  count                = local.outputs.enabled ? 1 : 0
  name                 = local.outputs.use_fullname ? module.tags.id_full : local.outputs.name
  path                 = local.outputs.path
  force_destroy        = local.outputs.force_destroy
  tags                 = local.outputs.tags
  permissions_boundary = local.outputs.permissions_boundary
}

# Generate API credentials
resource "aws_iam_access_key" "this" {
  count = local.outputs.enabled ? 1 : 0
  user  = local.username
}

resource "aws_iam_user_policy" "inline_policies" {
  #bridgecrew:skip=BC_AWS_IAM_16:Skipping `Ensure IAM policies are attached only to groups or roles` check because this module intentionally attaches IAM policy directly to a user.
  for_each = local.outputs.enabled ? local.outputs.inline_policies_map : {}
  lifecycle {
    create_before_destroy = true
  }
  user   = local.username
  policy = each.value
}

resource "aws_iam_user_policy_attachment" "policies" {
  #bridgecrew:skip=BC_AWS_IAM_16:Skipping `Ensure IAM policies are attached only to groups or roles` check because this module intentionally attaches IAM policy directly to a user.
  for_each = local.outputs.enabled ? local.outputs.policy_arns_map : {}
  lifecycle {
    create_before_destroy = true
  }
  user       = local.username
  policy_arn = each.value
}
