FROM python:3.10.2-alpine3.15

ARG WG_ADDRESS=$WG_ADDRESS
ARG WG_LISTENPORT=$WG_LISTENPORT

run  apk --update-cache upgrade && apk add --no-cache gcc g++ libffi-dev  jpeg-dev zlib-dev libjpeg  wireguard-tools   iptables ip6tables inotify-tools

RUN mkdir -p /etc/wireguard/

# configure wireguard
RUN wg genkey |  tee /etc/wireguard/privatekey | wg pubkey |  tee /etc/wireguard/publick

RUN  cd /etc/wireguard/ && echo "[Interface]" >> wg0.conf &&  echo -n "PrivateKey = " >> wg0.conf && cat privatekey >> wg0.conf   && cat privatekey | wg pubkey >> wg0.conf \
    && echo  "ListenPort = ${WG_LISTENPORT)" >> wg0.conf && echo  "Address = ${WG_ADDRESS}" >> wg0.conf  && chmod 700 wg0.conf

COPY . /opt/WGDashboard/src
RUN pip3 install -r /opt/WGDashboard/src/requirements.txt   --no-cache-dir

#RUN cd  /opt/WGDashboard/src 

WORKDIR /opt/WGDashboard/src 


EXPOSE 10086
EXPOSE 51820/udp
