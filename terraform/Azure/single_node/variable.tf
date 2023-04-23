# Define prefix for consistent resource naming.
variable "resource_prefix" {
  default     = "test-lakeside"
  description = "Service prefix to use for naming of resources."
}

# Define Azure region for resource placement.
variable "location" {
  default     = "eastus2"
  description = "Azure region for deployment of resources."
}

# Define username for use on the hosts.
variable "username" {
  default     = "azureuser"
  description = "Username to build and use on the VM hosts."
}

# Bastion Host VM size
variable "bastion_host_VM_size" {
  default     = "Standard_D2ps_v5"
  description = "Bastion Host VM size"
}

# Lakeside master node VM size
variable "lakeside_VM_size" {
  default     = "Standard_D2ps_v5"
  description = "Lakeside master node VM sizee"
}

# Locust VM size
variable "locust_VM_size" {
  default     = "Standard_D2ps_v5"
  description = "Locust VM size"
}
