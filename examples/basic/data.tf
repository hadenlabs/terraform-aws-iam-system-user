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
      "arn:aws:s3:::bucket_name",
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
