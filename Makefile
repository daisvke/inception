COMPOSE						= cd srcs/ && sudo docker-compose
DATA_PATH					= /home/dtanigaw/data
MARIADB_HOST_VOLUME_PATH	= /home/dtanigaw/data/database
WP_HOST_VOLUME_PATH			= /home/dtanigaw/data/wordpress

.PHONY: all build up clean fclean re

all: up

# Build/rebuild an image
build:
	$(COMPOSE) build

# Shut down containers if up, build all images and run detached containers
up:
	sudo mkdir -p $(MARIADB_HOST_VOLUME_PATH)
	sudo mkdir -p $(WP_HOST_VOLUME_PATH)
	sudo chmod 777 /etc/hosts
	sudo echo "127.0.0.1 dtanigaw.42.fr" >> /etc/hosts
	sudo echo "127.0.0.1 www.dtanigaw.42.fr" >> /etc/hosts
	$(COMPOSE) up -d --build

# Shut all containers down and delete them
clean:
	@echo "\033[33mCleaning...\033[0m"
	$(COMPOSE) down -v --rmi all --remove-orphans 2> /dev/null

# Clean and delete all unused volumes, containers, networks and images
fclean: clean
	sudo docker system prune --volumes --all --force 2> /dev/null
	sudo rm -rf $(DATA_PATH) 2> /dev/null

re: fclean all