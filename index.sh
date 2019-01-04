#!/usr/bin/env bash

if [ "$(whoami)" == "root" ]; then
  echo Run as the local user, not as root.
  exit 1
fi

# harden ssh
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo cp etc/ssh/sshd_config /etc/ssh/sshd_config

# update apt-get and install essentials
sudo apt-get update
sudo apt-get -y git build-essential curl wget

# install node 10
curl -fs https://raw.githubusercontent.com/mafintosh/node-install/master/install | sh
node-install 10

# npm classic
npm config set loglevel http
npm config set progress false
npm config set package-lock false
npm config set save false
mkdir -p ~/.config/configstore/
printf '{"optOut": true,"lastUpdateCheck": 0}' > ~/.config/configstore/update-notifier-npm.json

sudo chown $(whoami):$(whoami) -R /usr/local
