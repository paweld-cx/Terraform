variable "vcenter_server" {}
variable "vcenter_user" {}
variable "vcenter_password" {
  sensitive = true
}

variable "datacenter" {}
variable "cluster" {}
variable "datastore" {}
variable "network" {}
variable "template" {}

variable "domain" {}
variable "gateway" {}
variable "netmask" {}

variable "vm_list" {
  type = map(object({
    cpu        = number
    memory     = number
    disk1_size = number
    disk2_size = number
    ip         = string
  }))
}