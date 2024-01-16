#!/bin/bash

# Wait a sec for OpenLDAP to start
sleep 1

# Create the Privilege Separation directory for SSH
mkdir /var/run/sshd

# Edit the SSHD configuration to use PAM
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/UsePAM no/UsePAM yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

chmod 600 /etc/sshd/sshd_config /etc/sssd/sssd.conf
chown root:root /etc/sssd/sssd.conf

# Log file location
LOG_FILE="/var/log/setup.log"

# Function to log messages
log() {
  local message="$1"
  echo "$(date +"%Y-%m-%d %T"): $message"
  echo "$(date +"%Y-%m-%d %T"): $message" >> "$LOG_FILE"
}

# Start SSH service
log "Starting SSH service"
service ssh start

# Start SSSD service
log "Starting SSSD service"
service sssd start

# Keep the container running
tail -f /dev/null
