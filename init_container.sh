#!/bin/sh

# echo Starting ssh service...
/usr/sbin/sshd

echo search a >> /etc/resolv.conf

CMD="java -jar /opt/app.jar"

echo Running command: "$CMD"
$CMD