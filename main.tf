resource "azurerm_resource_group" "kubanadez" {
  name     = "sajmcit-resources"
  location = "Canada Central"
}

resource "azurerm_kubernetes_cluster" "kubanadez" {
  name                = "kuubzsajmcitaks1"
  location            = azurerm_resource_group.kubanadez.location
  resource_group_name = azurerm_resource_group.kubanadez.name
  dns_prefix          = "tester101sajmcitprefix"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}
