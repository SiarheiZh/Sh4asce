#!/bin/bash

# Устанавливаем net-tools, если он еще не установлен
if ! command -v ifconfig &> /dev/null; then
    echo "Установка net-tools..."
    sudo apt install -y net-tools
fi

# Создаем директорию network3 и переходим в нее
mkdir -p network3
cd network3

# Загружаем файл
echo "Скачивание ubuntu-node-v2.1.0.tar..."
curl -O https://network3.io/ubuntu-node-v2.1.0.tar

# Распаковываем архив
echo "Распаковка ubuntu-node-v2.1.0.tar..."
tar -xf ubuntu-node-v2.1.0.tar

# Переходим в директорию ubuntu-node
cd ubuntu-node

# Запускаем скрипт manager.sh up
echo "Запуск manager.sh up..."
sudo bash manager.sh up

# Получаем внешний IP-адрес
MY_IP=$(curl -s ifconfig.me)

# Формируем ссылку с IP-адресом
LINK="https://account.network3.ai/main?o=${MY_IP}:8080"

# Выводим сформированную ссылку
echo "Ссылка: $LINK"

# Запускаем скрипт для получения ключа регистрации на сайте
echo "Ключ регистрации на сайте:"
sudo bash manager.sh key
