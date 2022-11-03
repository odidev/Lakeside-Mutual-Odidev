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

output "lakeside-nodes-public_ip" {
  value = [aws_instance.lakeside-node-ec2.*.public_ip, 
          aws_instance.lakeside-node-ec2.*.tags.Name]
}

output "lakeside-nodes-private_ip" {
  value = [aws_instance.lakeside-node-ec2.*.private_ip, 
          aws_instance.lakeside-node-ec2.*.tags.Name]
}
