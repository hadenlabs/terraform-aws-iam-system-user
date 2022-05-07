output "enabled" {
  description = "Enabled property of module"
  value       = local.outputs.enabled
}

output "user_name" {
  value       = local.username
  description = "Normalized IAM user name"
}

output "user_arn" {
  value       = join("", aws_iam_user.this.*.arn)
  description = "The ARN assigned by AWS for this user"
}

output "user_unique_id" {
  value       = join("", aws_iam_user.this.*.unique_id)
  description = "The unique ID assigned by AWS"
}

output "access_key_id" {
  value       = join("", local.access_key.*.id)
  description = "The access key ID"
}

output "secret_access_key" {
  sensitive   = true
  value       = join("", local.access_key.*.secret)
  description = "The secret access key. This will be written to the state file in plain-text"
}

output "use_fullname" {
  value       = local.outputs.use_fullname
  description = "return if enabled use fullname"
}
