up:
	docker compose up -d

down:
	docker compose down

bash:
	docker compose exec -ucustomUser php bash

symfony:
	docker compose exec -ucustomUser php symfony

nginx-log:
	docker compose logs -f nginx

composer:
	docker compose exec -ucustomUser php symfony composer install

cache-clear:
	docker compose exec -ucustomUser php symfony cache:clear

migrate:
	docker compose exec -ucustomUser php symfony doctrine:migrations:migrate --no-interaction
