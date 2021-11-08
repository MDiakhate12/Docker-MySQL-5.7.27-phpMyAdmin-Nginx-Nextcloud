docker stop dockbase dockMyAdm && \
docker rm dockbase dockMyAdm && \
docker network rm interne

MOUNTPOINT=~/docker/datatest

docker network create --driver=bridge --subnet 172.18.100.0/24 interne

docker stop dockmysql
docker rm dockmysql

echo "Creating mysql container..."
docker run \
--detach \
-e MYSQL_ROOT_PASSWORD=passroot \
-e MYSQL_ROOT_HOST=% \
--name=dockbase \
--mount type=bind,source=$MOUNTPOINT,target=/var/lib/mysql \
--hostname=basededonnee \
--network=interne \
--network-alias=base \
--ip=172.18.100.10 \
--publish=33060:3306 \
mysql:5.7.27 && \
echo -e "Done!\n"

echo "Creating phpmyadmin container..."
docker run \
--detach \
--name=dockMyAdm \
-e PMA_HOST=base \
--publish=8080:80 \
phpmyadmin && \
echo -e "Done!\n"

docker network connect interne dockMyAdm --ip=172.18.100.11  --alias=pma

docker restart dockMyAdm dockbase

docker network inspect interne

