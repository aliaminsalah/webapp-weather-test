pipeline {
    agent any

    stages {
        stage('Build image') {
            steps {
                sh 'docker build -t webweather .'
            }
        }
        stage('Run container') {
            steps {
                sh ' docker run -d -p 5000:5000 weather-app '
            }
        }
        stage('Test') {
            steps {
                sh 'docker ps'
            }
        }
    }
}