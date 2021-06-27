# Pi-hole and Unbound in one Container


## Description

This Docker runs Pi-hole and Unbound in a single docker container as opposed to bare-metal in Raspberry Pi/Ubuntu 20.04.

This is mostly to free up port 80 for later use.


## Prerequisites

1. Tested only on a Raspberry Pi 4B under Ubuntu 20.04 LTS

2. Static IP Address has been setup

3. Port 53 has been freed up

Google [Ubuntu: How To Free Up Port 53, Used By systemd-resolved](https://www.linuxuprising.com/2020/07/ubuntu-how-to-free-up-port-53-used-by.html)

My /etc/systemd/resolved.conf is:

```
[Resolve]
#DNS=
#FallbackDNS=
#Domains=
#LLMNR=no
#MulticastDNS=no
#DNSSEC=no
#DNSOverTLS=no
#Cache=no-negative
DNSStubListener=no
#ReadEtcHosts=yes
```

4. /etc/resolv.conf has been setup with your favorite DNS for internet access

```
nameserver 208.67.222.222
nameserver 208.67.220.220
```


## Usage


### Step 1: Clone this repository

Login to your Raspberry Pi 4B as ubuntu

    git clone https://github.com/ayen8/pihole-unbound.git


### Step 2: Create .env file for environment variables

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

> Checkout the [official pihole container](https://github.com/pi-hole/docker-pi-hole/) for environment variable definitions.


### Step 3: Build docker image

```bash
docker build -t ayen8/pihole-unbound .
```


### Step 4: Run the stack

```bash
docker-compose up -d
```

