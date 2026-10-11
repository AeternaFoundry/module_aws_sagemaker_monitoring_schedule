variable "sagemaker_monitoring_schedules" {
  description = <<EOT
Map of sagemaker_monitoring_schedules, attributes below
Required:
    - monitoring_schedule_config (block):
        - monitoring_job_definition (optional, block):
            - baseline (optional, block):
                - baselining_job_name (optional)
                - constraints_resource (optional, block):
                    - s3_uri (optional)
                - statistics_resource (optional, block):
                    - s3_uri (optional)
            - environment (optional)
            - monitoring_app_specification (required, block):
                - container_arguments (optional)
                - container_entrypoint (optional)
                - image_uri (required)
                - post_analytics_processor_source_uri (optional)
                - record_preprocessor_source_uri (optional)
            - monitoring_inputs (required, block):
                - batch_transform_input (optional, block):
                    - data_captured_destination_s3_uri (required)
                    - dataset_format (required, block):
                        - csv (optional, block):
                            - header (optional)
                        - json (optional, block):
                            - line (optional)
                    - end_time_offset (optional)
                    - exclude_features_attribute (optional)
                    - features_attribute (optional)
                    - inference_attribute (optional)
                    - local_path (required)
                    - probability_attribute (optional)
                    - probability_threshold_attribute (optional)
                    - s3_data_distribution_type (optional)
                    - s3_input_mode (optional)
                    - start_time_offset (optional)
                - endpoint_input (optional, block):
                    - end_time_offset (optional)
                    - endpoint_name (required)
                    - exclude_features_attribute (optional)
                    - features_attribute (optional)
                    - inference_attribute (optional)
                    - local_path (required)
                    - probability_attribute (optional)
                    - probability_threshold_attribute (optional)
                    - s3_data_distribution_type (optional)
                    - s3_input_mode (optional)
                    - start_time_offset (optional)
            - monitoring_output_config (required, block):
                - kms_key_id (optional)
                - monitoring_outputs (required, block):
                    - s3_output (required, block):
                        - local_path (required)
                        - s3_upload_mode (optional)
                        - s3_uri (required)
            - monitoring_resources (required, block):
                - cluster_config (required, block):
                    - instance_count (required)
                    - instance_type (required)
                    - volume_kms_key_id (optional)
                    - volume_size_in_gb (required)
            - network_config (optional, block):
                - enable_inter_container_traffic_encryption (optional)
                - enable_network_isolation (optional)
                - vpc_config (optional, block):
                    - security_group_ids (required)
                    - subnets (required)
            - role_arn (required)
            - stopping_condition (optional, block):
                - max_runtime_in_seconds (optional)
        - monitoring_job_definition_name (optional)
        - monitoring_type (required)
        - schedule_config (optional, block):
            - schedule_expression (required)
Optional:
    - name
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    name     = optional(string)
    region   = optional(string)
    tags     = optional(map(string))
    tags_all = optional(map(string))
    monitoring_schedule_config = object({
      monitoring_job_definition = optional(object({
        baseline = optional(object({
          baselining_job_name = optional(string)
          constraints_resource = optional(object({
            s3_uri = optional(string)
          }))
          statistics_resource = optional(object({
            s3_uri = optional(string)
          }))
        }))
        environment = optional(map(string))
        monitoring_app_specification = object({
          container_arguments                 = optional(list(string))
          container_entrypoint                = optional(list(string))
          image_uri                           = string
          post_analytics_processor_source_uri = optional(string)
          record_preprocessor_source_uri      = optional(string)
        })
        monitoring_inputs = object({
          batch_transform_input = optional(object({
            data_captured_destination_s3_uri = string
            dataset_format = object({
              csv = optional(object({
                header = optional(bool)
              }))
              json = optional(object({
                line = optional(bool)
              }))
            })
            end_time_offset                 = optional(string)
            exclude_features_attribute      = optional(string)
            features_attribute              = optional(string)
            inference_attribute             = optional(string)
            local_path                      = string
            probability_attribute           = optional(string)
            probability_threshold_attribute = optional(number)
            s3_data_distribution_type       = optional(string)
            s3_input_mode                   = optional(string)
            start_time_offset               = optional(string)
          }))
          endpoint_input = optional(object({
            end_time_offset                 = optional(string)
            endpoint_name                   = string
            exclude_features_attribute      = optional(string)
            features_attribute              = optional(string)
            inference_attribute             = optional(string)
            local_path                      = string
            probability_attribute           = optional(string)
            probability_threshold_attribute = optional(number)
            s3_data_distribution_type       = optional(string)
            s3_input_mode                   = optional(string)
            start_time_offset               = optional(string)
          }))
        })
        monitoring_output_config = object({
          kms_key_id = optional(string)
          monitoring_outputs = object({
            s3_output = object({
              local_path     = string
              s3_upload_mode = optional(string)
              s3_uri         = string
            })
          })
        })
        monitoring_resources = object({
          cluster_config = object({
            instance_count    = number
            instance_type     = string
            volume_kms_key_id = optional(string)
            volume_size_in_gb = number
          })
        })
        network_config = optional(object({
          enable_inter_container_traffic_encryption = optional(bool)
          enable_network_isolation                  = optional(bool)
          vpc_config = optional(object({
            security_group_ids = set(string)
            subnets            = set(string)
          }))
        }))
        role_arn = string
        stopping_condition = optional(list(object({
          max_runtime_in_seconds = optional(number)
        })))
      }))
      monitoring_job_definition_name = optional(string)
      monitoring_type                = string
      schedule_config = optional(object({
        schedule_expression = string
      }))
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_monitoring_schedules : (
        v.monitoring_schedule_config.monitoring_job_definition == null || (v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input == null || (length(v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input.local_path) >= 1 && length(v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input.local_path) <= 256))
      )
    ])
    error_message = "must be between 1 and 256 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_monitoring_schedules : (
        v.monitoring_schedule_config.monitoring_job_definition == null || (v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input == null || (v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input.probability_attribute == null || (length(v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input.probability_attribute) >= 1 && length(v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input.probability_attribute) <= 256)))
      )
    ])
    error_message = "must be between 1 and 256 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_monitoring_schedules : (
        v.monitoring_schedule_config.monitoring_job_definition == null || (v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input == null || (v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input.probability_threshold_attribute == null || (v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input.probability_threshold_attribute >= 0 && v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.batch_transform_input.probability_threshold_attribute <= 1)))
      )
    ])
    error_message = "must be between 0 and 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_monitoring_schedules : (
        v.monitoring_schedule_config.monitoring_job_definition == null || (v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.endpoint_input == null || (length(v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.endpoint_input.endpoint_name) >= 1 && length(v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.endpoint_input.endpoint_name) <= 63))
      )
    ])
    error_message = "must be between 1 and 63 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_monitoring_schedules : (
        v.monitoring_schedule_config.monitoring_job_definition == null || (v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.endpoint_input == null || (length(v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.endpoint_input.local_path) >= 1 && length(v.monitoring_schedule_config.monitoring_job_definition.monitoring_inputs.endpoint_input.local_path) <= 256))
      )
    ])
    error_message = "must be between 1 and 256 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_monitoring_schedules : (
        v.monitoring_schedule_config.monitoring_job_definition == null || (v.monitoring_schedule_config.monitoring_job_definition.monitoring_resources.cluster_config.volume_size_in_gb >= 1 && v.monitoring_schedule_config.monitoring_job_definition.monitoring_resources.cluster_config.volume_size_in_gb <= 16384)
      )
    ])
    error_message = "must be between 1 and 16384"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_monitoring_schedules : (
        v.monitoring_schedule_config.monitoring_job_definition == null || (v.monitoring_schedule_config.monitoring_job_definition.stopping_condition == null || alltrue([for item in v.monitoring_schedule_config.monitoring_job_definition.stopping_condition : (item.max_runtime_in_seconds == null || (item.max_runtime_in_seconds >= 1 && item.max_runtime_in_seconds <= 86400))]))
      )
    ])
    error_message = "must be between 1 and 86400"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_monitoring_schedules : (
        v.monitoring_schedule_config.monitoring_job_definition_name == null || (length(v.monitoring_schedule_config.monitoring_job_definition_name) <= 63)
      )
    ])
    error_message = "[from validName: invalid when len(value) > 63]"
  }
  # Note: 22 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

