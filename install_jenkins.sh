#!/bin/bash
# Create Jenkins credentials function
create_jenkins_creds() {
    # kringle-jenkins-bitbucket credentials xml content
    cat > /tmp/kringle-jenkins-bitbucket.xml << EOF
    <com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl plugin="credentials@2.3.17">
      <scope>GLOBAL</scope>
      <id>kringle-jenkins-bitbucket</id>
      <description>kringle-jenkins-bitbucket</description>
      <username>BB_JENKINS_USER</username>
      <password>BB_JENKINS_PSWD</password>
    </com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
EOF

    # aws credentials xml content
    cat > /tmp/awscreds-kringle-api.xml << EOF
    <com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl plugin="aws-credentials@1.28.1">
      <scope>GLOBAL</scope>
      <id>AWSCRED-KRINGLE-API</id>
      <description></description>
      <accessKey>JENKINS_ACCESS_KEY_ID</accessKey>
      <secretKey>JENKINS_SECRET_ACCESS_KEY</secretKey>
      <iamRoleArn></iamRoleArn>
      <iamMfaSerialNumber></iamMfaSerialNumber>
    </com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl>
EOF
}

# Create Jenkins Jobs function
create_jenkins_jobs_init() {
    # kringle-loyalty-api-ecs job xml content
    cat > /tmp/kringle-loyalty-api-ecs.xml << EOF
<?xml version='1.1' encoding='UTF-8'?>
<flow-definition plugin="workflow-job@2.40">
  <actions>
    <org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobAction plugin="pipeline-model-definition@1.8.4"/>
    <org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobPropertyTrackerAction plugin="pipeline-model-definition@1.8.4">
      <jobProperties>
        <string>jenkins.model.BuildDiscarderProperty</string>
      </jobProperties>
      <triggers/>
      <parameters/>
      <options/>
    </org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobPropertyTrackerAction>
  </actions>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <jenkins.model.BuildDiscarderProperty>
      <strategy class="hudson.tasks.LogRotator">
        <daysToKeep>30</daysToKeep>
        <numToKeep>30</numToKeep>
        <artifactDaysToKeep>-1</artifactDaysToKeep>
        <artifactNumToKeep>-1</artifactNumToKeep>
      </strategy>
    </jenkins.model.BuildDiscarderProperty>
    <org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
      <triggers>
        <org.jenkinsci.plugins.gwt.GenericTrigger plugin="generic-webhook-trigger@1.72">
          <spec></spec>
          <regexpFilterText></regexpFilterText>
          <regexpFilterExpression></regexpFilterExpression>
          <printPostContent>false</printPostContent>
          <printContributedVariables>false</printContributedVariables>
          <causeString>Generic Cause - Commit</causeString>
          <token>kringle-loyalty-api</token>
          <tokenCredentialId></tokenCredentialId>
          <silentResponse>false</silentResponse>
          <overrideQuietPeriod>false</overrideQuietPeriod>
        </org.jenkinsci.plugins.gwt.GenericTrigger>
      </triggers>
    </org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.90">
    <scm class="hudson.plugins.git.GitSCM" plugin="git@4.7.1">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>https://sajjas-kringle@bitbucket.org/rohuma/kringle-loyalty-api.git</url>
          <credentialsId>kringle-jenkins-bitbucket</credentialsId>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>*/kringle-loyalty-docker</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
      <submoduleCfg class="empty-list"/>
      <extensions>
        <hudson.plugins.git.extensions.impl.CleanBeforeCheckout>
          <deleteUntrackedNestedRepositories>true</deleteUntrackedNestedRepositories>
        </hudson.plugins.git.extensions.impl.CleanBeforeCheckout>
      </extensions>
    </scm>
    <scriptPath>Jenkinsfile</scriptPath>
    <lightweight>false</lightweight>
  </definition>
  <triggers/>
  <disabled>false</disabled>
</flow-definition>
EOF
    # kringle-loyalty-api-lambda-cron job xml content
    cat > /tmp/kringle-loyalty-api-lambda-cron.xml << EOF
<?xml version='1.1' encoding='UTF-8'?>
<flow-definition plugin="workflow-job@2.40">
  <actions>
    <org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobAction plugin="pipeline-model-definition@1.8.4"/>
    <org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobPropertyTrackerAction plugin="pipeline-model-definition@1.8.4">
      <jobProperties>
        <string>jenkins.model.BuildDiscarderProperty</string>
      </jobProperties>
      <triggers/>
      <parameters/>
      <options/>
    </org.jenkinsci.plugins.pipeline.modeldefinition.actions.DeclarativeJobPropertyTrackerAction>
  </actions>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <jenkins.model.BuildDiscarderProperty>
      <strategy class="hudson.tasks.LogRotator">
        <daysToKeep>30</daysToKeep>
        <numToKeep>30</numToKeep>
        <artifactDaysToKeep>-1</artifactDaysToKeep>
        <artifactNumToKeep>-1</artifactNumToKeep>
      </strategy>
    </jenkins.model.BuildDiscarderProperty>
    <org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
      <triggers>
        <org.jenkinsci.plugins.gwt.GenericTrigger plugin="generic-webhook-trigger@1.72">
          <spec></spec>
          <regexpFilterText></regexpFilterText>
          <regexpFilterExpression></regexpFilterExpression>
          <printPostContent>false</printPostContent>
          <printContributedVariables>false</printContributedVariables>
          <causeString>Generic Cause - Commit</causeString>
          <token>kringle-loyalty-api</token>
          <tokenCredentialId></tokenCredentialId>
          <silentResponse>false</silentResponse>
          <overrideQuietPeriod>false</overrideQuietPeriod>
        </org.jenkinsci.plugins.gwt.GenericTrigger>
      </triggers>
    </org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.90">
    <scm class="hudson.plugins.git.GitSCM" plugin="git@4.7.1">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>https://sajjas-kringle@bitbucket.org/rohuma/kringle-loyalty-api.git</url>
          <credentialsId>kringle-jenkins-bitbucket</credentialsId>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>feature/lambda</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
      <submoduleCfg class="empty-list"/>
      <extensions>
        <hudson.plugins.git.extensions.impl.CleanBeforeCheckout>
          <deleteUntrackedNestedRepositories>true</deleteUntrackedNestedRepositories>
        </hudson.plugins.git.extensions.impl.CleanBeforeCheckout>
      </extensions>
    </scm>
    <scriptPath>Jenkinsfile</scriptPath>
    <lightweight>false</lightweight>
  </definition>
  <triggers/>
  <disabled>false</disabled>
</flow-definition>
EOF
}

#################### Installing tools ####################
sudo yum -y update
sleep 10

echo "Install Java JDK 8"
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk-devel
sleep 10

echo "Install git"
sudo yum install -y git jq
sleep 10

echo "Install Docker engine"
sudo yum update -y
sudo yum install docker -v 19.03.13-ce -y
sudo chkconfig docker on
sleep 10

echo "Install Jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum -y update
sleep 10
sudo yum install -y jenkins-2.277.1
sudo usermod -a -G docker jenkins
sudo chkconfig jenkins on

sudo service docker start
sudo service jenkins start
sleep 60

ipaddr=$(hostname -I | awk '{print $1}')
# Install required jenkins plugins
sudo wget http://$ipaddr:8080/jnlpJars/jenkins-cli.jar

passwd=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
custom_user="kringle"
custom_pass="kringle123"

echo "jenkins.model.Jenkins.instance.securityRealm.createAccount($custom_user, $custom_pass)" | sudo java -jar jenkins-cli.jar -auth admin:$passwd -s http://$ipaddr:8080/ groovy =

################## Create Jenkins Jobs ##################
create_jenkins_jobs_init
################## Create Jenkins Creds ##################
create_jenkins_creds

################## Install Jenkins Plugins ##################
sudo java -jar jenkins-cli.jar -auth admin:$passwd -s http://$ipaddr:8080 install-plugin amazon-ecr:1.6 \
                                                                                        cloudbees-bitbucket-branch-source:2.9.7 \
                                                                                        bitbucket:1.1.27 \
                                                                                        command-launcher:1.5 \
                                                                                        docker-workflow:1.26 \
                                                                                        docker-plugin:1.2.2 \
                                                                                        generic-webhook-trigger:1.72 \
                                                                                        jdk-tool:1.5 \
                                                                                        workflow-aggregator:2.6 \
                                                                                        ws-cleanup:0.39

# Disable initial setup in jenkins
sudo sed -i s/'JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true"'/'JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"'/g /etc/sysconfig/jenkins
sudo service jenkins restart
sleep 30

################## Install serverless for lambda cron deployment ##################

# Instatll nvm
cat > /tmp/subscript.sh << EOF
#!/bin/bash
echo "Setting up NodeJS Environment"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
 
echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> $HOME/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> $HOME/.bashrc
 
# Dot source the files to ensure that variables are available within the current shell
. $HOME/.nvm/nvm.sh
. $HOME/.bashrc
 
# Install node
nvm install node -v 15.14.0
npm install -g agentkeepalive
npm install -g npm@7.9.0

# Install serverless
npm install -g serverless
EOF

chmod +x /tmp/subscript.sh
sleep 1; . /tmp/subscript.sh

# checking versions
echo "checking versions..."
nvm -v
node_path=$(which node)
node -v
npm_path=$(which npm)
npm -v
serverless_path=$(which serverless)
serverless -v

# creating symlinks for npm node serverless
sudo ln -s $node_path /usr/local/bin/node
sudo ln -s $npm_path /usr/local/bin/npm
sudo ln -s $serverless_path /usr/local/bin/serverless

# Install php7.4
sudo yum install epel-release yum-utils -y
sudo amazon-linux-extras install epel -y
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable remi-php74
sudo amazon-linux-extras install -y php7.4
sudo yum install -y php-mbstring
sudo yum install -y php-simplexml

# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# Create kringle-loyalty-api ecs service job
sudo java -jar jenkins-cli.jar -auth $custom_user:$custom_pass -s http://$ipaddr:8080 create-job kringle-loyalty-api-ecs < /tmp/kringle-loyalty-api-ecs.xml

# Create kringle-loyalty-api-lambda-cron service job
sudo java -jar jenkins-cli.jar -auth $custom_user:$custom_pass -s http://$ipaddr:8080 create-job kringle-loyalty-api-lambda-cron < /tmp/kringle-loyalty-api-lambda-cron.xml

# Getting values for creating jenkins credentials from AWS
SSM_SECRETS=$(aws ssm get-parameters --names "BB_JENKINS_PSWD" \
                                "BB_JENKINS_USER" \
                                "JENKINS_ACCESS_KEY_ID" \
                                "JENKINS_SECRET_ACCESS_KEY" \
                                --with-decryption --query "Parameters[*]")

BB_JENKINS_PSWD=$(echo $SSM_SECRETS | jq '.[] | select(.Name=="BB_JENKINS_PSWD")' | jq '.Value' -r)
BB_JENKINS_USER=$(echo $SSM_SECRETS | jq '.[] | select(.Name=="BB_JENKINS_USER")' | jq '.Value' -r)
JENKINS_ACCESS_KEY_ID=$(echo $SSM_SECRETS | jq '.[] | select(.Name=="JENKINS_ACCESS_KEY_ID")' | jq '.Value' -r)
JENKINS_SECRET_ACCESS_KEY=$(echo $SSM_SECRETS | jq '.[] | select(.Name=="JENKINS_SECRET_ACCESS_KEY")' | jq '.Value' -r)

sed -i "s/BB_JENKINS_PSWD/${BB_JENKINS_PSWD}/g" /tmp/kringle-jenkins-bitbucket.xml
sed -i "s/BB_JENKINS_USER/${BB_JENKINS_USER}/g" /tmp/kringle-jenkins-bitbucket.xml
sed -i "s/JENKINS_ACCESS_KEY_ID/${JENKINS_ACCESS_KEY_ID}/g" /tmp/awscreds-kringle-api.xml
sed -i "s/JENKINS_SECRET_ACCESS_KEY/${JENKINS_SECRET_ACCESS_KEY}/g" /tmp/awscreds-kringle-api.xml

# Create jenkins bitbucket access credentials
sudo java -jar jenkins-cli.jar -auth $custom_user:$custom_pass -s http://$ipaddr:8080 create-credentials-by-xml system::system::jenkins _ < /tmp/kringle-jenkins-bitbucket.xml

# Create aws access credentails
sudo java -jar jenkins-cli.jar -auth $custom_user:$custom_pass -s http://$ipaddr:8080 create-credentials-by-xml system::system::jenkins _ < /tmp/awscreds-kringle-api.xml

# Run inside project
# composer require bref/bref
# composer require bref/laravel-bridge
