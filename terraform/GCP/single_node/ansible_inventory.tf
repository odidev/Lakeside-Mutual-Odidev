resource "local_file" "inventory" {
  depends_on = [google_compute_instance.bastion_host, google_compute_instance.lakeside, google_compute_instance.locust]
  filename   = "./hosts"
  content    = <<EOF
[lakeside]
${google_compute_instance.lakeside.network_interface[0].network_ip}
[locust]
${google_compute_instance.locust.network_interface[0].network_ip}
[bastion_host]
${google_compute_instance.bastion_host.network_interface[0].access_config[0].nat_ip}

[lakeside:vars]
ansible_connection=ssh
ansible_user=odidev_puresoftware_com
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh odidev_puresoftware_com@${google_compute_instance.bastion_host.network_interface[0].access_config[0].nat_ip} -W %h:%p"'

[locust:vars]
ansible_connection=ssh
ansible_user=odidev_puresoftware_com
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh odidev_puresoftware_com@${google_compute_instance.bastion_host.network_interface[0].access_config[0].nat_ip} -W %h:%p"'

[all:vars]
ansible_connection=ssh
ansible_user=odidev_puresoftware_com
                EOF
}