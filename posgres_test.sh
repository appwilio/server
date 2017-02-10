apt-get update
apt-get -y -f install sudo postgresql postgresql-contrib
sed -i -e "s/max_connections = 100/max_connections = 9999/g" /etc/postgresql/9.4/main/postgresql.conf
service postgresql start

sudo -u postgres psql -c "CREATE DATABASE forge;"
sudo -u postgres psql -c "CREATE USER forge WITH password 'forge';"
sudo -u postgres psql -c "GRANT ALL privileges ON DATABASE forge TO forge;"
