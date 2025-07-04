variable "name" {
  type        = string
  description = "The name of the windows virtual machine."
  default     = "windows"
}

variable "admin_password" {
  type        = string
  description = "The administrator password for the virtual machine."
  default     = "Administrator@"
}

variable "admin_username" {
  type        = string
  description = "The administrator username for the virtual machine."
  default     = "jojo"
}

variable "computer_name" {
  type        = string
  description = "The computer name for the virtual machine."
  default     = "windows"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machine."
  default     = "Standard_B1s"
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "The source image reference for the virtual machine."
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
  description = "The OS disk configuration for the virtual machine."
  default = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 128
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual machine will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the virtual machine will be created."
}

variable "ip_configuration" {
  type = object({
    name                          = string
    subnet_id                     = string
    private_ip_address_allocation = string
    public_ip_address_id          = string
  })
  description = "The IP configuration for the network interface."
  default = {
    name                          = "ip-config"
    subnet_id                     = null
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = null
  }
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))

  default = [
    {
      name                       = "test123"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-HTTP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

variable "address_space" {
  type        = list(string)
  description = "The address space for the virtual network."
  default     = ["10.0.0.0/16"]
}

variable "address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the subnet."
  default     = ["10.0.1.0/24"]
}

variable "allocation_method" {
  type        = string
  description = "The allocation method for the public IP address."
  default     = "Static"
}

variable "sku" {
  type        = string
  description = "The SKU for the public IP address."
  default     = "Standard"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources."
  default = {
    Environment = "Dev"
    Project     = "Joseph-learning"
  }
}
