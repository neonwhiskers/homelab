terraform {

    # https://learn.microsoft.com/en-us/azure/storage/common/authorize-data-access
    backend "azurerm" {
        resource_group_name  = "manual"
        storage_account_name = "stmelotfstate"
        container_name       = "tfstate"
        key                  = "cloud/azure/k8s/terraform/prod.terraform.tfstate"
        use_azuread_auth     = true
    }

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">=4.19.0, <5.0.0"
        }
    }
}

provider "azurerm" {
    subscription_id = "cefa63e8-d357-497a-a4eb-1acf2051b48f"
    tenant_id = "9c1de352-64a4-4509-b3fc-4ef2df8db9b8"
    features {}
}
