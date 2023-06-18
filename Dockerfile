FROM ubuntu

RUN apt update && apt install -y docker-compose && mkdir zabbix/ && apt install -y git && git clone https://github.com/skalajonson/zabbix-one.git && mv zabbix-one/docker-compose.yml zabbix/
