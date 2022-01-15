#!/bin/bash

#Step 1(To remove the docker if exist)

apt-get purge docker-ce docker-ce-cli containerd.io -y

apt-get autoremove -y

sleep 10

#Step 2( Apt update)

apt-get update -y

#Step 3(To install necessary pacakges)

apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

#Step 4( Download the package)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

#Step 5 (adding package)

cat <<EOF >/etc/apt/sources.list.d/docker.list
deb https://download.docker.com/linux/$(lsb_release -si | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable
EOF

#Step 6 (Install docker)
sleep 10

apt-get update -y

apt-get install -y docker-ce docker-ce-cli containerd.io

sleep 30
#step 7
cat <<EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
sleep 20
#step 8
systemctl daemon-reload && systemctl restart docker



