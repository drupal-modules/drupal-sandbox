#!/bin/bash -ex

#
# Provisioning script for vagrant, see: Vagrantfile
#

# Initialize script.
[ -d "/vagrant" ] || { echo "This script needs to be run within vagrant VM."; exit 1; }
shopt -s globstar # Enable globbing, just for fun.
set -o vi         # Enable vi syntax in shell.
cd /vagrant

# Perform an unattended installation of a Debian packages.
sudo ex +"%s@DPkg@//DPkg" -cwq /etc/apt/apt.conf.d/70debconf
sudo dpkg-reconfigure debconf -f noninteractive -p critical

# Append settings into ~/.bashrc and reload.
ex +'$s@$@\rexport PATH=/var/lib/vendor/bin:$PATH@' -cwq /etc/bash.bashrc

# Give vagrant write permission for /opt.
sudo chown vagrant:vagrant /opt

# Set-up git.
git config --global user.email "vagrant@localhost"
git config --global user.name "Vagrant"

# Install the locale packate to prevent an invalid locale.
sudo apt-get -qy install language-pack-en

# Install useful utils.
sudo apt-get -qy install links html2text

# Install PHP and required extensions.
sudo apt-get -qy install php5-cli php-pear php5-gd

# Install database driver and required extensions.
sudo apt-get -qy install sqlite3 php5-sqlite

# Install Apache server with necessary libraries.
#sudo apt-get install libapache2-mod-php5
#sudo a2enmod rewrite && service apache2 restart

# Install composer (https://getcomposer.org/) via PHP.
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
COMPOSER_HOME=/var/lib/composer COMPOSER_BIN_DIR=/usr/local/bin COMPOSER_VENDOR_DIR=/var/lib/composer/vendor composer -nqq update

# Add version control for /opt to track the changes.
git init /opt

echo "$0 done."
echo "Type: 'vagrant ssh' to log-in to VM."
