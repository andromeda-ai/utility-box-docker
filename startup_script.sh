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

# Edit the PAM common-session file to create home directories
echo "session optional pam_mkhomedir.so" >> /etc/pam.d/common-session


# Start SSH service
service ssh start

# Start SSSD service
rm -f /var/run/sssd.pid
sssd -i &

# Keep the container running
tail -f /dev/null
