LOGIN = marce

all:
		@sudo mkdir -p /home/$(LOGIN)/data/mariadb
		@docker volume create --name mariadb-volume --opt type=none --opt device=/home/$(LOGIN)/data/mariadb --opt o=bind
		@sudo mkdir -p /home/$(LOGIN)/data/wordpress
		@docker volume create --name wordpress-volume --opt type=none --opt device=/home/$(LOGIN)/data/wordpress --opt o=bind
		@docker-compose -f ./srcs/docker-compose.yml up --build

down:
		@docker-compose -f ./srcs/docker-compose.yml down

re:
		@docker-compose -f srcs/docker-compose.yml up --build

update-hosts:
		@if ! grep -q "$(LOGIN).42.fr" /etc/hosts; then \
				echo "127.0.0.1 $(LOGIN).42.fr" >> /etc/hosts; \
		fi

remove-hosts:
		@if grep -q "$(LOGIN).42.fr" /etc/hosts; then \
				sudo sed -i '/$(LOGIN).42.fr/d' /etc/hosts; \
		fi

list:
		@docker ps -a

list-volumes:
		@docker volume ls

list-networks:
		@docker network ls

clean: down
		@-docker rmi -f `docker images -qa`
		@-docker volume rm `docker volume ls -q`

fclean:
		@sudo rm -rf /home/$(LOGIN)/data/wordpress
		@sudo rm -rf /home/$(LOGIN)/data/mariadb

.PHONY: all re down clean fclean
