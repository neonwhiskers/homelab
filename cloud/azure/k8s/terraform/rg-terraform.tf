resource "azurerm_resource_group" "rg_terraform" {
    name     = "rg-terraform"
    location = "East Us"
    tags = {
        provisioner = "terraform"
        owner = "melo"
        project = "k8s"
    }
}