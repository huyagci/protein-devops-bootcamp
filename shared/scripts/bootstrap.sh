# Set time zone to UTC+3
sudo timedatectl set-timezone Europe/Istanbul

# Enable NTP and system clock synchronization.
sudo timedatectl set-ntp true

# Download latest package information.
sudo apt update

# Set up the repository
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# set up the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Install Docker Compose
sudo apt install docker-compose -y

# Fix Docker daemon socket error
sudo chmod 666 /var/run/docker.sock

# Give execution permission to scripts.
sudo chmod 777 /opt/scripts/bootstrap.sh
sudo chmod 777 /opt/scripts/sailboat.sh

# Set system-wide aliases to easy use of the scripts
sudo echo "# Protein DevOps Bootcamp - Week 3 Assignment Aliases" >> /etc/bash.bashrc

# Define an alias to the system as "sailboat" for easy use.
sudo echo "alias sailboat='/opt/scripts/sailboat.sh'" >> /etc/bash.bashrc

# Activation
source /etc/bash.bashrc