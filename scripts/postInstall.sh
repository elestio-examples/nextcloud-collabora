set env vars
set -o allexport; source .env; set +o allexport;

sleep 20s;

target=$(docker-compose port nextcloud 80)


curl http://${target}/index.php \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36' \
  --data-raw 'install=true&adminlogin=root2&adminpass=YmRByUWc-J6bv-3EDZ2H9P&directory=%2Fvar%2Fwww%2Fhtml%2Fdata&dbtype=sqlite&dbuser=&dbpass=&dbpass-clone=&dbname=&dbhost=localhost' \
  --compressed


  sed -i "s|0 => '172.17.0.1:21000'|0 => '"${DOMAIN}"'|g" ./nextcloud/config/config.php
  sed -i "s|'overwrite.cli.url' => 'https://172.17.0.1:21000'|'overwrite.cli.url' => 'https://"${DOMAIN}"'|g" ./nextcloud/config/config.php

  sed -i "s|'installed' => true,|'installed' => true,\n  'mail_from_address' => '"$MAIL_FROM_ADDRESS"',\n  'mail_smtpmode' => 'smtp',\n  'mail_sendmailmode' => 'smtp',\n  'mail_domain' => '"$MAIL_DOMAIN"',\n  'mail_smtpport' => '"$EMAIL_PORT"',\n  'mail_smtphost' => '"$EMAIL_HOST"',|g" ./nextcloud/config/config.php

