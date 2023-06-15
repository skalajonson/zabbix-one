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
                docker run -d -p 80:80 -p 10050:10050 -p 10051:10051 -p 5432:5432 chikibevchik/zabbix-one
                '''
            }
        }
    }
}
