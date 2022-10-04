#/bin/sh

while getopts "M:L:" flag
do
         case "${flag}" in
                M) LAKESIDE_IP=${OPTARG};;
                L) LOCUST_IP=${OPTARG};;
         esac
       
done


############################### set up ansible host #####################
cat <<EOF> /etc/ansible/hosts
[lakeside]
$LAKESIDE_IP     #public IP

[locust]
$LOCUST_IP

[all:vars]
ansible_connection=ssh
ansible_user=ubuntu
EOF

############################### set up ansible.cfg #####################
cat <<EOF> /etc/ansible/ansible.cfg
[defaults]
inventory      = /etc/ansible/hosts
EOF


############################### setting up host #####################
cat <<EOF> ${PWD}/hosts
[lakeside]
lakeside_mutual ansible_host=$LAKESIDE_IP    ansible_user=ubuntu
[locust]
locust ansible_host=$LOCUST_IP   ansible_user=ubuntu
EOF
