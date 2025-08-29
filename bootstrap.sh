#!/bin/bash
set -e

echo "=== Fixing DNS issues ==="
sudo rm -f /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

echo "=== Updating system packages ==="
sudo apt-get update -y
sudo apt-get upgrade -y

echo "=== Installing basic tools ==="
sudo apt-get install -y git curl unzip software-properties-common ca-certificates lsb-release apt-transport-https

echo "=== Installing Apache ==="
sudo apt-get install -y apache2
sudo a2enmod rewrite
sudo systemctl enable apache2
sudo systemctl restart apache2

echo "=== Installing PHP 8.1 and extensions ==="
sudo apt-get install -y php libapache2-mod-php php-cli php-common php-mysql php-mbstring php-xml php-curl php-zip php-bcmath unzip

echo "=== Installing Composer ==="
EXPECTED_CHECKSUM=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM=$(php -r "echo hash_file('sha384', 'composer-setup.php');")

if [ "$EXPECTED_CHECKSUM" = "$ACTUAL_CHECKSUM" ]; then
    php composer-setup.php --quiet
    sudo mv composer.phar /usr/local/bin/composer
    echo "Composer installed successfully"
else
    echo "Composer checksum mismatch. Aborting!"
    rm composer-setup.php
    exit 1
fi
rm composer-setup.php

echo "=== Installing MySQL 8.0 ==="
# Set MySQL root password for non-interactive install
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
sudo systemctl enable mysql
sudo systemctl start mysql

echo "=== Restarting Apache ==="
sudo systemctl restart apache2

echo "=== Cleaning up ==="
sudo apt-get autoremove -y
sudo apt-get clean

echo "=== Provisioning complete! ==="
