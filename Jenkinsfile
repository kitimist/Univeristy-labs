pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'debian:12'   
        CONTAINER_NAME = 'kitimist-container' 
        SCRIPT_PATH = '/home/file_count.sh'  
        DEB_PACKAGE = '/home/htop_3.2.2-2_amd64.deb'  
    }

    stages {
        stage('Start Docker Container') {
            steps {
                script {
                    sh """
                    docker run --name ${CONTAINER_NAME} -d ${DOCKER_IMAGE} tail -f /dev/null
                    """
                }
            }
        }

        stage('Copy DEB Package to the container') {
            steps {
                script {
                    sh """
                    docker cp ${DEB_PACKAGE} ${CONTAINER_NAME}:/tmp/htop_3.2.2-2_amd64.deb
                    """
                }
            }
        }

        stage('Copy Script to the container') {
            steps {
                script {
                    sh """
                    docker cp ${SCRIPT_PATH} ${CONTAINER_NAME}:/tmp/file_count.sh
                    """
                }
            }
        }

        stage('Install DEB Package inside the container') {
            steps {
                script {
                    sh """
                    docker exec -u root ${CONTAINER_NAME} bash -c "dpkg -i /tmp/htop_3.2.2-2_amd64.deb || apt-get install -f -y"
                    """
                }
            }
        }

        stage('Execute Script inside the container') {
            steps {
                script {
                    sh """
                    docker exec -u root ${CONTAINER_NAME} bash /tmp/file_count.sh
                    """
                }
            }
        }

        stage('Cleanup: stop and remove the container') {
            steps {
                script {
                    sh """
                    docker stop ${CONTAINER_NAME}
                    docker rm ${CONTAINER_NAME}
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished"
        }
    }
}
