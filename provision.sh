#!/bin/bash
sudo apt-get update
sudo apt-get install -y wget curl
curl -o plexmediaserver_0.9.16.3.1840-cece46d_amd64.deb https://downloads.plex.tv/plex-media-server/0.9.16.3.1840-cece46d/plexmediaserver_0.9.16.3.1840-cece46d_amd64.deb
sudo dpkg -i plexmediaserver_0.9.16.3.1840-cece46d_amd64.deb
