
.PHONY: help
.DEFAULT_GOAL := help

build: ## Build image
	docker build -t fl/minecraft:latest .

run: ## Run in foreground
	mkdir -p data config
	docker run -it --name minecraft -p 25565:25565 -v $$PWD/data:/opt/data -v $$PWD/config:/opt/config fl/minecraft:latest

login: ## Login
	docker exec -it minecraft bash

rund: ## Run in background
	docker run -d --name minecraft -p 25565:25565 -v $$PWD/data:/opt/data -v $$PWD/config:/opt/config fl/minecraft:latest

stop: ## Stop
	docker rm -f minecraft

clean: ## Clean
	if [ "$$(docker ps -aq -f name=minecraft)" ]; then docker rm -f minecraft; fi;
	rm -rf data config

help: ## This help dialog.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)