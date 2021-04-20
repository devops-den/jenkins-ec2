#!/bin/bash
# Create Jenkins credentials function
create_jenkins_creds() {
    # kringle-jenkins-bitbucket credentials xml content
    cat > /tmp/kringle-devops-jenkins.xml << EOF
    <com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl plugin="credentials@2.3.17">
      <scope>GLOBAL</scope>
      <id>kringle-jenkins-bitbucket</id>
      <description>kringle-devops-jenkins</description>
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
create_jenkins_multi_branch_pipeline() {
    # kringle-loyalty-api-ecs job xml content
    cat > /tmp/kringle-loyalty-api-ecs.xml << EOF
<?xml version='1.1' encoding='UTF-8'?>
<org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject plugin="workflow-multibranch@2.23">
  <actions/>
  <description></description>
  <properties>
    <org.jenkinsci.plugins.docker.workflow.declarative.FolderConfig plugin="docker-workflow@1.26">
      <dockerLabel></dockerLabel>
      <registry plugin="docker-commons@1.17"/>
    </org.jenkinsci.plugins.docker.workflow.declarative.FolderConfig>
  </properties>
  <folderViews class="jenkins.branch.MultiBranchProjectViewHolder" plugin="branch-api@2.6.3">
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
  </folderViews>
  <healthMetrics/>
  <icon class="jenkins.branch.MetadataActionFolderIcon" plugin="branch-api@2.6.3">
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
  </icon>
  <orphanedItemStrategy class="com.cloudbees.hudson.plugins.folder.computed.DefaultOrphanedItemStrategy" plugin="cloudbees-folder@6.15">
    <pruneDeadBranches>true</pruneDeadBranches>
    <daysToKeep>-1</daysToKeep>
    <numToKeep>-1</numToKeep>
  </orphanedItemStrategy>
  <triggers/>
  <disabled>false</disabled>
  <sources class="jenkins.branch.MultiBranchProject\$BranchSourceList" plugin="branch-api@2.6.3">
    <data>
      <jenkins.branch.BranchSource>
        <source class="com.cloudbees.jenkins.plugins.bitbucket.BitbucketSCMSource" plugin="cloudbees-bitbucket-branch-source@2.9.8">
          <id>96e4b962-6f45-4cad-9580-2c358a856035</id>
          <serverUrl>https://bitbucket.org</serverUrl>
          <credentialsId>kringle-devops-jenkins</credentialsId>
          <repoOwner>rohuma</repoOwner>
          <repository>kringle-loyalty-api</repository>
          <traits>
            <com.cloudbees.jenkins.plugins.bitbucket.BranchDiscoveryTrait>
              <strategyId>1</strategyId>
            </com.cloudbees.jenkins.plugins.bitbucket.BranchDiscoveryTrait>
            <com.cloudbees.jenkins.plugins.bitbucket.OriginPullRequestDiscoveryTrait>
              <strategyId>1</strategyId>
            </com.cloudbees.jenkins.plugins.bitbucket.OriginPullRequestDiscoveryTrait>
            <com.cloudbees.jenkins.plugins.bitbucket.ForkPullRequestDiscoveryTrait>
              <strategyId>1</strategyId>
              <trust class="com.cloudbees.jenkins.plugins.bitbucket.ForkPullRequestDiscoveryTrait$TrustTeamForks"/>
            </com.cloudbees.jenkins.plugins.bitbucket.ForkPullRequestDiscoveryTrait>
            <jenkins.scm.impl.trait.WildcardSCMHeadFilterTrait plugin="scm-api@2.6.4">
              <includes>INCLUDE_BRANCHES_KRINGLE_LOYALTY</includes>
              <excludes></excludes>
            </jenkins.scm.impl.trait.WildcardSCMHeadFilterTrait>
          </traits>
        </source>
        <strategy class="jenkins.branch.DefaultBranchPropertyStrategy">
          <properties class="empty-list"/>
        </strategy>
      </jenkins.branch.BranchSource>
    </data>
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
  </sources>
  <factory class="org.jenkinsci.plugins.workflow.multibranch.WorkflowBranchProjectFactory">
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
    <scriptPath>Jenkinsfile</scriptPath>
  </factory>
</org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject>
EOF

    cat > /tmp/cms-platform-api-ecs.xml << EOF
<?xml version='1.1' encoding='UTF-8'?>
<org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject plugin="workflow-multibranch@2.23">
  <actions/>
  <description></description>
  <properties>
    <org.jenkinsci.plugins.docker.workflow.declarative.FolderConfig plugin="docker-workflow@1.26">
      <dockerLabel></dockerLabel>
      <registry plugin="docker-commons@1.17"/>
    </org.jenkinsci.plugins.docker.workflow.declarative.FolderConfig>
  </properties>
  <folderViews class="jenkins.branch.MultiBranchProjectViewHolder" plugin="branch-api@2.6.3">
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
  </folderViews>
  <healthMetrics/>
  <icon class="jenkins.branch.MetadataActionFolderIcon" plugin="branch-api@2.6.3">
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
  </icon>
  <orphanedItemStrategy class="com.cloudbees.hudson.plugins.folder.computed.DefaultOrphanedItemStrategy" plugin="cloudbees-folder@6.15">
    <pruneDeadBranches>true</pruneDeadBranches>
    <daysToKeep>-1</daysToKeep>
    <numToKeep>-1</numToKeep>
  </orphanedItemStrategy>
  <triggers/>
  <disabled>false</disabled>
  <sources class="jenkins.branch.MultiBranchProject\$BranchSourceList" plugin="branch-api@2.6.3">
    <data>
      <jenkins.branch.BranchSource>
        <source class="com.cloudbees.jenkins.plugins.bitbucket.BitbucketSCMSource" plugin="cloudbees-bitbucket-branch-source@2.9.8">
          <id>96e4b962-6f45-4cad-9580-2c358a856035</id>
          <serverUrl>https://bitbucket.org</serverUrl>
          <credentialsId>kringle-devops-jenkins</credentialsId>
          <repoOwner>rohuma</repoOwner>
          <repository>cms-platform-api</repository>
          <traits>
            <com.cloudbees.jenkins.plugins.bitbucket.BranchDiscoveryTrait>
              <strategyId>1</strategyId>
            </com.cloudbees.jenkins.plugins.bitbucket.BranchDiscoveryTrait>
            <com.cloudbees.jenkins.plugins.bitbucket.OriginPullRequestDiscoveryTrait>
              <strategyId>1</strategyId>
            </com.cloudbees.jenkins.plugins.bitbucket.OriginPullRequestDiscoveryTrait>
            <com.cloudbees.jenkins.plugins.bitbucket.ForkPullRequestDiscoveryTrait>
              <strategyId>1</strategyId>
              <trust class="com.cloudbees.jenkins.plugins.bitbucket.ForkPullRequestDiscoveryTrait$TrustTeamForks"/>
            </com.cloudbees.jenkins.plugins.bitbucket.ForkPullRequestDiscoveryTrait>
            <jenkins.scm.impl.trait.WildcardSCMHeadFilterTrait plugin="scm-api@2.6.4">
              <includes>INCLUDE_BRANCHES_CMS_PLATFORM</includes>
              <excludes></excludes>
            </jenkins.scm.impl.trait.WildcardSCMHeadFilterTrait>
          </traits>
        </source>
        <strategy class="jenkins.branch.DefaultBranchPropertyStrategy">
          <properties class="empty-list"/>
        </strategy>
      </jenkins.branch.BranchSource>
    </data>
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
  </sources>
  <factory class="org.jenkinsci.plugins.workflow.multibranch.WorkflowBranchProjectFactory">
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
    <scriptPath>Jenkinsfile</scriptPath>
  </factory>
</org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject>
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

echo "jenkins.model.Jenkins.instance.securityRealm.createAccount(\"$custom_user\", \"$custom_pass\")" | sudo java -jar jenkins-cli.jar -auth admin:$passwd -s http://$ipaddr:8080/ groovy =

################## Create Jenkins Jobs ##################
create_jenkins_multi_branch_pipeline
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

# Getting values for creating jenkins credentials from AWS
region="$(curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)"
SSM_SECRETS=$(aws ssm get-parameters --names "BB_JENKINS_PSWD" \
                                "BB_JENKINS_USER" \
                                "JENKINS_ACCESS_KEY_ID" \
                                "JENKINS_SECRET_ACCESS_KEY" \
                                --with-decryption --query "Parameters[*]" --region $region)

BB_JENKINS_PSWD=$(echo $SSM_SECRETS | jq '.[] | select(.Name=="BB_JENKINS_PSWD")' | jq '.Value' -r)
BB_JENKINS_USER=$(echo $SSM_SECRETS | jq '.[] | select(.Name=="BB_JENKINS_USER")' | jq '.Value' -r)
JENKINS_ACCESS_KEY_ID=$(echo $SSM_SECRETS | jq '.[] | select(.Name=="JENKINS_ACCESS_KEY_ID")' | jq '.Value' -r)
JENKINS_SECRET_ACCESS_KEY=$(echo $SSM_SECRETS | jq '.[] | select(.Name=="JENKINS_SECRET_ACCESS_KEY")' | jq '.Value' -r)

sed -i "s|BB_JENKINS_PSWD|${BB_JENKINS_PSWD}|g" /tmp/kringle-devops-jenkins.xml
sed -i "s|BB_JENKINS_USER|${BB_JENKINS_USER}|g" /tmp/kringle-devops-jenkins.xml
sed -i "s|JENKINS_ACCESS_KEY_ID|${JENKINS_ACCESS_KEY_ID}|g" /tmp/awscreds-kringle-api.xml
sed -i "s|JENKINS_SECRET_ACCESS_KEY|${JENKINS_SECRET_ACCESS_KEY}|g" /tmp/awscreds-kringle-api.xml

INCLUDE_BRANCHES_KRINGLE_LOYALTY="feature/lambda kringle-loyalty-docker"
INCLUDE_BRANCHES_CMS_PLATFORM="feature/lambda kringle-loyalty-docker"

sed -i "s|INCLUDE_BRANCHES_KRINGLE_LOYALTY|$INCLUDE_BRANCHES_KRINGLE_LOYALTY|g" /tmp/kringle-loyalty-api-ecs.xml
sed -i "s|INCLUDE_BRANCHES_CMS_PLATFORM|$INCLUDE_BRANCHES_CMS_PLATFORM|g" /tmp/cms-platform-api-ecs.xml

# Create jenkins bitbucket access credentials
sudo java -jar jenkins-cli.jar -auth $custom_user:$custom_pass -s http://$ipaddr:8080 create-credentials-by-xml system::system::jenkins _ < /tmp/kringle-devops-jenkins.xml

# Create aws access credentails
sudo java -jar jenkins-cli.jar -auth $custom_user:$custom_pass -s http://$ipaddr:8080 create-credentials-by-xml system::system::jenkins _ < /tmp/awscreds-kringle-api.xml

# Create kringle loyalty api multi branch pipeline
sudo java -jar jenkins-cli.jar -auth $custom_user:$custom_pass -s http://$ipaddr:8080 create-job kringle-loyalty-api-ecs < /tmp/kringle-loyalty-api-ecs.xml

# Create cms platform api multi branch pipeline
sudo java -jar jenkins-cli.jar -auth $custom_user:$custom_pass -s http://$ipaddr:8080 create-job cms-platform-api-ecs < /tmp/cms-platform-api-ecs.xml

# Run inside project
# composer require bref/bref
# composer require bref/laravel-bridge
