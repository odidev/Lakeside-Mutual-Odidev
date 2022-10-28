output "lakeside-public-ip" {
  value = aws_instance.lakeside-ec2.public_ip
}

output "locust-public-ip" {
  value = aws_instance.Locust-ec2.public_ip
}

output "lakeside-private-ip" {
  value = aws_instance.lakeside-ec2.private_ip
}

output "locust-private-ip" {
  value = aws_instance.Locust-ec2.private_ip
}

output "bastionhost-public-ip" {
  value = aws_instance.BASTION.public_ip
}

output "traefik-proxy-public-ip" {
  value = try(aws_instance.traefik-proxy-ec2[0].public_ip,"")
}

output "traefik-proxy-private-ip" {
  value = try(aws_instance.traefik-proxy-ec2[0].private_ip,"")
}
