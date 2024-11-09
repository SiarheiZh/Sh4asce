#!/bin/bash

# Обновление и установка необходимых пакетов
sudo apt-get update && sudo apt-get upgrade -y

# Установка основных утилит
sudo apt install -y git curl wget htop bash-completion xz-utils zip unzip ufw locales net-tools mc jq make gcc gpg build-essential ncdu sysstat screen libpq-dev libssl-dev pkg-config openssl ocl-icd-opencl-dev libopencl-clang-dev libgomp1 tmux glances ca-certificates curl gnupg lsb-release apparmor-profiles

# Установка Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Добавление репозитория Docker в систему
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновление пакетов и установка Docker
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

# Добавление текущего пользователя в группу Docker для работы без sudo
sudo usermod -aG docker $USER

# Применение изменений в группах
newgrp docker

# Установка Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Делаем Docker Compose исполняемым
sudo chmod +x /usr/local/bin/docker-compose

# Проверка успешной установки Docker и Docker Compose
docker --version
docker-compose --version

# Установка Python 3.11
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install -y python3.11 python3.11-venv python3.11-dev

# Установка Redsocks
sudo apt install -y redsocks

# Настройка iptables для перехвата трафика через Redsocks
sudo iptables -t nat -N REDSOCKS
sudo iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345
sudo iptables -t nat -A PREROUTING -p tcp -j REDSOCKS

# Установка tmux и glances
sudo apt install -y tmux glances

# Завершение установки
echo "Установка завершена! Система будет перезагружена через 5 секунд."

# Ожидание 5 секунд перед перезагрузкой
sleep 5

# Перезагрузка системы
sudo reboot
