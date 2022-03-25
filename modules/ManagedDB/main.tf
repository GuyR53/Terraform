
# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.my_region
    tags = {
    type = "PostgresDataBaseRelated"
  }
}

resource "azurerm_private_dns_zone" "guy" {
  name                = "guy.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
  depends_on = [azurerm_resource_group.rg]

}

resource "azurerm_private_dns_zone_virtual_network_link" "guy" {
  name                  = "GuynetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.guy.name
  virtual_network_id    = var.VirtualNetworkID
  resource_group_name   = var.resource_group_name
  depends_on = [azurerm_resource_group.rg]

}

resource "azurerm_postgresql_flexible_server" "guy" {
  name                   = "guy-psqlflexibleserver"
  resource_group_name    = var.resource_group_name
  location               = var.my_region
  version                = "12"
  delegated_subnet_id    = var.DBSubnet
  private_dns_zone_id    = azurerm_private_dns_zone.guy.id
  administrator_login    = "psqladmin"
  administrator_password = file("${path.module}/password.txt")
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.guy]


}