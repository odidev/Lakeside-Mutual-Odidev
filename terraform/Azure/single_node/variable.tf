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
  default     = "ubuntu"
  description = "Username to build and use on the VM hosts."
}
