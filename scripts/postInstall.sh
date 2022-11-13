set env vars
set -o allexport; source .env; set +o allexport;

sleep 20s;


# utiliser sed dans nginx pour configurer

# chemin

# /opt/elestio/nginx/conf.d/${DOMAIN}.conf

# utiliser sed insert after listen 21005 ssl http2;

sed '/^listen 21005 ssl http2;/a location ^~ /browser {\nproxy_pass http://172.17.0.1:21002;\nproxy_set_header Host $http_host;\n}\n\n# main websocket\nlocation ~ ^/cool/(.*)/ws$ {\nproxy_pass http://172.17.0.1:21002;\nproxy_set_header Upgrade $http_upgrade;\nproxy_set_header Connection "Upgrade";\nproxy_set_header Host $http_host;\nproxy_read_timeout 36000s;\n}\n\n# download, presentation and image upload\nlocation ~ ^/(c|l)ool {\nproxy_pass http://172.17.0.1:21002;\nproxy_set_header Host $http_host;\n}\n\n# Admin Console websocket\nlocation ^~ /cool/adminws {\nproxy_pass http://172.17.0.1:21002;\nproxy_set_header Upgrade $http_upgrade;\nproxy_set_header Connection "Upgrade";\nproxy_set_header Host $http_host;\nproxy_read_timeout 36000s;\n}\n' /opt/elestio/nginx/conf.d/${DOMAIN}.conf

# 1.

# location ^~ /browser {
#         proxy_pass http://172.17.0.1:21002;
#         proxy_set_header Host $http_host;
#     }

#    # main websocket
#    location ~ ^/cool/(.*)/ws$ {
#        proxy_pass http://172.17.0.1:21002;
#        proxy_set_header Upgrade $http_upgrade;
#        proxy_set_header Connection "Upgrade";
#        proxy_set_header Host $http_host;
#        proxy_read_timeout 36000s;
#    }

#    # download, presentation and image upload
#    location ~ ^/(c|l)ool {
#        proxy_pass http://172.17.0.1:21002;
#        proxy_set_header Host $http_host;
#    }

#    # Admin Console websocket
#    location ^~ /cool/adminws {
#        proxy_pass http://172.17.0.1:21002;
#        proxy_set_header Upgrade $http_upgrade;
#        proxy_set_header Connection "Upgrade";
#        proxy_set_header Host $http_host;
#        proxy_read_timeout 36000s;
#    }

# restart nginx

docker exec elestio-nginx nginx -s reload;

target=$(docker-compose port nextcloud 80)


curl http://${target}/index.php \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36' \
  --data-raw 'install=true&adminlogin=root&adminpass='$ADMIN_PASSWORD'&directory=%2Fvar%2Fwww%2Fhtml%2Fdata&dbtype=sqlite&dbuser=&dbpass=&dbpass-clone=&dbname=&dbhost=localhost' \
  --compressed


  sed -i "s|0 => '172.17.0.1:21000'|0 => '"${DOMAIN}"'|g" ./nextcloud/config/config.php
  sed -i "s|'overwrite.cli.url' => 'https://172.17.0.1:21000'|'overwrite.cli.url' => 'https://"${DOMAIN}"'|g" ./nextcloud/config/config.php

  sed -i "s|'installed' => true,|'installed' => true,\n  'mail_from_address' => '"$MAIL_FROM_ADDRESS"',\n  'mail_smtpmode' => 'smtp',\n  'mail_sendmailmode' => 'smtp',\n  'mail_domain' => '"$MAIL_DOMAIN"',\n  'mail_smtpport' => '"$EMAIL_PORT"',\n  'mail_smtphost' => '"$EMAIL_HOST"',|g" ./nextcloud/config/config.php

