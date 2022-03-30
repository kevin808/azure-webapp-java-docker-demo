ARG BASE_IMAGE=mcr.microsoft.com/java/jre-headless:8u212-zulu-alpine-with-tools
FROM $BASE_IMAGE

RUN addgroup -S app && adduser -S reduuser -G app && echo "reduuser:Docker!" | chpasswd

COPY --chown=reduuser:app docker/ssh_setup.sh /tmp/sh/
COPY docker/sshd_config /etc/ssh/

# Copy and configure the ssh_setup file
RUN mkdir -p /tmp
COPY ssh_setup.sh /tmp
RUN chmod +x /tmp/ssh_setup.sh \
    && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null)

ENV SSH_PORT 2222
ENV PORT 8080

RUN apk add --update openssh-server openrc \
        && echo "root:Docker!" | chpasswd

# RUN chmod +x /tmp/sh/ssh_setup.sh \
#     && (sleep 1;/tmp/sh/ssh_setup.sh 2＞&1 ＞  /dev/null) \
#     && rm -rf /tmp/sh/ssh_setup.sh

EXPOSE $PORT $SSH_PORT

# USER reduuser:app
ADD app.jar /opt/app.jar
ADD init_container.sh /bin/init_container.sh
ENTRYPOINT ["/bin/init_container.sh"]

