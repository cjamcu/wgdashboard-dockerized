FROM ubuntu:20.04

ARG WG_ADDRESS=$WG_ADDRESS
ARG WG_CONF_NAME=$WG_CONF_NAME

RUN apt-get update && \
 apt-get install -y --no-install-recommends iproute2 wireguard-tools iptables nano net-tools python3 python3-pip python3-venv procps openresolv inotify-tools && \
 apt-get clean

RUN mkdir -p /etc/wireguard/
RUN mkdir -p /opt/wgdashboard

# configure wireguard
RUN wg genkey |  tee /etc/wireguard/privatekey | wg pubkey |  tee /etc/wireguard/publickey

RUN  cd / && echo "[Interface]" > ${WG_CONF_NAME}.conf && echo "SaveConfig = true" >> ${WG_CONF_NAME}.conf && echo -n "PrivateKey = " >> ${WG_CONF_NAME}.conf && cat privatekey >> ${WG_CONF_NAME}.conf \
    && echo  "ListenPort = 51820" >> ${WG_CONF_NAME}.conf && echo  "Address = ${WG_ADDRESS}" >> ${WG_CONF_NAME}.conf  && chmod 700 ${WG_CONF_NAME}.conf

COPY ./src /opt/WGDashboard_tmp
RUN pip3 install -r /opt/WGDashboard_tmp/requirements.txt   --no-cache-dir
RUN rm -rf /opt/WGDashboard_tmp
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /opt/wgdashboard 

EXPOSE 10086
EXPOSE 51820/udp
