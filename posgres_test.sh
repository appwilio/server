apt-get update
apt-get -y -f install sudo postgresql postgresql-contrib

sed -i -e "s/max_connections = 100/max_connections = 9999/g" /etc/postgresql/9.4/main/postgresql.conf
sed -i -e "s/#fsync = on/fsync = off/g" /etc/postgresql/9.4/main/postgresql.conf
sed -i -e "s/#full_page_writes = on/full_page_writes = off/g" /etc/postgresql/9.4/main/postgresql.conf
sed -i -e "s/#synchronous_commit = on/synchronous_commit = off/g" /etc/postgresql/9.4/main/postgresql.conf
sed -i -e "s/#checkpoint_timeout = 5min/checkpoint_timeout = 1h/g" /etc/postgresql/9.4/main/postgresql.conf
sed -i -e "s/#wal_level = minimal/wal_level = minimal/g" /etc/postgresql/9.4/main/postgresql.conf
sed -i -e "s/#work_mem = 4MB/work_mem = 200MB/g" /etc/postgresql/9.4/main/postgresql.conf

service postgresql start

sudo -u postgres psql -f postrges.sql