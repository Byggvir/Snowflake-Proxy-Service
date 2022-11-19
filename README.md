# Snowflake-Proxy-Service

## How to install snowflake proxy as a systemd service

The systemd service script is based on a idea from [MBruchard](https://gist.github.com/MBurchard/e166dc0c3c041c7e6f179efd88385cdb) on gistguthub.com.


## Installation

Execute the following steps on the command line to install [Snowflake](https://git.torproject.org/pluggable-transports/snowflake.git) proxy as a service on Debian.

I assume that you installed snowflake in *~/git/snowflake* and downloaded this repository to *~/git/Snowflake-Proxy-Service*.

````
cd ~/git/Snowflake-Proxy-Service

sudo addgroup --system snowflake
sudo adduser --system --ingroup snowflake snowflake
    
sudo mkdir /var/log/snowflake
sudo chown snowflake:snowflake  /var/log/snowflake
    
sudo cp ~/git/snowflake/proxy/proxy /usr/local/bin/snowflake-proxy
sudo chmod +x /usr/local/bin/snowflake-proxy
sudo cp snowflake-proxy.service /etc/systemd/system/
sudo systemctl enable snowflake-proxy.service
sudo systemctl start snowflake-proxy.service
````

Change the paths to your needs and don't forget to change them in the file *snowflake-proxy.service*.


