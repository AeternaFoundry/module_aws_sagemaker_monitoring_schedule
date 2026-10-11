resource "aws_sagemaker_monitoring_schedule" "sagemaker_monitoring_schedules" {
  for_each = var.sagemaker_monitoring_schedules

  name     = each.value.name
  region   = each.value.region
  tags     = each.value.tags
  tags_all = each.value.tags_all

  monitoring_schedule_config {
    dynamic "monitoring_job_definition" {
      for_each = each.value.monitoring_schedule_config.monitoring_job_definition != null ? [each.value.monitoring_schedule_config.monitoring_job_definition] : []
      content {
        dynamic "baseline" {
          for_each = monitoring_job_definition.value.baseline != null ? [monitoring_job_definition.value.baseline] : []
          content {
            baselining_job_name = baseline.value.baselining_job_name
            dynamic "constraints_resource" {
              for_each = baseline.value.constraints_resource != null ? [baseline.value.constraints_resource] : []
              content {
                s3_uri = constraints_resource.value.s3_uri
              }
            }
            dynamic "statistics_resource" {
              for_each = baseline.value.statistics_resource != null ? [baseline.value.statistics_resource] : []
              content {
                s3_uri = statistics_resource.value.s3_uri
              }
            }
          }
        }
        environment = monitoring_job_definition.value.environment
        monitoring_app_specification {
          container_arguments                 = monitoring_job_definition.value.monitoring_app_specification.container_arguments
          container_entrypoint                = monitoring_job_definition.value.monitoring_app_specification.container_entrypoint
          image_uri                           = monitoring_job_definition.value.monitoring_app_specification.image_uri
          post_analytics_processor_source_uri = monitoring_job_definition.value.monitoring_app_specification.post_analytics_processor_source_uri
          record_preprocessor_source_uri      = monitoring_job_definition.value.monitoring_app_specification.record_preprocessor_source_uri
        }
        monitoring_inputs {
          dynamic "batch_transform_input" {
            for_each = monitoring_job_definition.value.monitoring_inputs.batch_transform_input != null ? [monitoring_job_definition.value.monitoring_inputs.batch_transform_input] : []
            content {
              data_captured_destination_s3_uri = batch_transform_input.value.data_captured_destination_s3_uri
              dataset_format {
                dynamic "csv" {
                  for_each = batch_transform_input.value.dataset_format.csv != null ? [batch_transform_input.value.dataset_format.csv] : []
                  content {
                    header = csv.value.header
                  }
                }
                dynamic "json" {
                  for_each = batch_transform_input.value.dataset_format.json != null ? [batch_transform_input.value.dataset_format.json] : []
                  content {
                    line = json.value.line
                  }
                }
              }
              end_time_offset                 = batch_transform_input.value.end_time_offset
              exclude_features_attribute      = batch_transform_input.value.exclude_features_attribute
              features_attribute              = batch_transform_input.value.features_attribute
              inference_attribute             = batch_transform_input.value.inference_attribute
              local_path                      = batch_transform_input.value.local_path
              probability_attribute           = batch_transform_input.value.probability_attribute
              probability_threshold_attribute = batch_transform_input.value.probability_threshold_attribute
              s3_data_distribution_type       = batch_transform_input.value.s3_data_distribution_type
              s3_input_mode                   = batch_transform_input.value.s3_input_mode
              start_time_offset               = batch_transform_input.value.start_time_offset
            }
          }
          dynamic "endpoint_input" {
            for_each = monitoring_job_definition.value.monitoring_inputs.endpoint_input != null ? [monitoring_job_definition.value.monitoring_inputs.endpoint_input] : []
            content {
              end_time_offset                 = endpoint_input.value.end_time_offset
              endpoint_name                   = endpoint_input.value.endpoint_name
              exclude_features_attribute      = endpoint_input.value.exclude_features_attribute
              features_attribute              = endpoint_input.value.features_attribute
              inference_attribute             = endpoint_input.value.inference_attribute
              local_path                      = endpoint_input.value.local_path
              probability_attribute           = endpoint_input.value.probability_attribute
              probability_threshold_attribute = endpoint_input.value.probability_threshold_attribute
              s3_data_distribution_type       = endpoint_input.value.s3_data_distribution_type
              s3_input_mode                   = endpoint_input.value.s3_input_mode
              start_time_offset               = endpoint_input.value.start_time_offset
            }
          }
        }
        monitoring_output_config {
          kms_key_id = monitoring_job_definition.value.monitoring_output_config.kms_key_id
          monitoring_outputs {
            s3_output {
              local_path     = monitoring_job_definition.value.monitoring_output_config.monitoring_outputs.s3_output.local_path
              s3_upload_mode = monitoring_job_definition.value.monitoring_output_config.monitoring_outputs.s3_output.s3_upload_mode
              s3_uri         = monitoring_job_definition.value.monitoring_output_config.monitoring_outputs.s3_output.s3_uri
            }
          }
        }
        monitoring_resources {
          cluster_config {
            instance_count    = monitoring_job_definition.value.monitoring_resources.cluster_config.instance_count
            instance_type     = monitoring_job_definition.value.monitoring_resources.cluster_config.instance_type
            volume_kms_key_id = monitoring_job_definition.value.monitoring_resources.cluster_config.volume_kms_key_id
            volume_size_in_gb = monitoring_job_definition.value.monitoring_resources.cluster_config.volume_size_in_gb
          }
        }
        dynamic "network_config" {
          for_each = monitoring_job_definition.value.network_config != null ? [monitoring_job_definition.value.network_config] : []
          content {
            enable_inter_container_traffic_encryption = network_config.value.enable_inter_container_traffic_encryption
            enable_network_isolation                  = network_config.value.enable_network_isolation
            dynamic "vpc_config" {
              for_each = network_config.value.vpc_config != null ? [network_config.value.vpc_config] : []
              content {
                security_group_ids = vpc_config.value.security_group_ids
                subnets            = vpc_config.value.subnets
              }
            }
          }
        }
        role_arn = monitoring_job_definition.value.role_arn
        dynamic "stopping_condition" {
          for_each = monitoring_job_definition.value.stopping_condition != null ? monitoring_job_definition.value.stopping_condition : []
          content {
            max_runtime_in_seconds = stopping_condition.value.max_runtime_in_seconds
          }
        }
      }
    }
    monitoring_job_definition_name = each.value.monitoring_schedule_config.monitoring_job_definition_name
    monitoring_type                = each.value.monitoring_schedule_config.monitoring_type
    dynamic "schedule_config" {
      for_each = each.value.monitoring_schedule_config.schedule_config != null ? [each.value.monitoring_schedule_config.schedule_config] : []
      content {
        schedule_expression = schedule_config.value.schedule_expression
      }
    }
  }
}

