#!/bin/bash
wg-quick up wg0
chmod u+x /opt/wgdashboard/wgd.sh
if [ ! -f "/opt/wgdashboard/wg-dashboard.ini" ]; then
  /opt/wgdashboard/wgd.sh install
#  /opt/wgdashboard/wgd.sh start
#  /opt/wgdashboard/wgd.sh stop
fi
/opt/wgdashboard/wgd.sh debug
sleep infinity
