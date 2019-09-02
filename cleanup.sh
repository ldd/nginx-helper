WEBSITE_URL=${WEBSITE_URL:-test.com}

sudo rm -rf /var/www/${WEBSITE_URL}
sudo rm -rf /etc/nginx/sites-enabled/${WEBSITE_URL}
sudo rm -rf /etc/nginx/sites-available/${WEBSITE_URL}
