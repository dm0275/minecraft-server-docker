DC=docker-compose
RUN=$(DC) run minecraft
QNAME=fussionlabs/minecraft

MC_12=1.12.2
MC_14=1.14.2
FORGE_12=12.18.3.2511 ## Minecraft v1.10.2
FORGE_14=14.23.5.2814  ## Minecraft v1.12.2
MC_14_URL=https://launcher.mojang.com/v1/objects/808be3869e2ca6b62378f9f4b33c946621620019/server.jar

MC_VERSION=$(MC_14)
MC_URL_LINK=$(MC_14_URL)
MC_VERSION_FORGE=$(MC_12)
FORGE_VERSION=$(FORGE_14)

VCS_REF=$(shell git rev-parse --short HEAD)
GIT_TAG=$(QNAME):$(VCS_REF)
VERSION_TAG=$(QNAME):$(MC_VERSION)
VERSION_TAG_FORGE=$(QNAME)_forge:$(MC_VERSION_FORGE)
LATEST_TAG=$(QNAME):latest

.PHONY: help
.DEFAULT_GOAL := help

ENV=-e GAMEMODE=1 \
	-e MAX_PLAYERS=10

VOL=-v $$PWD/data:/opt/minecraft/data \
	-v $$PWD/world:/opt/minecraft/world \
	-v $$PWD/mods:/opt/minecraft/mods

build_forge: ## Build image
	docker build \
		--build-arg mc_version=$(MC_VERSION_FORGE) \
		--build-arg forge_version=$(FORGE_VERSION) \
		-t $(GIT_TAG) \
		-t $(VERSION_TAG_FORGE) \
		-t $(LATEST_TAG) .

build_vanilla: ## Build Vanilla image
	docker build \
		--file vanilla-server-Dockerfile \
		--build-arg mc_version=$(MC_VERSION) \
		--build-arg mc_url_link=$(MC_URL_LINK) \
		-t $(GIT_TAG) \
		-t $(VERSION_TAG_VANILLA) \
		-t $(LATEST_TAG) .

run_forge: setup ## Run in foreground
	docker run --rm -it --name minecraft -p 25565:25565 $(ENV) $(VOL) fl/minecraft_forge:$(MC_VERSION_FORGE)

run_vanilla: setup ## Run in foreground
	docker run --rm -it --name minecraft -p 25565:25565 $(ENV) $(VOL) fl/minecraft:$(MC_VERSION)

login: ## Login
	docker exec -it minecraft bash

rund: setup ## Run in background
	docker run -d --name minecraft -p 25565:25565 -p 25565:25565 $(ENV) $(VOL) fl/minecraft:$(MC_VERSION)

setup: ## Create DIRs
	mkdir -p data mods world

stop: ## Stop Container
	docker rm -f minecraft

clean: ## Clean Containers
	if [ "$$(docker ps -aq -f name=minecraft)" ]; then docker rm -f "$$(docker ps -aq -f name=minecraft)"; fi;

clean-dirs: clean ## Clean DIRs
	rm -rf data mods world

help: ## This help dialog.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

