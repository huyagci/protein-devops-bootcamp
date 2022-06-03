# Set time zone to UTC+3
sudo timedatectl set-timezone Europe/Istanbul

# Enable NTP and system clock sync
sudo timedatectl set-ntp true

# Add Git PPA
sudo add-apt-repository ppa:git-core/ppa -y

# Download latest package information
sudo apt update

# Get JDK
sudo wget https://download.oracle.com/java/18/latest/jdk-18_linux-x64_bin.deb -P /tmp

# Install JDK
sudo dpkg -i /tmp/jdk-18_linux-x64_bin.deb

# Set Alternative
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-18/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-18/bin/javac 1
sudo update-alternatives --config java

# Set JAVA_HOME
echo "JAVA_HOME=/usr/lib/jvm/jdk-18" >> /etc/environment
source /etc/environment

# Get Maven
sudo wget https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.8.5/apache-maven-3.8.5-bin.tar.gz -P /usr

# Unzip Maven
sudo tar -xf /usr/apache-maven-3.8.5-bin.tar.gz -C /usr

# Set Alternative
sudo update-alternatives --install /usr/bin/mvn maven /usr/apache-maven-3.8.5/bin/mvn 1001

# Set Maven Environment Variables
echo "MAVEN_HOME=/usr/apache-maven-3.8.5" >> /etc/environment
echo "M2_HOME=/usr/apache-maven-3.8.5" >> /etc/environment
export PATH=${MAVEN_HOME}/bin:${PATH}

# Fix Installs
sudo apt --fix-broken install -y

# Upgrade Git to latest version
sudo apt upgrade git -y

# Install zip
sudo apt install zip -y

# Cleanup Downloads
sudo rm -f /tmp/jdk-18_linux-x64_bin.deb
sudo rm -f /usr/apache-maven-3.8.5-bin.tar.gz

# Set Git Conf - will be edited later

git config --system user.name "maven-builder"
git config --system user.email "maven-builder@bashscript.com"

#Initialize a dummy git repository inside the project folders
# git init
# git add --all && git commit -am.
# git commit -m "Initial commit"
# ?git branch new branch?

# Make executable scripts

# chmod +x /opt/scripts/build_helper.sh 