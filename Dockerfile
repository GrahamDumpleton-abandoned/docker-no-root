FROM ubuntu:latest

RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends sudo vim nano openssl && \
    rm -rf /var/lib/apt/lists/*

#RUN groupadd wheel -g 11 && \
#    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
#    useradd -m -s /bin/bash -N -u 1001 default && \
#    chmod g+w /etc/passwd

RUN echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    useradd -m -s /bin/bash -N -u 1001 default && \
    chmod g+w /etc/passwd

COPY entrypoint.sh /

USER 1001

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "tail", "-f", "/dev/null" ] 
