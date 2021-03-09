resource_group_name       = "app-service-demo-rg"
app_service_plan_name     = "mydemoapp-service-plan"
business_unit_group       = "rnd"
environment               = "dev"
description               = "App Service instance"
region                    = "eastus2"
app_name                  = "mydemoapp"
cors_allowed_origins      = ["http://localhost:8080"]
container_registry_name   = "mydemoappregistry"
container_image           = "blogger/mydemoapp"
IMAGE_TAG                 = "v1.0.0"
key_vault_name            = "mydemokv"
user_identity_name        = "app-service-user-identity"