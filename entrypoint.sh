#!/bin/bash

STATUS=0 && whoami &> /dev/null || STATUS=$? && true

if [[ "$STATUS" != "0" ]]; then
    if [[ -w /etc/passwd ]]; then
	echo "Adding passwd file entry for $(id -u)"
	cat /etc/passwd | sed -e "s/^default:/builder:/" > /tmp/passwd
	echo "default:x:$(id -u):$(id -g):,,,:/home/default:/bin/bash" >> /tmp/passwd
	cat /tmp/passwd > /etc/passwd
	rm /tmp/passwd
    fi
fi

exec "$@"
