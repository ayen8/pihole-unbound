FROM pihole/pihole:v5.8.1
RUN apt update && apt upgrade -y
RUN apt install -y unbound

COPY pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY unbound_start.sh .

RUN chmod +x unbound_start.sh
ENTRYPOINT ./unbound_start.sh
