pipeline {
    agent any
    
    stage {
        stage('Create docker image') {
            steps {
                sh '''
                docker build -t chikibevchik/zabbix_one .
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
                docker run -d -p 80:80 -p 10050:10050 -p 10051:10051 chikibevchik/zabbix-one
                '''
            }
        }
    }
}
