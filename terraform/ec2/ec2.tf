 resource "aws_instance" "ec2_Lakeside_mutual" {
        ami = "ami-0f69dd1d0d03ad669"  
        instance_type = "t4g.large" 
        key_name= "aws_key"
        vpc_security_group_ids = [aws_security_group.main.id]
        tags = {
            Name = "terraform_Lakeside_server"
        }
         provisioner "local-exec" {
           command = "echo ${self.private_ip} >> private_ips.txt && echo ${self.public_ip} >> public_ips.txt && echo ${self.public_dns} >> public_ips.txt"
           }
        connection {
           type        = "ssh"
           host        = self.public_ip
           user        = "ubuntu"
           private_key = file("/root/.ssh/id_rsa")
           timeout     = "4m"
        }
        root_block_device {
          volume_size = 40 # in GB <<----- I increased this!
          volume_type = "gp2"
          encrypted             = true
          delete_on_termination = true
          }
     }

 resource "aws_instance" "ec2_Locust_server" {
        ami = "ami-0f69dd1d0d03ad669"  
        instance_type = "t4g.small" 
        vpc_security_group_ids = [aws_security_group.main.id]
        key_name= "aws_key"
        tags = {
            Name = "terraform_locust_server"
        }
         provisioner "local-exec" {
           command = "echo ${self.private_ip} >> private_ips.txt && echo ${self.public_ip} >> public_ips.txt && echo ${self.public_dns} >> public_ips.txt"
           }
        connection {
           type        = "ssh"
           host        = self.public_ip
           user        = "ubuntu"
           private_key = file("/root/.ssh/id_rsa")
           timeout     = "4m"
        }
     }


resource "aws_security_group" "main" {
      ingress = [
    {
      description      = "All traffic"
      from_port        = 0    # All ports
      to_port          = 0    # All Ports
      protocol         = "-1" # All traffic
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Outbound rule"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name= "aws_key"
  public_key = "<SSH Public Key>"
}    
