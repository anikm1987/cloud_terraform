# Getting started with Terraform with Azure

- Proxy issue while working inside office firewall / vpn

  - set https_proxy=http://[user]:[pwd]@[proxy-ip]:[proxy-port]
  - terraform init # should be the first command before running anything
  - terraform plan or terraform plan -var-file=credentials.tfvars
  - terraform apply or terraform apply -var-file=credentials.tfvars
  - terraform destroy or terraform destroy -var-file=credentials.tfvars

- Notes while applying terraform config

  - terraform plan sometime does not catch the init module required by the configuration
  - for AAD Azure active directory - azuread is the provider going forward
  - during execution if any error occurs then don't worry about already created infrastructure. .tfstate actually keep track of failures as well and update the state if you rerun after fixing the issue.
  - Able to create the resource group and service principal successfully.

# Contains

- CreateAzureRG - contains terraform code to create resource group and service principle associated with it with role assignment.
- database-postgres - Create Azure PAAS postgres db
- Azure_registry - Create ACR

- Add below contents in credentials.auto.tfvars

# replace all teh values with actual values before running
client_secret   = "client_secret"
subscription_id = "subscription_id"
client_id       = "client_id"
tenant_id       = "tenant_id"
administrator_login_password="administrator_login_password_pg"
