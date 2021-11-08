echo "Removing previously created containers and networks..."

docker stop dockbase dockMyAdm && \
docker rm dockbase dockMyAdm && \
docker network rm interne

docker stop dockMyAdm dockmysql
docker rm dockMyAdm dockmysql
docker network rm phpmyadmin
