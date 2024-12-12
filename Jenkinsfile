pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'your-dockerhub-username'  
        IMAGE_NAME = 'webweather'  
    }

    stages {
        stage('Build image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest ."
                }
            }
        }
        
        stage('Run container') {
            steps {
                script {
                    sh 'docker run -d -p 5000:5000 ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest'
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    
                    sh 'docker ps'
                }
            }
        }
        
        stage('Push image') {
            steps {
                script {
                   
                    sh "docker login -u ${DOCKER_REGISTRY} -p ${DOCKER_PASSWORD}"
                   
                    sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                }
            }
        }
        
        stage('Play Ansible') {
            steps {
                script {
                    
                    sh 'ansible-playbook -i inventory playbook.yml'
                }
            }
        }
    }
}
