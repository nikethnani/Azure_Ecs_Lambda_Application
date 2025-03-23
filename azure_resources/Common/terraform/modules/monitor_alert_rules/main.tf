# Create action group for monitor alert rules
resource "azurerm_monitor_action_group" "mag" {
  name                = "WarningAlertsAction"
  resource_group_name = var.resource_group_monitor_alert_rules_name
  short_name          = "p0action"

  email_receiver {
    name          = "sendtoadmin"
    email_address = var.email_address
  }
}

# Metric alert rule CPU
resource "azurerm_monitor_metric_alert" "alert_cpu" {
  name                = "alert-cpu"
  resource_group_name = var.resource_group_monitor_alert_rules_name
  scopes              = var.vms_id
  description         = "Action will be triggered when Percentage CPU is greater than ${var.threshold_cpu}."
  severity            = var.severity_cpu

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.threshold_cpu
  }

  action {
    action_group_id = azurerm_monitor_action_group.mag.id
  }
}

# Metric alert rule memory
resource "azurerm_monitor_metric_alert" "alert_mem" {
  name                = "alert-mem"
  resource_group_name = var.resource_group_monitor_alert_rules_name
  scopes              = var.vms_id
  description         = "Action will be triggered when available memory is less than ${var.threshold_mem}."
  severity            = var.severity_mem

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = var.threshold_mem
  }

  action {
    action_group_id = azurerm_monitor_action_group.mag.id
  }
}

# Metric alert rule data disk IOPS Consumed Percentage
resource "azurerm_monitor_metric_alert" "alert_data_iops" {
  name                = "alert-data-iops"
  resource_group_name = var.resource_group_monitor_alert_rules_name
  scopes              = var.vms_id
  description         = "Action will be triggered when data disk IOPS Consumed Percentage is greater than ${var.threshold_data_iops}."
  severity            = var.severity_data_iops

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Data Disk IOPS Consumed Percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.threshold_data_iops
  }

  action {
    action_group_id = azurerm_monitor_action_group.mag.id
  }
}

# Metric alert rule OS disk IOPS Consumed Percentage
resource "azurerm_monitor_metric_alert" "alert_os_iops" {
  name                = "alert-OS-iops"
  resource_group_name = var.resource_group_monitor_alert_rules_name
  scopes              = var.vms_id
  description         = "Action will be triggered when OS disk IOPS Consumed Percentage is greater than ${var.threshold_os_iops}."
  severity            = var.severity_os_iops

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "OS Disk IOPS Consumed Percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.threshold_os_iops
  }

  action {
    action_group_id = azurerm_monitor_action_group.mag.id
  }
}

# Metric alert rule network in total
resource "azurerm_monitor_metric_alert" "alert_net_in" {
  name                = "alert-network-in"
  resource_group_name = var.resource_group_monitor_alert_rules_name
  scopes              = var.vms_id
  description         = "Action will be triggered when network in total is greater than ${var.threshold_net_in}."
  severity            = var.severity_net_in

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Network In Total"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.threshold_net_in
  }

  action {
    action_group_id = azurerm_monitor_action_group.mag.id
  }
}

# Metric alert rule network out total
resource "azurerm_monitor_metric_alert" "alert_net_out" {
  name                = "alert-network-out"
  resource_group_name = var.resource_group_monitor_alert_rules_name
  scopes              = var.vms_id
  description         = "Action will be triggered when network out total is greater than ${var.threshold_net_out}."
  severity            = var.severity_net_out

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Network Out Total"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.threshold_net_out
  }

  action {
    action_group_id = azurerm_monitor_action_group.mag.id
  }
}
