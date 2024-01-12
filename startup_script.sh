#!/bin/bash

# Create SSH user
useradd -m -s /bin/bash sshuser

# Set the provided public key for the SSH user
mkdir -p /home/sshuser/.ssh
echo "$SSH_PUBLIC_KEY" > /home/sshuser/.ssh/authorized_keys

# Set ownership and permissions
chown -R sshuser:sshuser /home/sshuser/.ssh
chmod 700 /home/sshuser/.ssh
chmod 600 /home/sshuser/.ssh/authorized_keys

# Start SSH service
service ssh start

# Keep the container running
tail -f /dev/null
