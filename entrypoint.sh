#!/bin/bash
wg-quick up wg0
chmod u+x /opt/wgdashboard/wgd.sh
sh /opt/wgdashboard/wgd.sh install
sh /opt/wgdashboard/wgd.sh update
sh /opt/wgdashboard/wgd.sh start
sleep infinity
