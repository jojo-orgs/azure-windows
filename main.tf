resource "azurerm_resource_group" "joseph-rg" {
  name     = "${var.name}-${var.resource_group_name}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.name}-vnet"
  address_space       = var.address_space
  location            = azurerm_resource_group.joseph-rg.location
  resource_group_name = azurerm_resource_group.joseph-rg.name
  tags                = var.tags
}

resource "azurerm_subnet" "internal" {
  name                 = "${var.name}-subnet"
  resource_group_name  = azurerm_resource_group.joseph-rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.address_prefixes

}

resource "azurerm_public_ip" "joseph" {
  name                = "${var.name}-public-ip"
  resource_group_name = azurerm_resource_group.joseph-rg.name
  location            = azurerm_resource_group.joseph-rg.location
  allocation_method   = var.allocation_method
  sku                 = var.sku
  tags                = var.tags
}

resource "azurerm_network_interface" "joseph" {
  name                = "${var.name}-nic"
  location            = azurerm_resource_group.joseph-rg.location
  resource_group_name = azurerm_resource_group.joseph-rg.name
  tags                = var.tags

  ip_configuration {
    name                          = "${var.name}-${var.ip_configuration.name}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.joseph.id
  }
}

resource "azurerm_network_security_group" "joseph" {
  name                = "${var.name}-nsg"
  location            = azurerm_resource_group.joseph-rg.location
  resource_group_name = azurerm_resource_group.joseph-rg.name
  tags                = var.tags

  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.joseph.id
  network_security_group_id = azurerm_network_security_group.joseph.id
}

resource "azurerm_windows_virtual_machine" "main" {
  name                  = "${var.name}-vnet"
  location              = azurerm_resource_group.joseph-rg.location
  resource_group_name   = azurerm_resource_group.joseph-rg.name
  network_interface_ids = [azurerm_network_interface.joseph.id]
  admin_password        = var.admin_password
  admin_username        = var.admin_username
  computer_name         = var.computer_name
  size                  = var.vm_size
  tags                  = var.tags

  dynamic source_image_reference {
    for_each = [var.image_reference]
    content {
    publisher = source_image_reference.value.publisher
    offer     = source_image_reference.value.offer
    sku       = source_image_reference.value.sku
    version   = source_image_reference.value.version
    }
  }

  dynamic os_disk {
    for_each = [var.disk]
    content {
    caching              = os_disk.value.caching
    storage_account_type = os_disk.value.storage_account_type
    disk_size_gb         = os_disk.value.disk_size_gb
    }
  }
}