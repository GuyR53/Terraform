# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.my_region
     tags = {
    type = "ScaleSetRelated"
  }
}


# Creates VMSS
resource "azurerm_linux_virtual_machine_scale_set" "main" {

  name                            = "VMSS"
  resource_group_name             = var.resource_group_name
  location                        = var.my_region
  sku                             = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = file("${path.module}/password.txt")
  disable_password_authentication = false
  instances = 2
    # Installing into machines the app and dependencies
  custom_data = filebase64("${path.module}/PrepareMachine.sh")
  depends_on = [azurerm_resource_group.rg]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  network_interface {
    name    = "VMSS-Interface"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.AppSubnetID
      load_balancer_backend_address_pool_ids = [var.lb_backend_address_pool_id]
    }
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }


  lifecycle {
    ignore_changes = ["instances"]
  }
}


# Rules for autoscaling
resource "azurerm_monitor_autoscale_setting" "main" {
  name                = "autoscale-config"
  resource_group_name = var.resource_group_name
  location            = var.my_region
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.main.id
  depends_on = [azurerm_resource_group.rg]

  profile {
    name = "AutoScale"

    capacity {
      default = 3
      minimum = 1
      maximum = 5
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}