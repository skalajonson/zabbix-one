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

FROM ubuntu:22.04

RUN apt update && apt install -y apt-transport-https ca-certificates curl software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt update && apt install -y docker-ce && usermod -aG docker root && apt install -y docker-compose

RUN mkdir /var/lib/zabbix/ && cd /var/lib/zabbix/ && ln -s /usr/share/zoneinfo/Europe/Kiev localtime && echo 'Europe/Kiev' > timezone && sudo docker network create zabbix-net

RUN docker run --restart=always -d \
--name zabbix-postgres \
--network zabbix-net \
-v /var/lib/zabbix/timezone:/etc/timezone \
-v /var/lib/zabbix/localtime:/etc/localtime \
-e POSTGRES_PASSWORD=zabbix \
-e POSTGRES_USER=zabbix \
-d chikibevchik/zabbix:postgres

RUN docker run --restart=always \
--name zabbix-server \
--network zabbix-net \
-v /var/lib/zabbix/alertscripts:/usr/lib/zabbix/alertscripts \
-v /var/lib/zabbix/timezone:/etc/timezone \
-v /var/lib/zabbix/localtime:/etc/localtime \
-p 10051:10051 -e DB_SERVER_HOST="zabbix-postgres" \
-e POSTGRES_USER="zabbix" \
-e POSTGRES_PASSWORD="zabbix" \
-d chikibevchik/zabbix:server

RUN docker run --restart=always \
--name zabbix-web \
-p 80:8080 -p 443:8443 \
--network zabbix-net \
-e DB_SERVER_HOST="zabbix-postgres" \
-v /var/lib/zabbix/timezone:/etc/timezone \
-v /var/lib/zabbix/localtime:/etc/localtime \
-e POSTGRES_USER="zabbix" \
-e POSTGRES_PASSWORD="zabbix" \
-e ZBX_SERVER_HOST="zabbix-server" \
-e PHP_TZ="Europe/Kiev" \
-d chikibevchik/zabbix:web

EXPOSE 80 10050 10051 443 8443

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

