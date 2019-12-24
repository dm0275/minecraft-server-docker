# Minecraft Server

## Overview
This project builds a Minecraft (Vanilla or Forge) server Docker image.

## Requirements
* Docker
* Make
* Docker-compose

## Usage
```
Usage: make <target>
  build       Build Vanilla image
  build_forge  Build image
  login       Login
  setup       Create DIRs
  run         Run Minecraft in foreground
  rund        Run Minecraft in the background
  stop        Stop Container
  clean       Clean Containers
  setup_forge  Create Forge DIRs
  run_forge   Run Minecraft Forge in foreground
  rund_forge  Run Minecraft Forge in the background
  stop_forge  Stop Container
  clean_forge  Clean Containers
  clean-dirs  Clean DIRs
  help        This help dialog.
```