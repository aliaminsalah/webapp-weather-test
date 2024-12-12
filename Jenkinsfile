pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'aliamin10'    // Your Docker Hub username
        IMAGE_NAME = 'webweather'       // Docker image name
        CONTAINER_NAME = 'weather-app'  // Docker container name
        DOCKER_PORT = '5000'            // Application port
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                    sh """
                        docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest .
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Ensure any existing container is removed
                    sh """
                        docker rm -f ${CONTAINER_NAME} || true
                        docker run -d --name ${CONTAINER_NAME} -p ${DOCKER_PORT}:${DOCKER_PORT} ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Verify the container is running
                    sh """
                        docker ps | grep ${CONTAINER_NAME}
                        curl -f http://localhost:${DOCKER_PORT} || exit 1
                    """
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                            docker login -u ${DOCKER_USER} -p ${DOCKER_PASSWORD}
                            docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
                        """
                    }
                }
            }
        }

        stage('Play Ansible') {
            steps {
                script {
                    // Assuming inventory and playbook.yml files are available
                    sh """
                        ansible-playbook -i inventory playbook.yml
                    """
                }
            }
        }
    }

    post {
        always {
            script {
                // Cleanup any resources used
                sh """
                    docker rm -f ${CONTAINER_NAME} || true
                    docker rmi ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest || true
                """
            }
        }
    }
}
