# Pi-hole and Unbound in 1 Container


## Description

This Docker runs Pi-hole and Unbound in a single docker container as opposed to bare-metal in Raspberry Pi/Ubuntu 20.04.

This is mostly to free up port 80 for later use.


## Prerequisites

Tested only on a Raspberry Pi 4B / Ubuntu 20.04 LTS

Static IP Address has been setup

/etc/resolv.conf has been setup to have cloudflare DNS for internet access

Port 53 has been freed up

Google Ubuntu: How To Free Up Port 53, Used By systemd-resolved


## Usage


### Clone this repository

Login to your Raspberry Pi 4B as ubuntu

    git clone https://github.com/ayen8/pihole-unbound.git


### Create .env file for environment variables

For example:

    cd pihole-unbound
    vi .env


add the following:

```
ServerIP=10.0.0.9
HOSTNAME=pihole02
DOMAIN_NAME=home.lan
TZ=Asia/Manila
WEBPASSWORD=qwerty123
DNSSEC=false
REV_SERVER=true
REV_SERVER_DOMAIN=home.lan
REV_SERVER_TARGET=10.0.0.1
REV_SERVER_CIDR=10.0.0.0/8
```


### Run the stack

```bash
docker-compose up -d
```

