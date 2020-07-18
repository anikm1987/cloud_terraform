variable client_secret {}
variable subscription_id {}
variable client_id {}
variable tenant_id {}


variable "location" {
  type    = string
  default = "northeurope"
}

variable "RGName" {
  type    = string
  default = "demo-acr-rg"
}

variable "ACRName" {
  type    = string
  default = "demoacr"
}



