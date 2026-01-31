# Azure Infrastructure - Main Configuration
# File: main.tf
#
# This configuration creates:
# - Resource Group
# - Virtual Network with Subnet
# - Network Security Group
# - Public IP
# - Network Interface
# - Linux Virtual Machine

# ============================================
# RESOURCE GROUP
# ============================================
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-${var.environment}-rg"
  location = var.location

  tags = var.tags
}

# ============================================
# VIRTUAL NETWORK
# ============================================
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-${var.environment}-vnet"
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = var.tags
}

# ============================================
# SUBNET
# ============================================
resource "azurerm_subnet" "main" {
  name                 = "${var.prefix}-${var.environment}-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_address_prefix]
}

# ============================================
# NETWORK SECURITY GROUP
# ============================================
resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}-${var.environment}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # Allow SSH
  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow HTTP
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow HTTPS
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Associate NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# ============================================
# PUBLIC IP
# ============================================
resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-${var.environment}-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

# ============================================
# NETWORK INTERFACE
# ============================================
resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-${var.environment}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }

  tags = var.tags
}

# ============================================
# LINUX VIRTUAL MACHINE
# ============================================
resource "azurerm_linux_virtual_machine" "main" {
  name                = "${var.prefix}-${var.environment}-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  # Password authentication (for workshop simplicity)
  admin_password                  = var.admin_password
  disable_password_authentication = false

  # Uncomment for SSH key authentication (recommended for production)
  # admin_ssh_key {
  #   username   = var.admin_username
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }
  # disable_password_authentication = true

  os_disk {
    name                 = "${var.prefix}-${var.environment}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # Custom data (cloud-init) - optional
  # custom_data = base64encode(file("${path.module}/scripts/init.sh"))

  tags = var.tags
}

# ============================================
# OPTIONAL: ADDITIONAL SUBNET (e.g., for database)
# ============================================
# resource "azurerm_subnet" "database" {
#   name                 = "${var.prefix}-${var.environment}-db-subnet"
#   resource_group_name  = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes     = ["10.0.2.0/24"]
# }
