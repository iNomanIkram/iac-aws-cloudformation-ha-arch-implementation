variable "ProjectTitle" {
  type = string
}

variable "Environment" {
  type = string
}

variable "PEM_Key" {
  type = string
}

variable "BastionHost_SG" {}

variable "PublicSubnet1a" {}
variable "Ami" {}
variable "Instance_Type" {}