#!/bin/bash
set -e

# Wait a sec for OpenLDAP to start
sleep 1

# Create the Privilege Separation directory for SSH
mkdir /var/run/sshd

# Edit the SSHD configuration to use PAM
sed -i -e 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' \
       -e 's/UsePAM no/UsePAM yes/' \
       -e 's/#PasswordAuthentication yes/PasswordAuthentication yes/' \
       -e 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' \
       /etc/ssh/sshd_config

# Add configuration options to sshd_config
cat <<EOL >> /etc/ssh/sshd_config
AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys
AuthorizedKeysCommandUser root
ClientAliveInterval 60
ClientAliveCountMax 2
StreamLocalBindUnlink yes
EOL

# Edit the PAM common-session file to create home directories
echo "session optional pam_mkhomedir.so" >> /etc/pam.d/common-session


# Start SSH service
service ssh start

# Start SSSD service
rm -f /var/run/sssd.pid
sssd -i &

# Keep the container running
tail -f /dev/null
