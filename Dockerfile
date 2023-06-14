#FROM ubuntu:20.04

#ENV DEBIAN_FRONTEND=noninteractive

#RUN apt-get update && apt-get install -y \
 #   zabbix-server-mysql \
 #   zabbix-frontend-php \
  #  zabbix-agent \
  #  mysql-client

#EXPOSE 8080
#EXPOSE 80
#EXPOSE 10050
#EXPOSE 10051
#EXPOSE 443
#EXPOSE 8443

FROM ubuntu

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io && usermod -aG docker $USER && apt install docker-compose -y && docker --version


#ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
#RUN apt-get update && apt-get install -y wget

# Download Zabbix repository configuration
#RUN wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu20.04_all.deb

# Install Zabbix repository
#RUN dpkg -i zabbix-release_6.4-1+ubuntu20.04_all.deb

# Install Zabbix server, frontend, and agent
#RUN apt-get update && apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent zabbix-sql-scripts vim

#RUN apt-get update && apt-get install -y mysql-server

#RUN service mysql start

#RUN touch database.sql && echo CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
#CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'password';
#GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
#SET GLOBAL log_bin_trust_function_creators = 1; > database.sql

#RUN mysql -u root -p password < database.sql

#COPY docker-entrypoint.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/docker-entrypoint.sh

#ENTRYPOINT ["docker-entrypoint.sh"]

#COPY docker.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/docker.sh

#ENTRYPOINT ["docker.sh"]

#RUN zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix && -p password

#RUN touch setcreator.sql && echo SET GLOBAL log_bin_trust_function_creators = 0;
#quit; > setcreator.sql

#RUN echo DBPassword=password >> /etc/zabbix/zabbix_server.conf

#RUN service zabbix-server restart && service zabbix-agent restart && service apache2 restart

#RUN service zabbix-server start && service zabbix-agent start && service apache2 start

# Expose ports
#EXPOSE 80 10050

# Start Apache and Zabbix agent
#CMD service apache2 start && service zabbix-agent start && tail -f /dev/null

