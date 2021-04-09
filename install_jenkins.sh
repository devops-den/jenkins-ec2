#!/bin/bash
sudo yum -y update

echo "Install Java JDK 8"
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk-devel

echo "Install Maven"
sudo yum install -y maven 

echo "Install git"
sudo yum install -y git jq

echo "Install Docker engine"
sudo yum update -y
sudo yum install docker -v 19.03.13-ce -y
sudo chkconfig docker on

echo "Install Jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install -y jenkins -v 2.277.1
sudo usermod -a -G root jenkins
sudo chkconfig jenkins on

sudo service docker start
sudo service jenkins start

# Disable initial setup in jenkins
sudo sed -i s/'JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"'/'JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true"'/g /etc/sysconfig/jenkins
sudo service jenkins restart

# Install required jenkins plugins
sudo wget http://localhost:8080/jnlpJars/jenkins-cli.jar

passwd=$(cat /var/lib/jenkins/secrets/initialAdminPassword)

sudo java -jar jenkins-cli.jar -auth admin:$passwd -s http://localhost:8080 install-plugin amazon-ecr:1.6 \
                                                                                        cloudbees-bitbucket-branch-source:2.9.7 \
                                                                                        bitbucket:1.1.27 \
                                                                                        command-launcher:1.5 \
                                                                                        docker-workflow:1.26 \
                                                                                        docker-plugin:1.2.2 \
                                                                                        generic-webhook-trigger:1.72 \
                                                                                        jdk-tool:1.5 \
                                                                                        workflow-aggregator:2.6 \
                                                                                        ws-cleanup:0.39