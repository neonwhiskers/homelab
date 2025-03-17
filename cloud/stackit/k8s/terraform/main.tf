# state.tf
terraform {
    backend "s3" {
        bucket = "tfstate-melo"
        key    = "cloud/stackit/k8s/terraform/prod.terraform.tfstate"
        endpoints = {
            s3 = "https://object.storage.eu01.onstackit.cloud"
        }
        region                      = "eu01"
        skip_credentials_validation = true
        skip_region_validation      = true
        skip_s3_checksum            = true
        skip_requesting_account_id  = true
        # https://developer.hashicorp.com/terraform/language/backend/s3#credentials-and-shared-configuration
        # secret_key                = $AWS_SECRET_ACCESS_KEY
        # access_key                = $AWS_ACCESS_KEY_ID
    }
    required_providers {
        stackit = {
            source  = "stackitcloud/stackit"
            version = ">= 0.43.3, < 1.0.0"
        }
    }
}

provider "stackit" {
    default_region = "eu01"
    # service_account_key_path = $STACKIT_SERVICE_ACCOUNT_KEY_PATH
}

data "stackit_resourcemanager_project" "melo_test" {
    project_id = "7c1c975d-c920-4e5f-a6ab-7d78cab29fdd"
}

locals {
    labels = {
        provisioner = "terraform"
        owner       = "melo"
        project     = "k8s"
    }
}