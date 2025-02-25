locals {
    cidr_ipv4 = "10.0.0.0/16"
    cidr_ipv6 = "fddc:d8c8:d914::/48"
}

resource "azurerm_virtual_network" "vnet_k8s" {
    name                = "vnet-k8s"
    location            = azurerm_resource_group.rg_terraform.location
    resource_group_name = azurerm_resource_group.rg_terraform.name
    address_space       = [local.cidr_ipv4, local.cidr_ipv6]

    subnet {
        name             = "snet-k8s"
        # Last subnet fddc:d8c8:d914:ffff::/64
        # https://developer.hashicorp.com/terraform/language/functions/cidrsubnet
        address_prefixes = [cidrsubnet(local.cidr_ipv4, 8, 1), cidrsubnet(local.cidr_ipv6, 16, 1)]
        security_group = azurerm_network_security_group.nsg_k8s.id
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }

    tags = azurerm_resource_group.rg_terraform.tags
}

resource "azurerm_network_security_group" "nsg_k8s" {
    name                = "nsg-k8s"
    location            = azurerm_resource_group.rg_terraform.location
    resource_group_name = azurerm_resource_group.rg_terraform.name

    /*    security_rule {
        name                       = "test123"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }*/

    tags = azurerm_resource_group.rg_terraform.tags
}