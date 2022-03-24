 #Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.my_region
}

resource "azurerm_public_ip" "LoadBalancerIP" {
  name                = "PublicIPForLB"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  sku = "Standard"
  allocation_method   = "Static"
  depends_on = [azurerm_resource_group.rg]
}

 resource "azurerm_lb" "LoadBalancer" {
  name                = "LoadBalancer"
  location            = var.my_region
  resource_group_name = var.resource_group_name
  sku = "Standard"
  depends_on = [azurerm_public_ip.LoadBalancerIP]

  frontend_ip_configuration {
    name                 = "Front-endIP"
    public_ip_address_id = azurerm_public_ip.LoadBalancerIP.id
  }
}

 resource "azurerm_lb_backend_address_pool" "BackendAdrress" {
  loadbalancer_id = azurerm_lb.LoadBalancer.id
  name            = "BackEndAddressPool"
  depends_on = [azurerm_lb.LoadBalancer]
}

 resource "azurerm_lb_backend_address_pool_address" "Application1" {
  name                    = "Application1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackendAdrress.id
  virtual_network_id      = var.VirtualNetworkID
  ip_address              = var.privateipaddrres1
   depends_on = [azurerm_lb_backend_address_pool.BackendAdrress]
}

 resource "azurerm_lb_backend_address_pool_address" "Application2" {
  name                    = "Application2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackendAdrress.id
  virtual_network_id      = var.VirtualNetworkID
  ip_address              = var.privateipaddrres2
   depends_on = [azurerm_lb_backend_address_pool.BackendAdrress]
}

  resource "azurerm_lb_backend_address_pool_address" "Application3" {
  name                    = "Application3"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackendAdrress.id
  virtual_network_id      = var.VirtualNetworkID
  ip_address              = var.privateipaddrres3
   depends_on = [azurerm_lb_backend_address_pool.BackendAdrress]
}

 resource "azurerm_lb_probe" "ProbeA" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.LoadBalancer.id
  name                = "ProbeA"
  port                = 8080
}

 resource "azurerm_lb_rule" "RuleA" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.LoadBalancer.id
  name                           = "RuleA"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "Front-endIP"
}










