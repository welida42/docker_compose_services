DC_FILE := ./srcs/docker-compose.yml

all: build up

build: mk_dirs
		docker-compose -f $(DC_FILE) build
mk_dirs:
		mkdir -p /home/welida/data/db
		mkdir -p /home/welida/data/wp

rm_dirs:
		rm -rf /home/welida/data
up:
		docker-compose -f $(DC_FILE) up -d
start:
		docker-compose -f $(DC_FILE) start
destroy:
		docker-compose -f $(DC_FILE) down -v
stop:
		docker-compose -f $(DC_FILE) stop
restart:
		docker-compose -f $(DC_FILE) stop
		docker-compose -f $(DC_FILE) up -d
ps:
		docker-compose -f $(DC_FILE) ps
clean:
		docker-compose -f $(DC_FILE) down
rm_images:
		docker rmi mariadb nginx wordpress
fclean: clean rm_dirs rm_images
re: fclean all

.PHONY: all build up start clean fclean destroy stop restart ps mk_dirs rm_dirs rm_images
