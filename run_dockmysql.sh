echo "Removing previously created containers and networks..."

docker stop dockMyAdm dockmysql
docker rm dockMyAdm dockmysql
docker network rm phpmyadmin

echo "Creation of volume mountpoint folder..."
MOUNTPOINT=~/docker/datatest

sudo rm -rf $MOUNTPOINT

echo -e "Done!\n" && \

echo -e "Done!\n" && \

echo "Creation of mysqld conf file mysqld..."
cat <<EOF > mysqld.cnf \
# Config file
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
# By default we only accept connections from localhost
bind-address    = 0.0.0.0
symbolic-links=0
EOF

echo -e "Done!\n"

echo "Creating mount point..."
sudo mkdir -p $MOUNTPOINT
echo -e "Done!\n"

echo "Creating network <phpmyadmin> for containers..."
docker network create --driver=bridge --subnet=192.168.0.0/16 phpmyadmin && \
echo -e "Done!\n"

echo "Creating mysql container..."
docker run \
--detach \
-e MYSQL_ROOT_PASSWORD=passroot \
-e MYSQL_ROOT_HOST=% \
--name=dockmysql \
--mount type=bind,source=$MOUNTPOINT,target=/var/lib/mysql \
--hostname=mysql \
--network=phpmyadmin \
--network-alias=mysql \
--publish=33060:3306 \
mysql:5.7.27 && \
echo -e "Done!\n"

echo "Copy conf file..."
docker cp ./mysqld.cnf dockmysql:/etc/mysql/mysql.conf.d/mysqld.cnf && \
echo -e "Done!\n"


#echo "Granting privileges..."
#sleep 5 && \
#docker exec dockmysql mysql -u root -ppassroot -e "grant all privileges on *.* to 'root'@'%' identified by 'passroot';" && \
#echo -e "Done!\n"

echo "Creating database BASE_A..." && \
docker exec dockmysql service mysql status && \
sleep 5 && \
docker exec dockmysql service mysql status && \
#docker exec dockmysql mysql -u root -ppassroot -e 'CREATE DATABASE BASE_A;' && \
#echo -e "Done!\n"

echo "Creating phpmyadmin container..."
docker run \
--detach \
--name=dockMyAdm \
--network=phpmyadmin \
--network-alias=dockMyAdm \
-e PMA_HOST=mysql \
--publish=8080:80 \
phpmyadmin && \
echo -e "Done!\n"


docker ps && \
echo -e "\n"
