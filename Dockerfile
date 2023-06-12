#FROM ubuntu:20.04

#ENV DEBIAN_FRONTEND=noninteractive

#RUN apt-get update && apt-get install -y \
    zabbix-server-mysql \
    zabbix-frontend-php \
    zabbix-agent \
    mysql-client

#EXPOSE 8080
#EXPOSE 80
#EXPOSE 10050
#EXPOSE 10051
#EXPOSE 443
#EXPOSE 8443

FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y wget

# Download Zabbix repository configuration
RUN wget https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.4-1+ubuntu20.04_all.deb

# Install Zabbix repository
RUN dpkg -i zabbix-release_5.4-1+ubuntu20.04_all.deb

# Install Zabbix server, frontend, and agent
RUN apt-get update && apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

# Clean up
RUN rm zabbix-release_5.4-1+ubuntu20.04_all.deb

# Expose ports
EXPOSE 80 10050

# Start Apache and Zabbix agent
CMD service apache2 start && service zabbix-agent start && tail -f /dev/null

