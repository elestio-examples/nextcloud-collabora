#set env vars
#set -o allexport; source .env; set +o allexport;

mkdir -p ./data
#chown -R 1000:1000 ./data

mkdir -p ./db

#chown -R 1000:1000 ./db
mkdir -p ./etc
#chown -R 1000:1000 ./etc