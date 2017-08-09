initialize:
	sudo chmod a+x ./scripts/nginx-config.sh
	sudo make nginx-config
	sudo make up
nginx-config:
	./scripts/nginx-config.sh
up:
	sudo docker-compose up -d
down:
	sudo docker-compose down

