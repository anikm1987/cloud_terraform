variable client_secret {}
variable subscription_id {}
variable client_id {}
variable tenant_id {}

variable "resource_group_name" {
  description = "The name of the resource group to be created"
  default     = "RG-Terraform-Demo"
}

variable "resource_location" {
  description = "The location where the resource will be craeted"
  default     = "eastus2"
}

variable "service_priniciple_name" {
  description = "The name of the service principle for the resource group"
  default     = "sp-Terraform-Demo"
}

# provider with credential information - configure the azure provide first
provider "azurerm" {
  version         = "1.38.0"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

provider "azuread" {
  # Whilst version is optional,  /strongly recommend/ using it to pin the version of the Provider being used
  version = "=0.4.0"

  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}


resource "azurerm_resource_group" "tf_rg_test" {
  name     = "${var.resource_group_name}"
  location = "${var.resource_location}"
  # define your tags as per your need here
  tags = {
    Owner       = "Aniket Mukherjee"
    Environment = "Development"
  }
}

# create service principal for the resource group
resource "azuread_application" "tf_sp_test" {
  name            = "${var.service_priniciple_name}"
  identifier_uris = ["http://${var.service_priniciple_name}"]
}

# Create Service Principal
resource "azuread_service_principal" "tf_sp_test" {
  application_id = "${azuread_application.tf_sp_test.application_id}"
}

resource "random_string" "password" {
  length  = 32
  special = true
}

# Create Service Principal password
resource "azuread_service_principal_password" "tf_sp_test" {
  end_date             = "2021-01-30T23:00:00Z" # 1 year
  service_principal_id = "${azuread_service_principal.tf_sp_test.id}"
  value                = "${random_string.password.result}"
}

output "sp_password" {
  value     = "${azuread_service_principal_password.tf_sp_test.value}"
  sensitive = true
}
# add service principle as Contributor for the resource group .. 
resource "azurerm_role_assignment" "tf_role_assign" {
  scope                = "${azurerm_resource_group.tf_rg_test.id}" # the resource id
  role_definition_name = "Contributor"                             # such as "Owner / custom role"
  principal_id         = "${azuread_service_principal.tf_sp_test.id}"
}




