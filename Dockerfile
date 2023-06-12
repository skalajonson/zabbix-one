FROM ubuntu

RUN apt-get update && apt-get install -y \
    zabbix-server-mysql \
    zabbix-frontend-php \
    zabbix-agent \
    mysql-client


EXPOSE 80
EXPOSE 10050
EXPOSE 10051


