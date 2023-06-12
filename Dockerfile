FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    zabbix-server-mysql \
    zabbix-frontend-php \
    zabbix-agent \
    mysql-client

EXPOSE 8080
EXPOSE 80
EXPOSE 10050
EXPOSE 10051
EXPOSE 443
EXPOSE 8443


