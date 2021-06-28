# Pi-hole and Unbound in one Container


## Description

This Docker runs Pi-hole and Unbound in a single container.

This is mostly to free up port 80/443 in the host for later use.


## Prerequisites

This was tested only on a `Raspberry Pi 4B` under `Ubuntu 20.04 LTS`. 

If you have the same setup then this may be helpful.

1. Configure a static IP address for the pi/Host.

2. Free up port 53.

[Ubuntu: How To Free Up Port 53, Used By systemd-resolved](https://www.linuxuprising.com/2020/07/ubuntu-how-to-free-up-port-53-used-by.html)

My `/etc/systemd/resolved.conf` is:

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

3. Configure internet access for the host.

In my case, needed to set my chosen nameserver in `/etc/resolv.conf`.

```
nameserver 208.67.222.222
nameserver 208.67.220.220
```

4. Configure Linux parameters in `/etc/sysctl.conf` and reboot.

Check below parameters. Add if missing. Update values if lesser.

```
net.core.rmem_max=8388608
net.core.wmem_max=8388608
```

You may run below to increase values without rebooting. But this will not be saved on reboot.

```
sysctl -w net.core.rmem_max=8388608  
sysctl -w net.core.wmem_max=8388608
```


## Usage


### Step 1: Clone this repository

ssh to your Raspberry Pi as ubuntu and run the following:

    git clone https://github.com/ayen8/pihole-unbound.git


### Step 2: Create an .env file for environment variables

For example:

    cd pihole-unbound
    vi .env


Add the following environment variables and provide appropriate values for your network.

> Sample below. 

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

> The important environment variables are:

| Docker Environment Var. | Description |
| ----------------------- | ----------- |
| `ServerIP: <Host's IP>`<br/> **Recommended** | **--net=host mode requires** Set to your server's LAN IP, used by web block modes and lighttpd bind address
| `TZ`<br/> | Set your [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).
| `WEBPASSWORD`<br/> | Your elected password to login to Pi-hole.
| `REV_SERVER: <"true"\|"false">`<br/> *Optional* *Default: "false"* | Enable DNS conditional forwarding for device name resolution
| `REV_SERVER_DOMAIN: <Network Domain>`<br/> *Optional* | If conditional forwarding is enabled, set the domain of the local network router
| `REV_SERVER_TARGET: <Router's IP>`<br/> *Optional* | If conditional forwarding is enabled, set the IP of the local network router
| `REV_SERVER_CIDR: <Reverse DNS>`<br/> *Optional* | If conditional forwarding is enabled, set the reverse DNS zone (e.g. `192.168.0.0/24`)


> Checkout the [official pihole container](https://github.com/pi-hole/docker-pi-hole/) for the complete environment variable definitions.


### Step 3: Build docker image

```bash
docker build -t ayen8/pihole-unbound .
```


### Step 4: Run the stack

```bash
docker-compose up -d
```


### Step 5: Test your installation

Update your computer/router DNS settings to point to ServerIP.

Check Pi-hole by going to http://ServerIP:YourPort/admin

Test various websites to see if ads are removed.
