# HCP Packer Multi-Cloud Build 
This project combines strategies in the `Automate Packer with GitHub Actions` and `Standardize artifacts across multiple cloud providers` tutorials to create a single Multi-cloud Packer build pipeline to HCP Packer using GitHub actions
  - https://developer.hashicorp.com/packer/tutorials/cloud-production/github-actions 
  - https://developer.hashicorp.com/packer/tutorials/cloud-production/multicloud

## Requirements
1. Service accounts for HCP, AWS, and Azure. Define the following Secrets in the target GitHub repository settings:
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_SESSION_TOKEN`
  - `HCP_CLIENT_ID`
  - `HCP_CLIENT_SECRET`
  - `HCP_ORGANIZATION_ID`
  - `HCP_PROJECT_ID`
  
2. HCP Packer Bucket with name of: `learn-packer-multicloud-hashicups`
3. Configure AWS and Azure target regions in `variables.pkr.hcl`
