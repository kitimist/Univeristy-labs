pipeline {
  agent any
  stages {
    stage('Start Docker Container') {
      steps {
        sh 'docker run --name ${CONTAINER_NAME} -d ${DOCKER_IMAGE} tail -f /dev/null'
      }
    }

    stage('Copy Files to the Container') {
      steps {
        sh '''docker cp ${DEB_PACKAGE} ${CONTAINER_NAME}:/tmp/htop_3.2.2-2_amd64.deb
docker cp ${SCRIPT_PATH} ${CONTAINER_NAME}:/tmp/file_count.sh'''
      }
    }

    stage('Install DEB Package inside the container') {
      steps {
        sh 'docker exec -u root ${CONTAINER_NAME} bash -c "dpkg -i /tmp/htop_3.2.2-2_amd64.deb || apt-get install -f -y"'
      }
    }

    stage('Execute Script inside the container') {
      steps {
        sh 'docker exec -u root ${CONTAINER_NAME} bash /tmp/file_count.sh'
      }
    }

    stage('Cleanup: stop and remove the container') {
      steps {
        sh '''docker stop ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}'''
      }
    }

  }
  environment {
    DOCKER_IMAGE = 'debian:12'
    CONTAINER_NAME = 'kitimist-container'
    SCRIPT_PATH = '/home/file_count.sh'
    DEB_PACKAGE = '/home/htop_3.2.2-2_amd64.deb'
  }
}