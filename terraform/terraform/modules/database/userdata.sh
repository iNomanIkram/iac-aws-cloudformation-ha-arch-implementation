#!/bin/bash -xe
DBName='demo'
DBUser='nomanikram'
DBPassword='secret'
DBRootPassword='rsecret'
apt update -y
apt install -y mariadb-server # wget
service mysql start
mysqladmin -u root password $DBRootPassword
mysql -u root --password=$DBRootPassword
echo "CREATE DATABASE $DBName;" >> /tmp/db.setup
echo "CREATE USER '$DBUser'@'%' IDENTIFIED BY '$DBPassword';" >> /tmp/db.setup
echo "GRANT ALL ON $DBName.* TO '$DBUser'@'%';" >> /tmp/db.setup
echo "FLUSH PRIVILEGES;" >> /tmp/db.setup
mysql -u root --password=$DBRootPassword < /tmp/db.setup
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
service mysql restart