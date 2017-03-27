#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
#install gnome desktop
#sudo apt-get install ubuntu-desktop -y
#install xrdp
sudo apt-get install xrdp -y

#using xfce if you are using Ubuntu version later than Ubuntu 12.04LTS
sudo apt-get install xfce4 -y
#sudo apt-get install xubuntu-desktop -y
sudo echo xfce4-session >/root/.xsession
sudo sed -i '/\/etc\/X11\/Xsession/i xfce4-session' /etc/xrdp/startwm.sh
sudo service xrdp restart
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install docker-ce
curl -L https://github.com/docker/compose/releases/download/1.11.2/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
mkdir csa
cd csa
curl -k -L https://github.com/HewlettPackard/csa-ce/raw/master/buildEnv-dockercompose.sh | bash /dev/stdin <hostname> <ipaddress> [<proxyhost>] [<proxyport>]
