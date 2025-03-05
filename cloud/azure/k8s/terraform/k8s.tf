locals {
    # https://learn.microsoft.com/en-us/azure/aks/supported-kubernetes-versions?tabs=azure-cli#aks-kubernetes-release-calendar
    aks_version = "1.31"
}

resource "azurerm_kubernetes_cluster" "aks_k8s" {
    name                = "aks-k8s"
    location            = azurerm_resource_group.rg_terraform.location
    resource_group_name = azurerm_resource_group.rg_terraform.name
    dns_prefix          = "catlab"
    automatic_upgrade_channel = "stable"

    default_node_pool {
        name       = "npsystem"
        node_count = 1
        # https://cloudprice.net/?sortField=memoryInMB&sortOrder=true&_memoryInMB_min=16&_memoryInMB_max=16&timeoption=month&currency=EUR
        vm_size    = "Standard_B4s_v2"
        auto_scaling_enabled = true
        type = "VirtualMachineScaleSets"
        max_pods = 50
        orchestrator_version = local.aks_version
        os_sku = "AzureLinux"
        pod_subnet_id = azurerm_virtual_network.vnet_k8s.subnet[0].id
        scale_down_mode = "Delete"
        temporary_name_for_rotation = "temp"
        vnet_subnet_id = azurerm_virtual_network.vnet_k8s.subnet[0].id
        zones = [1, 2, 3]
        max_count = 1
        min_count = 1
    }

    identity {
        type = "SystemAssigned"
    }

    tags = azurerm_resource_group.rg_terraform.tags

    lifecycle {
        ignore_changes = [
            # Ignore changes to tags, e.g. because a management agent
            # updates these based on some ruleset managed elsewhere.
            default_node_pool[0].node_count
        ]
    }
}
