# Cloud Computing

## TP Docker 

La machine contient les scripts suivants:
1.	run_dockmysql.sh: crée les conteneurs **dockmysql** et **dockMyAdm**, le **volume** et la base de donnée **BASE_A**
2.	run_dockbase.sh: crée les conteneurs **dockbase** et **dockMyAdm**, le **volume** et le réseau **interne**

Pour que l'interface de phpMyAdmin se lance correctement:
*	lancer la commande `ssh -i <CLE SSH> -L 38080:192.168.166.30:8080 ubuntu@192.168.166.30`

L'interface sera disponible à l'addresse: `http://localhost:38080`
