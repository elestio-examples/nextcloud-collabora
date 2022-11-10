#set env vars
#set -o allexport; source .env; set +o allexport;

mkdir -p ./data
#chown -R 1000:1000 ./data

mkdir -p ./db
#chown -R 1000:1000 ./db

mkdir -p ./nextcloud-db
#chown -R 1000:1000 ./db

mkdir -p ./nextcloud-app
#chown -R 1000:1000 ./db

mkdir -p ./nginx.conf
#chown -R 1000:1000 ./db