output "enabled" {
  description = "Enabled property of module"
  value       = module.main.enabled
}

output "user_name" {
  description = "Normalized IAM user name"
  value       = module.main.user_name
}

output "user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = module.main.user_arn
}

output "user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = module.main.user_unique_id
}

output "access_key_id" {
  description = "The access key ID"
  value       = module.main.access_key_id
}

output "secret_access_key" {
  sensitive   = true
  description = "The secret access key. This will be written to the state file in plain-text"
  value       = module.main.secret_access_key
}

output "use_fullname" {
  value       = module.main.use_fullname
  description = "return if enabled use fullname"
}
