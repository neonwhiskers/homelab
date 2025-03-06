locals {
  image_id_ubuntu_24_04 = "117e8764-41c2-405f-aece-b53aa08b28cc"
}

resource "stackit_server" "melo_server_with_network" {
  availability_zone = "eu01-1"
  desired_status    = "active"
  project_id        = data.stackit_resourcemanager_project.melo_test.project_id
  name              = "melo-server"
  boot_volume = {
    delete_on_termination = true
    size                  = 64
    source_type           = "image"
    source_id             = local.image_id_ubuntu_24_04
  }
  machine_type       = "t1.2"
  keypair_name       = stackit_key_pair.melo_server_keypair.name
  network_interfaces = [stackit_network_interface.melo_test_nic.network_interface_id]

  labels = local.labels
}

resource "stackit_key_pair" "melo_server_keypair" {
  name       = "melo-server-key-pair"
  public_key = "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAE0qz9Zr3FbcKnRIYGECPO5PPvxNOKahwVQCFNAQ6kwuKYYwPNu8FfLjUqQ8tyvEX4/NeCmRE6qeNxMSkLut3Mf+ACiN+pdO5F2wTkiYq3LpI4zSsXfBNjPmkBwFot4vq4fIdG38sLZtUu4C1olqDzm7N3xDnznRVHi5jKZAzaG6Rvx1A== se@cloudeteer.de"
}