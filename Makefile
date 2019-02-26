
.PHONY: help
.DEFAULT_GOAL := help

build: 
	docker build -t minecraft:latest .

run:
	mkdir -p mods data config
	docker run -it --name minecraft -p 25565:25565 -v $$PWD/data:/opt/data -v $$PWD/config:/opt/config minecraft:latest

login:
	docker exec -it minecraft bash

rund:
	docker run -d --name minecraft -p 25565:25565-v $$PWD/data:/opt/data -v $$PWD/config:/opt/config minecraft:latest

stop:
	docker rm -f minecraft

clean_dirs:
	rm -rf mods data config

help: 
	echo "?"