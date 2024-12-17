# Use  Jenkins LTS image as the base image
FROM jenkins/jenkins:lts

# Switch to root to install plugins
USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    gnupg2 \
    lsb-release

# Install plugins 
RUN jenkins-plugin-cli --plugins \
    git \
    docker-workflow \
    blueocean \
    pipeline-stage-view

# Switch back to the default Jenkins user
USER jenkins

# Start Jenkins
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]

