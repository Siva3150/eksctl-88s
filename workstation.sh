#!/bin/bash
growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-varVol
xfs_growfs /var

#docker
dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

#kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.34.2/2025-11-13/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl  /usr/local/bin && export PATH=$HOME/bin:$PATH

#eksctl
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl

#kubens 
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

#k9s 
curl -sS https://webinstall.dev/k9s | bash

#helm 
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh


# go to ec2-user home
cd /home/ec2-user
git clone https://github.com/Siva3150/eksctl-88s.git
git clone https://github.com/Siva3150/k8-resources-88s.git
git clone https://github.com/Siva3150/helm-88s.git
git clone https://github.com/Siva3150/roboshop-helm-88s.git
git clone https://github.com/Siva3150/k8-rbac-88s.git 
git clone https://github.com/Siva3150/k8-roboshop-88s.git
git clone https://github.com/Siva3150/k8-roboshop-databases-88s.git 

