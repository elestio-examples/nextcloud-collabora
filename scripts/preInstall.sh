#set env vars
#set -o allexport; source .env; set +o allexport;

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