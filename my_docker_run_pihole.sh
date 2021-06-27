#!/bin/bash

. .env

PIHOLE_BASE="${PIHOLE_BASE:-$(pwd)}"

docker run -d \
    --name pihole-unbound \
    -p 53:53/tcp \
    -p 53:53/udp \
    -p 8001:80 \
    -p 5335:5335 \
    -v "${PIHOLE_BASE}/etc-pihole/:/etc/pihole/" \
    -v "${PIHOLE_BASE}/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
    --dns=1.1.1.1 \
    --dns=1.0.0.1 \
    --restart=unless-stopped \
    --hostname ${HOSTNAME} \
    --domainname ${DOMAIN_NAME} \
    -e TZ="${TZ}" \
    -e ServerIP="${ServerIP}" \
    -e WEBPASSWORD="${WEBPASSWORD}" \
    -e PIHOLE_DNS_="127.0.0.1#5335" \
    -e DNSSEC=false \
    -e REV_SERVER=true \
    -e REV_SERVER_DOMAIN="${REV_SERVER_DOMAIN}" \
    -e REV_SERVER_TARGET="${REV_SERVER_TARGET}" \
    -e REV_SERVER_CIDR="${REV_SERVER_CIDR}" \
    ayen8/pihole-unbound
