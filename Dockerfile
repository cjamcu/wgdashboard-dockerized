FROM ubuntu:20.04

ARG WG_ADDRESS=$WG_ADDRESS
ARG WG_LISTENPORT=$WG_LISTENPORT

RUN apt-get update && \
 apt-get install -y --no-install-recommends wireguard-tools iptables nano net-tools python3 python3-pip python3-venv procps openresolv inotify-tools && \
 apt-get clean

RUN mkdir -p /etc/wireguard/

# configure wireguard
RUN wg genkey |  tee /etc/wireguard/privatekey | wg pubkey |  tee /etc/wireguard/publickey

RUN  cd /etc/wireguard/ && echo "[Interface]" > wg0.conf && echo "SaveConfig = true" >> wg0.conf && echo -n "PrivateKey = " >> wg0.conf && cat privatekey >> wg0.conf   && cat privatekey | wg pubkey >> wg0.conf \
    && echo  "ListenPort = ${WG_LISTENPORT}" >> wg0.conf && echo  "Address = ${WG_ADDRESS}" >> wg0.conf  && chmod 700 wg0.conf

COPY ./src /opt/WGDashboard
RUN pip3 install -r /opt/WGDashboard/requirements.txt   --no-cache-dir

WORKDIR /opt/WGDashboard 

RUN chmod u+x wgd.sh

RUN ./wgd.sh install
RUN ./wgd.sh start
RUN ./wgd.sh stop
RUN echo "systemctl enable --now wg-quick@wg0" > /entrypoint.sh && echo "sh ./opt/WGDashboard/wgd.sh start" >> entrypoint.sh && echo "sleep infinity" >> /entrypoint.sh
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 10086
EXPOSE 51820/udp
