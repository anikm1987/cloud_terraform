variable client_secret {}
variable subscription_id {}
variable client_id {}
variable tenant_id {}
variable administrator_login_password {}

variable "location" {
  type    = string
  default = "northeurope"
}

variable "RGName" {
  type    = string
  default = "demo-rg"
}

variable "start_ip_address" {
  type    = string
  default = "10.161.72.15"
}
variable "end_ip_address" {
  type    = string
  default = "10.161.72.15"
}

variable "administrator_login" {
  type    = string
  default = "testadmin"
}



