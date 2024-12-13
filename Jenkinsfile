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
                    // Build the Docker image with the specified tag
                    sh """
                        docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest .
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Remove any existing container and start a new one
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
                    // Check if the container is running and test the application
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
                    //push the image
                    sh """
                        docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Play Ansible') {
            steps {
                script {
                    // Execute the Ansible playbook
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
                // Clean up resources after the pipeline run
                sh """
                    docker rm -f ${CONTAINER_NAME} || true
                    docker rmi ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest || true
                """
            }
        }
    }
}
