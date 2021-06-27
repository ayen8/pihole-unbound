0. Prerequisites

   0.1. Tested only on a Raspberry Pi 4B
   0.2. Static IP Address has been setup
   0.3. /etc/resolv.conf has been setup to have cloudflare DNS for internet access
   0.4. Port 53 has been freed up
        Google Ubuntu: How To Free Up Port 53, Used By systemd-resolved

1. Build docker image

   docker build -t ayen/pihole-unbound .

2. Run docker

   docker-compose up -d
