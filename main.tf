terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.4.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "2b9871ee-2522-4990-a375-6623663bca47"  # Your subscription ID
}


resource "azurerm_resource_group" "poc" {
  name     = "nes_dhpoc"
  location = "Central US"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = azurerm_resource_group.poc.location
  resource_group_name = azurerm_resource_group.poc.name
  dns_prefix          = "poc"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
    zones = ["1", "2", "3"]

  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}