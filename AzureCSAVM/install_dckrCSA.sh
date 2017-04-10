#!/bin/bash
#
# Execute APT repositories update and system upgrade
apt-get update
apt-get upgrade -y
#install xrdp (used to connect to the VM using RDP)
apt-get install xrdp -y
# Using xfce if you are using Ubuntu version later than Ubuntu 12.04LTS (...and this is the case...)
apt-get install xubuntu-desktop -y
# Configure XFCE4
echo xfce4-session >/root/.xsession
sed -i '/\/etc\/X11\/Xsession/i xfce4-session' /etc/xrdp/startwm.sh
service xrdp restart
# Install or upgrade packages needed to install Docker
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
# Install google-chrome to let you browse CSA interface
# but removes first firefox that seems to have problems working with xfce4
sudo apt-get purge firefox -y
apt-get install chromium-browser -y
# Add Docker Repo to VM APT repos
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
#Install Docker
apt-get install docker-ce -y
systemctl start docker
systemctl enable docker
usermod -g docker csauser
# Install correct version of docker-compose
curl -L https://github.com/docker/compose/releases/download/1.11.2/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
# Save current IP Address and Hostname in a variable
vmipaddr=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -v '172.*')
vmname=$(hostname)
mkdir csa
cd csa
# Download HPE script to configure Docker Compose YAML file and execute it
# since the VM is on Azure Proxy parameters are optional ( [<proxyhost>] [<proxyport>])
curl -k -L https://github.com/HewlettPackard/csa-ce/raw/master/buildEnv-dockercompose.sh | bash /dev/stdin $vmname $vmipaddr
