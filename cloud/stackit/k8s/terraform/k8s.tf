resource "stackit_ske_cluster" "melo_k8s_cluster" {
    #name max length 8 chars
    name       = "melo-k8s"
    project_id = data.stackit_resourcemanager_project.melo_test.project_id
    kubernetes_version_min = "1.31"

    node_pools = [{
        name         = "melo-node-pool"
        # https://www.stackit.de/de/agb/leistungsscheine/stackit-compute-engine/
        machine_type = "m1.2"
        maximum    = 2
        minimum    = 2
        os_name    = "flatcar"
        # os_version = ""
        volume_size = 50
        volume_type = "storage_premium_perf0"
        container_runtime = "containerd"
        availability_zones = ["eu01-1"]
        allow_system_components = true
        labels = local.labels
    }]
}