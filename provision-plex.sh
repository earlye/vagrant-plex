#!/bin/bash
sudo apt-get update
sudo apt-get install -y wget curl
#curl -o plexmediaserver_0.9.16.3.1840-cece46d_amd64.deb https://downloads.plex.tv/plex-media-server/0.9.16.3.1840-cece46d/plexmediaserver_0.9.16.3.1840-cece46d_amd64.deb
# sudo dpkg -i plexmediaserver_0.9.16.3.1840-cece46d_amd64.deb
curl -o plexmediaserver_0.9.16.4.1911-ee6e505_amd64.deb https://downloads.plex.tv/plex-media-server/0.9.16.4.1911-ee6e505/plexmediaserver_0.9.16.4.1911-ee6e505_amd64.deb
sudo dpkg -i plexmediaserver_0.9.16.4.1911-ee6e505_amd64.deb
sudo echo "LABEL=plex		/mnt/plex	ext4	defaults	0 0" >> /etc/fstab
