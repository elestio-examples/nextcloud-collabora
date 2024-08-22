docker-compose exec -u33 -T app bash -c "php occ maintenance:repair --include-expensive"
docker-compose exec -u33 -T app bash -c "php occ db:add-missing-indices"
