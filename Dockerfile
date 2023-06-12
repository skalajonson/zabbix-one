FROM ubuntu:latest
RUN apt-get update && apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-agent
