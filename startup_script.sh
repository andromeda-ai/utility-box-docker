#!/bin/bash

# Wait a sec for OpenLDAP to start
sleep 1

# Create the Privilege Separation directory for SSH
mkdir /var/run/sshd

# Edit the SSHD configuration to use PAM
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/UsePAM no/UsePAM yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# Function to log messages
log() {
  echo "$(date +"%Y-%m-%d %T"): $1"
}

# Start SSH service
log "Starting SSH service"
service ssh start

# Start SSSD service
log "Starting SSSD service"
rm -f /var/run/sssd.pid
sssd -i
