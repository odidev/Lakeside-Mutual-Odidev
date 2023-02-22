resource "tls_private_key" task1_p_key  {
    algorithm = "RSA"
}

resource "aws_key_pair" "task1-key" {
    key_name    = "task1-key"
    public_key = tls_private_key.task1_p_key.public_key_openssh
  }

resource "local_file" "public_key" {
    depends_on = [
      tls_private_key.task1_p_key,
    ]
    filename = pathexpand("~/.ssh/id_rsa.pub")
    content  = tls_private_key.task1_p_key.public_key_openssh
    file_permission = "400"
}

resource "local_file" "private_key" {
    depends_on = [
      tls_private_key.task1_p_key,
    ]
    filename = pathexpand("~/.ssh/id_rsa")
    content  = tls_private_key.task1_p_key.private_key_openssh
    file_permission = "400"
}
