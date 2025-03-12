locals {
  cidr_ipv4 = "10.0.0.0/16"
  cidr_ipv6 = "fddc:d8c8:d914::/48"
}

resource "stackit_network" "melo_test_network" {
  project_id       = data.stackit_resourcemanager_project.melo_test.project_id
  name             = "melo-test-network"
  ipv4_prefix      = local.cidr_ipv4
  ipv6_prefix      = local.cidr_ipv6
  ipv4_nameservers = ["8.8.8.8", "8.8.4.4"]

  labels = local.labels
}

resource "stackit_network_interface" "melo_test_nic" {
  name               = "melo-test-nic"
  project_id         = data.stackit_resourcemanager_project.melo_test.project_id
  network_id         = stackit_network.melo_test_network.network_id
  security           = true
  security_group_ids = [stackit_security_group.melo_test_sec_group.security_group_id]

  labels = local.labels
}

resource "stackit_public_ip" "melo_test_pip" {
  project_id           = data.stackit_resourcemanager_project.melo_test.project_id
  network_interface_id = stackit_network_interface.melo_test_nic.network_interface_id

  labels = local.labels
}