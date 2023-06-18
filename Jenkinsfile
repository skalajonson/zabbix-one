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
                 #docker run -d -p 80:8080 -p 10051:10051 -p 443:8443 chikibevchik/zabbix-one
                 docker run -d --name zabbix --privileged -v /var/run/docker.sock:/var/run/docker.sock -ti chikibevchik/zabbix-one 
                 docker exec -w /zabbix/ zabbix bash

                 cd zabbix
                 docker-compose up -d
                '''
            }
        }
    }
}
