output "sagemaker_monitoring_schedules_id" {
  description = "Map of id values across all sagemaker_monitoring_schedules, keyed the same as var.sagemaker_monitoring_schedules"
  value       = { for k, v in aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedules : k => v.id if v.id != null && length(v.id) > 0 }
}
output "sagemaker_monitoring_schedules_arn" {
  description = "Map of arn values across all sagemaker_monitoring_schedules, keyed the same as var.sagemaker_monitoring_schedules"
  value       = { for k, v in aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedules : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "sagemaker_monitoring_schedules_monitoring_schedule_config" {
  description = "Map of monitoring_schedule_config values across all sagemaker_monitoring_schedules, keyed the same as var.sagemaker_monitoring_schedules"
  value       = { for k, v in aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedules : k => one(v.monitoring_schedule_config) if v.monitoring_schedule_config != null && length(v.monitoring_schedule_config) > 0 }
}
output "sagemaker_monitoring_schedules_name" {
  description = "Map of name values across all sagemaker_monitoring_schedules, keyed the same as var.sagemaker_monitoring_schedules"
  value       = { for k, v in aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedules : k => v.name if v.name != null && length(v.name) > 0 }
}
output "sagemaker_monitoring_schedules_region" {
  description = "Map of region values across all sagemaker_monitoring_schedules, keyed the same as var.sagemaker_monitoring_schedules"
  value       = { for k, v in aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedules : k => v.region if v.region != null && length(v.region) > 0 }
}
output "sagemaker_monitoring_schedules_tags" {
  description = "Map of tags values across all sagemaker_monitoring_schedules, keyed the same as var.sagemaker_monitoring_schedules"
  value       = { for k, v in aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedules : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "sagemaker_monitoring_schedules_tags_all" {
  description = "Map of tags_all values across all sagemaker_monitoring_schedules, keyed the same as var.sagemaker_monitoring_schedules"
  value       = { for k, v in aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedules : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

