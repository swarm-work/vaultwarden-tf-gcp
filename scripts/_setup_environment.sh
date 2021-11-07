#!/usr/bin/env bash

vaultwarden_home="/home/vaultwarden"
docker_compose_version="1.29.2"

sudo apt update && sudo apt install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg2 \
	software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"

sudo apt update && sudo apt install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io

if ! systemctl status docker; then
    systemctl start docker
fi

systemctl enable docker

groupadd vaultwarden

sudo mv /tmp/vaultwarden /home
chmod g+s "${vaultwarden_home}"
chown -R .vaultwarden "${vaultwarden_home}"

sudo curl -L "https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

mkdir -p "${vaultwarden_home}"/vaultdata
mkdir -p "${vaultwarden_home}"/caddy-data

cd "${vaultwarden_home}" && docker-compose up -d

# cleanup
sudo rm -f /tmp/setup_environment.sh
