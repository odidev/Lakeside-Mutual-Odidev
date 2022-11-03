output "bastionhost-Public-IP" {
    description = "Bastion host instance public IP"
    value = module.ec2.bastionhost-public-ip
}

output "Lakeside-Public-IP" {
    description = "lakeside mutual instance public IP"
    value = module.ec2.lakeside-public-ip
}

output "Lakeside-Private-IP" {
    description = "lakeside mutual instance private IP"
    value = module.ec2.lakeside-private-ip
}

output "Locust-Public-IP" {
    description = "Locust instance public IP"
    value = module.ec2.locust-public-ip
}

output "Locust-Private-IP" {
    description = "Locust instance private IP"
    value = module.ec2.locust-private-ip
}

output "Traefik-Proxy-Public-IP" {
    description = "Traefik proxy public IP"
    value = module.ec2.traefik-proxy-public-ip
}

output "Traefik-Proxy-Private-IP" {
    description = "Traefik Proxy private IP"
    value = module.ec2.traefik-proxy-private-ip
}

output "lakeside-node-public_ip" {
    description = "Public IP of all the lakeside nodes"
    value = module.ec2.lakeside-nodes-public_ip
}

output "lakeside-node-private_ip" {
    description = "Private IP of all the lakeside nodes"
    value = module.ec2.lakeside-nodes-private_ip
}
