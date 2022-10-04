#/bin/sh

TERRAFORM_VERSION="1.3.1"
TERRAFORM_ARCH= 'amd64'


if [ `uname -m` = 'aarch64' ] ;
then
  TERRAFORM_ARCH='arm64'
fi

sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TERRAFORM_ARCH}.zip
unzip terraform_${TERRAFORM_VERSION}_linux_${TERRAFORM_ARCH}.zip
sudo mv terraform /usr/local/bin/
sudo rm -rf terraform_${TERRAFORM_VERSION}_linux_${TERRAFORM_ARCH}.zip

sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible python3 python3-pip -y
