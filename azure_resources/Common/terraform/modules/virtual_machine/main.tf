############# Network Interface #############
resource "azurerm_network_interface" "nic" {
  #name                = "nic-${var.subscription}-${var.region[var.location]}-${application}-${var.enviroment}-1"
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.virtual_network_subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = var.private_ip_address
  }
  tags = var.tags
}

############# Windows Virtual Machine #############
resource "azurerm_windows_virtual_machine" "vm" {
  count               = var.operating_system == "Windows" ? var.vm_count : 0
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.windows_admin_password
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  vtpm_enabled = var.trusted_launch
  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_stg_type
    disk_size_gb         = var.os_disk_size
  }

  identity  {
    type = "SystemAssigned"
  }

  source_image_id = var.windows_source_image_id
  tags            = var.tags
  license_type    = var.windows_license_type
}

############# Linux Virtual Machine #############
resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.operating_system == "RedHat" ? var.vm_count : 0
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_stg_type
    disk_size_gb         = var.os_disk_size
  }

  source_image_reference {
    publisher = var.operating_systems[var.operating_system]["publisher"]
    offer     = var.operating_systems[var.operating_system]["offer"]
    sku       = var.operating_systems[var.operating_system]["sku"]
    version   = var.operating_systems[var.operating_system]["version"]
  }

  identity  {
    type = "SystemAssigned"
  }

  tags = var.tags
}

############# Install Extension #############
resource "azurerm_virtual_machine_extension" "avme" {
  name = "azure_monitor_agent"
  virtual_machine_id = coalesce(
    var.operating_system == "RedHat" ? azurerm_linux_virtual_machine.vm[0].id : null,
    var.operating_system == "Windows" ? azurerm_windows_virtual_machine.vm[0].id : null
  )
  publisher = "Microsoft.Azure.Monitor"
  type = coalesce(
    var.operating_system == "RedHat" ? "AzureMonitorLinuxAgent" : null,
    var.operating_system == "Windows" ? "AzureMonitorWindowsAgent" : null
  )
  type_handler_version = coalesce(
    var.operating_system == "RedHat" ? 1.29 : null,
    var.operating_system == "Windows" ? 1.2 : null
  )
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
 {
  "proxy": {
        "mode": "application",
        "address": "http://10.0.0.1:80",
        "auth": "false"
    }
 }
SETTINGS
  tags     = var.tags
}

############# Additional Disks #############
resource "azurerm_managed_disk" "disk" {
  count                = length(var.data_disks)
  name                 = "${var.data_disks[count.index].disk_name}-${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.data_disks[count.index].storage_account_type
  create_option        = var.data_disks[count.index].create_option
  disk_size_gb         = var.data_disks[count.index].size
}

resource "azurerm_virtual_machine_data_disk_attachment" "att_disk" {
  count           = length(var.data_disks)
  managed_disk_id = azurerm_managed_disk.disk[count.index].id
  virtual_machine_id = coalesce(
    var.operating_system == "RedHat" ? azurerm_linux_virtual_machine.vm[0].id : null,
    var.operating_system == "Windows" ? azurerm_windows_virtual_machine.vm[0].id : null
  )
  lun     = count.index + 1
  caching = var.aditional_disk_caching
}

############# Backup VM policy #############
resource "azurerm_backup_protected_vm" "backup" {
  resource_group_name = var.recovery_resource_group
  recovery_vault_name = var.recovery_vault_name
  source_vm_id = coalesce(
    var.operating_system == "RedHat" ? azurerm_linux_virtual_machine.vm[0].id : null,
    var.operating_system == "Windows" ? azurerm_windows_virtual_machine.vm[0].id : null
  )
  backup_policy_id = var.recovery_vault_vm_policy_id
}
