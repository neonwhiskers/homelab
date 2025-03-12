resource "stackit_security_group" "melo_test_sec_group" {
  project_id = data.stackit_resourcemanager_project.melo_test.project_id
  name       = "melo-test-security-group"
  stateful   = true

  labels = local.labels
}

locals {
  rules = {
    SSH   = 22
    HTTPS = 443
    HTTP  = 80
  }
}

resource "stackit_security_group_rule" "melo_test_rule_v4" {
  for_each = local.rules

  project_id        = data.stackit_resourcemanager_project.melo_test.project_id
  security_group_id = stackit_security_group.melo_test_sec_group.security_group_id
  description       = "IPv4, ingress, ${each.key}"
  direction         = "ingress"
  # plan validation spell check missing (case sensitive)
  ether_type = "IPv4"

  protocol = {
    name = "tcp"
  }

  port_range = {
    min = each.value
    max = each.value
  }
}

resource "stackit_security_group_rule" "melo_test_rule_v6" {
  for_each = local.rules

  project_id        = data.stackit_resourcemanager_project.melo_test.project_id
  security_group_id = stackit_security_group.melo_test_sec_group.security_group_id
  description       = "IPv6, ingress, ${each.key}"
  direction         = "ingress"
  # plan validation spell check missing (case sensitive)
  ether_type = "IPv6"

  protocol = {
    name = "tcp"
  }

  port_range = {
    min = each.value
    max = each.value
  }
}