#!/bin/bash

# Log file location
LOG_FILE="/var/log/setup.log"

# Function to log messages
log() {
  local message="$1"
  echo "$(date +"%Y-%m-%d %T"): $message"
  echo "$(date +"%Y-%m-%d %T"): $message" >> "$LOG_FILE"
}

# Set the provided public key for the SSH user
log "Setting up SSH key for 'root'"
mkdir -p /root/.ssh
echo "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys

# Set ownership and permissions
chown -R root:root /root/.ssh
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# Start SSH service
log "Starting SSH service"
service ssh start

# Log message indicating successful setup
log "Setup completed successfully."

# Keep the container running
tail -f /dev/null
