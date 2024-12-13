pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'aliamin10'    // Your Docker Hub username
        IMAGE_NAME = 'webweather'       // Docker image name
        CONTAINER_NAME = 'weather-app'  // Docker container name
        DOCKER_PORT = '5000'            // Application port
        VERSION_TAG = "${env.BUILD_NUMBER}" // Jenkins build number as version tag
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                    // Build the Docker image with the specified tags
                    sh """
                        docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG} .
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
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh """
                            docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                            docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG}
                        """
                    }
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
                    docker rmi ${DOCKER_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG} || true
                """
            }
        }
    }
}
