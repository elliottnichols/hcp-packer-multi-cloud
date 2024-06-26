packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">= 2.0.2"
    }
  }
}

locals {
  date = formatdate("HHmm", timestamp())
}

source "amazon-ebs" "ubuntu-lts" {
  region = "us-east-2"
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  instance_type  = "t2.small"
  temporary_key_pair_type = "ed25519"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false

  ami_name    = "hashicups_{{timestamp}}"
  ami_regions = ["us-east-2"]
}

source "azure-arm" "ubuntu-lts" {
  client_id                         = var.arm_client_id
  client_secret                     = var.arm_client_secret
  subscription_id                   = var.arm_subscription_id

  os_type         = "Linux"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_publisher = "Canonical"
  image_sku       = "22_04-lts"

  managed_image_resource_group_name = var.azure_resource_group

  vm_size        = "Standard_B1s"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false

  azure_tags = {
    dept = "Engineering"
    task = "Image deployment"
    build_date = "${local.date}"
  }
}

build {
  # HCP Packer settings
  hcp_packer_registry {
    bucket_name = "multicloud-hashicups"
    description = <<EOT
This is an image for HashiCups.
    EOT

    bucket_labels = {
      "multi-cloud" = "packer-multicloud-hashicups",
    }
  }
  
  source "source.amazon-ebs.ubuntu-lts" {
    name = "hashicups_ubuntu-jammy-22.04"
  }

  source "source.azure-arm.ubuntu-lts" {
    name               = "hashicups"
    location           = var.azure_region
    managed_image_name = "hashicups_ubuntu-jammy-22.04_${local.date}"
  }
  
  # systemd unit for HashiCups service
  provisioner "file" {
    source      = "hashicups.service"
    destination = "/tmp/hashicups.service"
  }

  //Set up HashiCups
  provisioner "shell" {
    scripts = [
      "setup-deps-hashicups.sh"
    ]
  }

  post-processor "manifest" {
    output     = "packer_manifest.json"
    strip_path = true
    custom_data = {
      version_fingerprint = packer.versionFingerprint
    }
  }
}