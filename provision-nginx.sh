sudo apt-get install -y nginx

sudo service nginx stop

sudo cp /vagrant/nginx/plex /etc/nginx/sites-available/
if [[ -f /etc/nginx/sites-enabled/default ]] ; then sudo rm /etc/nginx/sites-enabled/default; fi
if [[ -f /etc/nginx/sites-enabled/plex ]] ; then sudo rm /etc/nginx/sites-enabled/plex; fi
sudo ln -s /etc/nginx/sites-available/plex /etc/nginx/sites-enabled/

sudo service nginx start

