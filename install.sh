#!/bin/bash

# This script assumes that snowflake is cloned in the folder ~/git/snowflake
# Source 0https://git.torproject.org/pluggable-transports/snowflake.git

cd ~/git/Snowflake-Proxy-Service

sudo addgroup --system snowflake
sudo adduser --system --ingroup snowflake snowflake
    
sudo mkdir /var/log/snowflake
sudo chown snowflake:adm  /var/log/snowflake

sudo cp ~/git/snowflake/proxy/proxy /usr/local/bin/snowflake-proxy
sudo chmod +x /usr/local/bin/snowflake-proxy
    
# Go to the downloaded git

sudo cp snowflake-proxy.service /etc/systemd/system/
sudo systemctl enable snowflake-proxy.service
sudo systemctl start snowflake-proxy.service
