up:
	docker-compose up -d --build
	make server-start
down:
	docker-compose down -v
restart:
	make down
	make up
init:
	docker-compose exec vuesplash_web composer create-project --prefer-dist laravel/laravel .
	docker-compose exec vuesplash_web npm install
	make server-start
server-start:
	docker-compose exec vuesplash_web php artisan serve --host 0.0.0.0 --port 8081
watch:
	docker-compose exec vuesplash_web npm run watch