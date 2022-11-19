#!/bin/bash

addgroup --system snowflake
adduser --system --ingroup snowflake snowflake
    
mkdir /var/log/snowflake
chown snowflake:snowflake  /var/log/snowflake
    
cp $HOME/git/snowflake/proxy/proxy /usr/local/bin/snowflake-proxy
chmod +x /usr/local/bin/snowflake-proxy
    
# Go to the downloaded git
cd ~/git/Snowflake-Proxy-Service

cp snowflake-proxy.service /etc/systemd/system/
systemctl enable snowflake-proxy.service
systemctl start snowflake-proxy.service
