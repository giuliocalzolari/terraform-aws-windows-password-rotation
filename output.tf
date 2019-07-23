output "iam_role_name" {
  description = "IAM role name"
  value       = "${aws_iam_role.role.name}"
}
output "iam_role_arn" {
  description = "IAM role ARN"
  value       = "${aws_iam_role.role.arn}"
}
output "ssm_maintenance_window" {
  description = "SSM maintenance window id"
  value       = "${aws_ssm_maintenance_window.window.id}"
}
output "ssm_maintenance_window_target" {
  description = "SSM maintenance window target id"
  value       = "${aws_ssm_maintenance_window_target.target.id}"
}
output "kms_id" {
  description = "KMS id used"
  value       = "${local.kms_id}"
}

