#!/bin/bash
wg-quick up wg0
chmod u+x /opt/wgdashboard/wgd.sh
/opt/wgdashboard/wgd.sh install
yes | /opt/wgdashboard/wgd.sh update
/opt/wgdashboard/wgd.sh start
sleep infinity
