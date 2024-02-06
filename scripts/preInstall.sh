#set env vars
#set -o allexport; source .env; set +o allexport;

echo "Granting permission..."

mkdir -p ./db
chown -R 1000:1000 ./db

mkdir -p ./nextcloud
chown -R 1000:1000 ./nextcloud

mkdir -p ./apps
chown -R 1000:1000 ./apps

mkdir -p ./config
chown -R 1000:1000 ./config

mkdir -p ./data
chown -R 1000:1000 ./data

chown -R www-data:www-data .

STATIC_AUTH_SECRET=${STATIC_AUTH_SECRET:-`openssl rand -hex 8`}

cat << EOT >> ./.env

STATIC_AUTH_SECRET=${STATIC_AUTH_SECRET}
EOT

cat << EOT >> ./turnserver.conf
listening-port=3478
fingerprint
use-auth-secret
static-auth-secret=${STATIC_AUTH_SECRET}
realm=${DOMAIN}
total-quota=100
bps-capacity=0
stale-nonce
no-cli
no-multicast-peers
no-stdout-log
simple-log
log-file=/dev/stdout

EOT
