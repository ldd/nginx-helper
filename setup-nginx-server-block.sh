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
sudo add-apt-repository ppa:certbot/certbot
sudo apt install -y python-certbot-nginx

# change firewall rules, if necessary
# sudo ufw allow 'Nginx Full'
# sudo ufw delete allow 'Nginx HTTP'

sudo certbot --nginx -d ${WEBSITE_URL} -d ${WEBSITE_URL}
