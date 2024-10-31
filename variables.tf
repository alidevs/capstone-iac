variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "region" {
  type    = string
  default = "me-central-1"
}

variable "project" {
  type    = string
  default = "capstone"
}

variable "instance_type" {
  type    = string
  default = "ecs.g6.large"
}

variable "image_id" {
  type    = string
  default = "ubuntu_24_04_x64_20G_alibase_20240812.vhd"
}
