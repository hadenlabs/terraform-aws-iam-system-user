module "main" {
  source       = "../.."
  depends_on   = []
  enabled      = var.enabled
  name         = var.name
  use_fullname = var.use_fullname
  stage        = var.stage
  namespace    = var.namespace
  tags         = var.tags
  prefix       = var.prefix
  policy_arns_map = {
    logs = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  }

  inline_policies_map = {
    s3 = data.aws_iam_policy_document.s3_policy.json
  }
}
