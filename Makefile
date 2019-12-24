DC=docker-compose
RUN=$(DC) run minecraft
QNAME=dm0275/minecraft-server

MC_12=1.12.2
MC_14=1.14.4

FORGE_12=12.18.3.2511 ## Minecraft v1.10.2
FORGE_14=14.23.5.2772  ## Minecraft v1.12.2

MC_14_URL=https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar

MC_PORT=25565
MC_VERSION=$(MC_14)
MC_URL_LINK=$(MC_14_URL)
MC_VERSION_FORGE=$(MC_12)
FORGE_VERSION=$(FORGE_14)

VCS_REF=$(shell git rev-parse --short HEAD)
GIT_TAG=$(QNAME):$(VCS_REF)
GIT_TAG_FORGE=$(QNAME):forge-$(VCS_REF)
VERSION_TAG=$(QNAME):$(MC_VERSION)
VERSION_TAG_FORGE=$(QNAME):forge-$(MC_VERSION_FORGE)
LATEST_TAG=$(QNAME):latest
LATEST_TAG_FORGE=$(QNAME):forge-latest

.PHONY: help
.DEFAULT_GOAL := help

ENV=export MC_IMAGE=$(VERSION_TAG) \
	PORT=$(MC_PORT) \
	JAVA_MIN_MEM=3G \
	JAVA_MAX_MEM=3G \
	GAMEMODE=1 \
	MAX_PLAYERS=10 \
	DATA_DIR=$$PWD/data \
	WORLD_DIR=$$PWD/world \
	MODS_DIR=$$PWD/mods

ENV_FORGE=export MC_VERSION=$(MC_VERSION) \
	PORT=$(MC_PORT) \
	JAVA_MIN_MEM=3G \
	JAVA_MAX_MEM=3G \
	GAMEMODE=1 \
	MAX_PLAYERS=10 \
	MC_IMAGE=$(VERSION_TAG_FORGE) \
	DATA_DIR=$$PWD/data_forge \
	WORLD_DIR=$$PWD/world_forge \
	MODS_DIR=$$PWD/mods

build: ## Build Vanilla image
	docker build \
		--file vanilla/Dockerfile \
		--build-arg mc_version=$(MC_VERSION) \
		--build-arg mc_url_link=$(MC_URL_LINK) \
		-t $(GIT_TAG) \
		-t $(VERSION_TAG) \
		-t $(LATEST_TAG) .

build_forge: ## Build image
	docker build \
		--file forge/Dockerfile \
		--build-arg mc_version=$(MC_VERSION_FORGE) \
		--build-arg forge_version=$(FORGE_VERSION) \
		-t $(GIT_TAG_FORGE) \
		-t $(VERSION_TAG_FORGE) \
		-t $(LATEST_TAG_FORGE) .

login: ## Login
	@printenv DOCKER_TOKEN \
	  | docker login -u "$(DOCKER_USERNAME)" \
	      --password-stdin

setup: ## Create DIRs
	mkdir -p data mods world

run: setup ## Run Minecraft in foreground
	$(ENV) && docker-compose up

rund: setup ## Run Minecraft in the background
	$(ENV) && docker-compose up -d

stop: ## Stop Container
	$(ENV) && docker-compose stop

clean: ## Clean Containers
	$(ENV) && docker-compose rm -f -s

setup_forge: ## Create Forge DIRs
	mkdir -p data_forge mods world_forge

run_forge: setup_forge ## Run Minecraft Forge in foreground
	$(ENV_FORGE) && docker-compose up

rund_forge: setup_forge ## Run Minecraft Forge in the background
	$(ENV_FORGE) && docker-compose up -d

stop_forge: ## Stop Container
	$(ENV_FORGE) && docker-compose stop

clean_forge: ## Clean Containers
	$(ENV_FORGE) && docker-compose rm -f -s

push: login ## Push Vanilla image
	docker push $(GIT_TAG)
	docker push $(VERSION_TAG)
	docker push $(LATEST_TAG)

push_forge: login ## Push Forge image
	docker push $(GIT_TAG_FORGE)
	docker push $(VERSION_TAG_FORGE)
	docker push $(LATEST_TAG_FORGE)

clean-dirs: clean ## Clean DIRs
	rm -rf data mods world

help: ## This help dialog.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

