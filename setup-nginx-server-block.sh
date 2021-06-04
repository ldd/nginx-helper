WEBSITE_URL=${WEBSITE_URL:-test.com}

#####################
##  install nginx  ##
#####################
sudo apt update
sudo apt install -y nginx


##########################
##  nginx server block  ##
##########################

# make directory for this site with correct permissions
sudo mkdir -p /var/www/${WEBSITE_URL}/html
sudo chown -R $USER:$USER /var/www/${WEBSITE_URL}/html
sudo chmod -R 755 /var/www

# copy & update the configuration file for this site
DESTINATION_DIRECTORY="/etc/nginx/sites-available/${WEBSITE_URL}"
sudo cp default.nginx $DESTINATION_DIRECTORY
sudo sed -i -- "s|WEBSITE_URL|${WEBSITE_URL}|g" $DESTINATION_DIRECTORY

# enable the site
sudo ln -s $DESTINATION_DIRECTORY /etc/nginx/sites-enabled/
sudo systemctl restart nginx

#####################
##  let's encrypt  ##
#####################
# https://snapcraft.io/docs/installing-snapd
# for debian, or other distros that don't include snapd by default, uncomment the next 2 lines
# sudo apt update
# sudo apt install snapd
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# change firewall rules, if necessary
# sudo ufw allow 'Nginx Full'
# sudo ufw delete allow 'Nginx HTTP'

sudo certbot --nginx -d ${WEBSITE_URL} -d www.${WEBSITE_URL}
