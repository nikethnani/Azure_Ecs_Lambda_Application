data "azurerm_container_registry" "acr" {
  name                = "opndevopsimages"
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_machine" "polarion_vm" {
  name                = var.polarion_vm
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_machine" "jenkins_vm" {
  name                = var.jenkins_vm
  resource_group_name = var.resource_group_name
}

/*data "azurerm_virtual_machine" "confluence_vm" {
  name                = var.confluence_vm
  resource_group_name = var.resource_group_name
}
*/
data "azurerm_virtual_machine" "gitlab_vm" {
  name                = var.gitlab_vm
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_machine" "jfrog_vm" {
  name                = var.jfrog_vm
  resource_group_name = var.resource_group_name
}

/*data "azurerm_virtual_machine" "coverity_vm" {
  name                = var.coverity_vm
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_machine" "jira_vm" {
  name                = var.jira_vm
  resource_group_name = var.resource_group_name
}
*/