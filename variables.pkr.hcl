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
  default = env("TF_VAR_azure_resource_group")
}

variable "azure_region" {
  type = string
  default = "eastus2"
}

variable "aws_region" {
  type = string
  default = "us-east-2"
}
