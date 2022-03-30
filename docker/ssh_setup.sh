#!/usr/bin/env bash

echo "Setup openrc ..." && openrc && touch /run/openrc/softlevel

# BEGIN: Initialize ssh daemon as early as possible

echo Updating /etc/ssh/sshd_config to use PORT $SSH_PORT
sed -i "s/SSH_PORT/$SSH_PORT/g" /etc/ssh/sshd_config

echo Starting ssh service...
rc-service sshd start

# We want all ssh sesions to start in the /home directory
echo "cd /home" >> /etc/profile


# #!/bin/sh

# ssh-keygen -A

# #prepare run dir
# if [ ! -d "/var/run/sshd" ]; then
#     mkdir -p /var/run/sshd
# fi