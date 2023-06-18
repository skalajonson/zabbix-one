pipeline {
    agent any
    
    stages {
        stage('Create docker image') {
            steps {
                sh '''
                docker build -t chikibevchik/zabbix-one .
                '''
            }
        }
        stage('Login') {
            steps {
                sh '''
                docker login -u chikibevchik -p topesto777
                '''
            }
        }
        stage('push image') {
            steps {
                sh '''
                docker push chikibevchik/zabbix-one
                '''
            }
        }
        stage('docker run') {
            steps {
                sh '''
                 docker run -d --name zabbix --privileged -v /var/run/docker.sock:/var/run/docker.sock -ti chikibevchik/zabbix-one 
                 docker exec -w /zabbix/ zabbix bash
                 docker network rm zabbix-net
                 docker network create zabbix-net
                 docker run --restart=always -d \
--name zabbix-postgres \
--network zabbix-net \
-v /var/lib/zabbix/timezone:/etc/timezone \
-v /var/lib/zabbix/localtime:/etc/localtime \
-e POSTGRES_PASSWORD=zabbix \
-e POSTGRES_USER=zabbix \
-d chikibevchik/zabbix:postgres
                 docker run --restart=always \
--name zabbix-server \
--network zabbix-net \
-v /var/lib/zabbix/alertscripts:/usr/lib/zabbix/alertscripts \
-v /var/lib/zabbix/timezone:/etc/timezone \
-v /var/lib/zabbix/localtime:/etc/localtime \
-p 10051:10051 -e DB_SERVER_HOST="zabbix-postgres" \
-e POSTGRES_USER="zabbix" \
-e POSTGRES_PASSWORD="zabbix" \
-d chikibevchik/zabbix:server
                  docker run --restart=always \
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
                '''
            }
        }
    }
}
