# Set time zone to UTC+3
sudo timedatectl set-timezone Europe/Istanbul

# Enable NTP and system clock synchronization.
sudo timedatectl set-ntp true

# Add Git PPA
sudo add-apt-repository ppa:git-core/ppa -y

# Download latest package information.
sudo apt update

# Get JDK.
sudo wget https://download.oracle.com/java/18/latest/jdk-18_linux-x64_bin.deb -P /tmp

# Install JDK.
sudo dpkg -i /tmp/jdk-18_linux-x64_bin.deb

# Update alternative libraries for Java.
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-18/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-18/bin/javac 1
sudo update-alternatives --config java

# Set JAVA_HOME enviroment.
echo "JAVA_HOME=/usr/lib/jvm/jdk-18" >> /etc/environment
source /etc/environment

# Get Maven management tool.
sudo wget https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.8.5/apache-maven-3.8.5-bin.tar.gz -P /usr

# Unzip Maven.
sudo tar -xf /usr/apache-maven-3.8.5-bin.tar.gz -C /usr

# Update alternative libraries for Maven.
sudo update-alternatives --install /usr/bin/mvn maven /usr/apache-maven-3.8.5/bin/mvn 1001

# Set Maven environment variables.
echo "MAVEN_HOME=/usr/apache-maven-3.8.5" >> /etc/environment
echo "M2_HOME=/usr/apache-maven-3.8.5" >> /etc/environment
export PATH=${MAVEN_HOME}/bin:${PATH}

# Fix broken installs first.
sudo apt --fix-broken install -y

# Then upgrade Git to latest version.
sudo apt upgrade git -y

# Install "zip" utility.
sudo apt install zip -y

# Cleanup downloaded archives.
sudo rm -f /tmp/jdk-18_linux-x64_bin.deb
sudo rm -f /usr/apache-maven-3.8.5-bin.tar.gz

# Set Git related configurations for easy use of the main script.
sudo git config --system user.name "maven-builder"
sudo git config --system user.email "maven-builder@bashscript.com"
sudo git config --system --add safe.directory /opt/project/java
sudo git config --global --add safe.directory /opt/project/java

# Give execution permission to scripts.
sudo chmod 777 /opt/scripts/bootstrap.sh
sudo chmod 777 /opt/scripts/git_helper.sh
sudo chmod 777 /opt/scripts/build_helper.sh

# Set system-wide aliases to easy use of the scripts
sudo echo "# Protein DevOps Bootcamp - Week 2 Assignment Aliases" >> /etc/bash.bashrc

# Git Helper
sudo echo "alias githelper='/opt/scripts/git_helper.sh'" >> /etc/bash.bashrc

# Build Helper
sudo echo "alias buildhelper='/opt/scripts/build_helper.sh'" >> /etc/bash.bashrc

# Activation
source /etc/bash.bashrc
