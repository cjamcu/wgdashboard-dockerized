#!/bin/bash
wg-quick up wg0
chmod u+x /opt/wgdashboard/wgd.sh
if [ ! -f "/opt/wgdashboard/wg-dashboard.ini"; then
  /opt/wgdashboard/wgd.sh install
fi
/opt/wgdashboard/wgd.sh start
sleep infinity
