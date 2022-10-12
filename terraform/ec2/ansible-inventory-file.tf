# Generate inventory file
resource "local_file" "inventory" {
    depends_on=[aws_instance.lakeside-ec2,aws_instance.Locust-ec2]
    filename = "./../inventory/hosts"
    content = <<EOF
                [lakeside]
                ${aws_instance.lakeside-ec2.private_ip}

                [locust]
                ${aws_instance.Locust-ec2.private_ip}
                    
                [all:vars]
                ansible_connection=ssh
                ansible_user=ubuntu
                EOF       
}
