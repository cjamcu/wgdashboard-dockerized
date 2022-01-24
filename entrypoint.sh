#!/bin/bash
wg-quick up wg0
chmod u+x /opt/wgdashboard/wgd.sh
yes Y | /opt/wgdashboard/wgd.sh update
/opt/wgdashboard/wgd.sh start
sleep infinity
