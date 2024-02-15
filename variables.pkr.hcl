variable "aws_access_key_id" {
  type = string
  default = env("AWS_ACCESS_KEY_ID")
}

variable "aws_secret_access_key" {
  type = string
  default = env("AWS_SECRET_ACCESS_KEY")
}

variable "arm_client_id" {
  type = string
  default = env("ARM_CLIENT_ID")
}

variable "arm_client_secret" {
  type = string
  default = env("ARM_CLIENT_SECRET")
}

variable "arm_subscription_id" {
  type = string
  default = env("ARM_SUBSCRIPTION_ID")
}

variable "azure_resource_group" {
  type = string
  default = "packer-multicloud"
}

variable "azure_region" {
  type = string
  default = "eastus2"
}

variable "aws_region" {
  type = string
  default = "us-east-2"
}
