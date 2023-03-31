# # IDs of virtual networks provisioned.
# output "vm_ids" {
#   description = "IDs of virtual networks provisioned."
#   value       = "${concat(azurerm_linux_virtual_machine.bastion_vm.*.id, azurerm_linux_virtual_machine.worker_vm.*.id)}"
# }

# IDs of subnets provisioned.
# output "network_subnet_ids" {
#   description = "IDs of subnets provisioned."
#   value       = "${concat(azurerm_subnet.public_subnet.*.id, azurerm_subnet.private_subnet.*.id)}"
# }

# # Prefixes of virtual networks provisioned.
# output "network_subnet_prefixes" {
#   description = "Prefixes of virtual networks provisioned."
#   value       = "${concat(azurerm_subnet.public_subnet.*.address_prefix, azurerm_subnet.private_subnet.*.address_prefix)}"
# }

# # IDs of network security groups provisioned.
# output "network_security_group_ids" {
#   description = "IDs of network security groups provisioned."
#   value       = "${concat(azurerm_network_security_group.public_nsg.*.id, azurerm_network_security_group.private_nsg.*.id)}"
# }

# # IDs of network interfaces provisioned.
# output "network_interface_ids" {
#   description = "IDs of network interfaces provisioned."
#   value       = "${concat(azurerm_network_interface.bastion_nic.*.id, azurerm_network_interface.worker_nic.*.id)}"
# }

# IDs of public IP addresses provisioned.
# output "Bastion_host_public_IP" {
#   description = "IDs of public IP addresses provisioned."
#   value       = "${azurerm_public_ip.public_ip.*.id}"
# }

# IP addresses of public IP addresses provisioned.
output "bastion_host_public_ip" {
  description = "IP addresses of public IP addresses provisioned."
  value       = azurerm_linux_virtual_machine.bastion_vm.public_ip_address
}

# IP addresses of private IP addresses provisioned.
output "Lakeside_private_ip" {
  description = "IP addresses of private IP addresses provisioned."
  value       = azurerm_network_interface.lakeside_nic.private_ip_address
}

output "Locust_private_ip" {
  description = "IP addresses of private IP addresses provisioned."
  value       = azurerm_network_interface.locust_nic.private_ip_address
}
