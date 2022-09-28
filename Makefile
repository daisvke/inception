COMPOSE						= cd srcs/ && docker-compose
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
	mkdir -p $(MARIADB_HOST_VOLUME_PATH)
	mkdir -p $(WP_HOST_VOLUME_PATH)
	$(COMPOSE) up -d --build

# Shut all containers and delete them
clean:
	@echo "\033[33mCleaning...\033[0m"
	$(COMPOSE) down -v --rmi all --remove-orphans 2> /dev/null

# Clean and delete all unused volumes, containers, networks and images
fclean: clean
	docker system prune --volumes --all --force 2> /dev/null
	rm -rf $(DATA_PATH) 2> /dev/null

re: fclean all