variable "ProjectTitle" {
  type = string
}

variable "Environment" {
  type = string
}

variable "PEM_Key" {
  type = string
}

variable "FlaskApp_SG" {}

variable "PrivateSubnet1b" {}
variable "PrivateSubnet2b" {}

variable "Database" {}

variable "Instance_Type" {}
variable "Ami" {}
variable "TargetGroup" {}