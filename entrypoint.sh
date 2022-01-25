#!/bin/bash

if [ ! -f "/etc/wireguard/*.conf" ]; then
  mv /*.conf /etc/wireguard
else
  rm /*.conf
fi

wg-quick up wg0
chmod u+x /opt/wgdashboard/wgd.sh
if [ ! -f "/opt/wgdashboard/wg-dashboard.ini" ]; then
  /opt/wgdashboard/wgd.sh install
fi
/opt/wgdashboard/wgd.sh debug

