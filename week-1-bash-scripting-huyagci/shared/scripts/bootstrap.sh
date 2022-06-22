# Set time zone to UTC+3
sudo timedatectl set-timezone Europe/Istanbul

# Enable NTP and system clock sync
sudo timedatectl set-ntp true

# Update System
sudo apt update

# Get ssmtp & mailutils and install it without a prompt
sudo apt install ssmtp -y
sudo apt install mailutils -y

# Overwrite existing ssmtp config
sudo cp /opt/scripts/ssmtp.conf /etc/ssmtp/ssmtp.conf

# Set cron jobs for scripts to be executed on specified time frames
echo '05 23     * * *   root    cd /opt/scripts/ ; ./backup_home_dirs.sh >/dev/null 2>&1' >> /etc/crontab
echo '* *     * * *   root    cd /opt/scripts/ ; ./disk_usage_alert.sh >/dev/null 2>&1' >> /etc/crontab