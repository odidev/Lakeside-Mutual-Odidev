// Bastion Jump server

resource "aws_instance" "BASTION" {
    ami           = "${var.ubuntu-ami}"
    instance_type = "${var.bastionhost-instance-type}"
    subnet_id = aws_subnet.Lakeside_Jump_Subnet.id
    vpc_security_group_ids = [ aws_security_group.only_ssh_bositon.id ]
    key_name = "task1-key"

    root_block_device {
        volume_size = "${var.bastionhost-disk-size}"
        volume_type = "gp2"
        encrypted             = true
        delete_on_termination = true
        }

    tags = {
        Name = "bastion-host"
        }
}


// Locust instance

resource "aws_instance" "Locust-ec2" {
    ami           = "${var.ubuntu-ami}"
    instance_type = "${var.locust-instance-type}"
    subnet_id = aws_subnet.Lakeside_Subnet.id
    vpc_security_group_ids = [ aws_security_group.only_ssh_private_instance.id,aws_security_group.locust_test_lakeside.id, aws_security_group.traefik_proxy_SG.id]
    key_name = "task1-key"

    root_block_device {
        volume_size = "${var.locust-disk-size}"
        volume_type = "gp2"
        encrypted             = true
        delete_on_termination = true
        }

    tags = {
        Name = "locust-terraform"
        }
}


// Lakeside instance

resource "aws_instance" "lakeside-ec2" {
    ami           = "${var.ubuntu-ami}"
    instance_type = "${var.lakeside-instance-type}"
    subnet_id = aws_subnet.Lakeside_Subnet.id
    vpc_security_group_ids = [ aws_security_group.lakeside_http.id,aws_security_group.only_ssh_private_instance.id,aws_security_group.traefik_proxy_SG.id ]
    key_name = "task1-key"

    root_block_device {
        volume_size = "${var.lakeside-disk-size}"
        volume_type = "gp2"
        encrypted             = true
        delete_on_termination = true
        }

    tags = {
        Name = "lakeside-teraform"
        }
}


// traefik Proxy instance

resource "aws_instance" "traefik-proxy-ec2" {
    ami           = "${var.ubuntu-ami}"
    instance_type = "${var.traefik-proxy-instance-type}"
    count       = "${var.deploy_traefik_proxy}" ? 1 : 0

    subnet_id = aws_subnet.traefik_proxy_subnet[0].id
    vpc_security_group_ids = [ aws_security_group.traefik_proxy_SG.id,aws_security_group.only_ssh_private_instance.id ]
    key_name = "task1-key"

    root_block_device {
        volume_size = "${var.traefik-proxy-disk-size}"
        volume_type = "gp2"
        encrypted             = true
        delete_on_termination = true
        }

    tags = {
        Name = "Traefik-Proxy"
        }
}

// Node instance

resource "aws_instance" "lakeside-node-ec2" {
    count = "${var.lakeside-node-count}"
    ami           = "${var.ubuntu-ami}"
    instance_type = "${var.lakeside-node-instance-type}"
    subnet_id = aws_subnet.Lakeside_Subnet.id
    vpc_security_group_ids = [ aws_security_group.lakeside_http.id,aws_security_group.only_ssh_private_instance.id,aws_security_group.traefik_proxy_SG.id ]
    key_name = "task1-key"

    root_block_device {
        volume_size = "${var.lakeside-node-disk-size}"
        volume_type = "gp2"
        encrypted             = true
        delete_on_termination = true
        }

    tags = {
        Name = "Lakeside-node-${count.index + 1}"
        }
}
