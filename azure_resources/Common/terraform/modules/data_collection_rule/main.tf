# Deploy the Azure data collection endpoint for monitoring linux virtual machines.
resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = lower(join("-", [var.environment, var.vm_name, "dcr"]))
  location            = var.location
  resource_group_name = var.resource_group_name
  kind = coalesce(
    var.operating_system == "RedHat" ? "Linux" : null,
    var.operating_system == "Windows" ? "Windows" : null
  )
  data_collection_endpoint_id = var.data_collection_endpoint_id
  tags                        = var.tags

  destinations {
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace_id
      name                  = "perfom-logs"
    }
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace_id
      name                  = "system-logs"
    }
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace_id
      name                  = "custom-logs"
    }
  }

  data_flow {
    streams       = ["Microsoft-Perf"]
    destinations  = ["perfom-logs"]
    transform_kql = "source"
    output_stream = "Microsoft-Perf"
  }

  data_flow {
    streams       = ["Microsoft-Syslog"]
    destinations  = ["system-logs"]
    transform_kql = "source"
    output_stream = "Microsoft-Syslog"
  }

  data_flow {
    streams       = ["Custom-${azapi_resource.data_collection_logs_table.name}"]
    destinations  = ["custom-logs"]
    output_stream = "Custom-${azapi_resource.data_collection_logs_table.name}"
    transform_kql = "source"
  }

  data_sources {
    dynamic "syslog" {
      for_each = var.operating_system == "RedHat" ? [1] : []
      content {
        facility_names = ["*"]
        log_levels     = ["Warning", "Error", "Critical", "Alert", "Emergency"]
        name           = "datasource-syslog"
        streams        = ["Microsoft-Syslog"]
      }
    }

    dynamic "performance_counter" {
      for_each = var.operating_system == "RedHat" ? [1] : []
      content {
        streams                       = ["Microsoft-Perf"]
        sampling_frequency_in_seconds = 60
        counter_specifiers            = ["Processor(*)\\% Processor Time", "Memory(*)\\% Used Memory", "Memory(*)\\% Available Memory", "Logical Disk(*)\\% Used Space", "Logical Disk(*)\\% Free Space", "Network(*)\\Total Bytes", "System(*)\\CPUs"]
        name                          = "datasource-perfcounter-linux"
      }
    }

    dynamic "performance_counter" {
      for_each = var.operating_system == "Windows" ? [1] : []
      content {
        streams                       = ["Microsoft-InsightsMetrics"]
        sampling_frequency_in_seconds = 60
        counter_specifiers            = ["\\Processor Information(_Total)\\% Processor Time", "\\Memory\\Available Bytes", "\\LogicalDisk(_Total)\\% Disk Time", "\\LogicalDisk(_Total)\\% Free Space", "\\Network Interface(*)\\Bytes Total/sec", "\\System\\Processes"]
        name                          = "datasource-perfcounter-windows"
      }
    }

    dynamic "windows_event_log" {
      for_each = var.operating_system == "Windows" ? [1] : []
      content {
        streams = ["Microsoft-WindowsEvent"]
        x_path_queries = [
          "Application!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=0 or Level=5)]]",
          "Security!*[System[(band(Keywords,13510798882111488))]]",
          "System!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=0 or Level=5)]]"
        ]
        name = "datasource-wineventlog"
      }
    }
    log_file {
      name          = "toolchain-logfile"
      format        = "text"
      streams       = ["Custom-${azapi_resource.data_collection_logs_table.name}"]
      file_patterns = var.file_patterns
      settings {
        text {
          record_start_timestamp_format = "ISO 8601"
        }
      }
    }
  }

  stream_declaration {
    stream_name = "Custom-${azapi_resource.data_collection_logs_table.name}"
    column {
      name = "TimeGenerated"
      type = "datetime"
    }
    column {
      name = "Logger"
      type = "string"
    }
    column {
      name = "Context"
      type = "string"
    }
    column {
      name = "RawData"
      type = "string"
    }
    column {
      name = "AdditionalContext"
      type = "string"
    }
  }
}

# associate to a Data Collection Rule
resource "azurerm_monitor_data_collection_rule_association" "vm_resource" {
  name                    = lower(join("-", [var.resource_group_name, var.vm_name, "dcra"]))
  target_resource_id      = var.vm_id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
  description             = "Azure monitor data collection rule association on data collection endpoint ${azurerm_monitor_data_collection_rule.dcr.name} for virtual machine ${var.vm_name}"
}

resource "azapi_resource" "data_collection_logs_table" {
  name      = var.custom_table_name
  parent_id = var.log_analytics_workspace_id
  type      = "Microsoft.OperationalInsights/workspaces/tables@2022-10-01"
  body = jsonencode(
    {
      "properties" : {
        "schema" : {
          "name" : "${var.custom_table_name}",
          "columns" : [
            {
              "name" : "TimeGenerated",
              "type" : "datetime",
              "description" : "The time at which the data was generated"
            },
            {
              "name" : "Logger",
              "type" : "string",
              "description" : "Logger name"
            },
            {
              "name" : "Context",
              "type" : "string",
              "description" : "Context of the log line"
            },
            {
              "name" : "RawData",
              "type" : "string",
              "description" : "Log rawData"
            },
            {
              "name" : "AdditionalContext",
              "type" : "string",
              "description" : "Additional context of the log line"
            }
          ]
        },
        "retentionInDays" : 30,
        "totalRetentionInDays" : 30
      }
    }
  )
}
