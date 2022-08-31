terraform {
  required_providers {
    kind = {
      source  = "justenwalker/kind"
      version = "0.11.0-rc.1"
    }
  }
}

resource "kind_cluster" "new" {
  name = "go-todo-infra"
  config = templatefile(
    "${path.module}/cluster_config.tftpl",
    {
      cluster_name           = "kind-go-todo-infra",
      host_ingress_port_http = var.host_ingress_port_http,
      host_ingress_port_ssh  = var.host_ingress_port_ssh
    }
  )
}
