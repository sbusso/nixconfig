# Connectivity info for Linux VM
NIXADDR ?= unset
NIXPORT ?= 22
NIXUSER ?= sbusso

# Settings
NIXBLOCKDEVICE ?= sda

# Get the path to this Makefile and directory
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# The name of the nixosConfiguration in the flake
NIXNAME ?= macbook-pro-m1
# vm-aarch64

# We need to do some OS switching below.
UNAME := $(shell uname)

# switch:
# ifeq ($(UNAME), Darwin)
# 	nix build --extra-experimental-features nix-command --extra-experimental-features flakes ".#darwinConfigurations.${NIXNAME}.system"
# 	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${NIXNAME}"
# else
# 	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${NIXNAME}"
# endif

# test:
# ifeq ($(UNAME), Darwin)
# 	nix build ".#darwinConfigurations.${NIXNAME}.system"
# 	./result/sw/bin/darwin-rebuild test --flake "$$(pwd)#${NIXNAME}"
# else
# 	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild test --flake ".#$(NIXNAME)"
# endif



# Makefile for managing Nix-Darwin and Home Manager configurations

# Default user and home directory
USERNAME ?= $(shell whoami)
HOME_DIR ?= /Users/$(USERNAME)

# Default target: show help
.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

.PHONY: build
build: ## Build the configuration
	@echo "Building Nix-Darwin and Home Manager configurations..."
	@nix build  --extra-experimental-features nix-command --extra-experimental-features flakes .#darwinConfigurations.${NIXNAME}.system
	# @sudo nix build .#homeConfigurations.${NIXNAME}.activationPackage

.PHONY: switch
switch: ## Apply the new configuration
	@echo "Switching to the new Nix-Darwin configuration..."
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${NIXNAME}" --show-trace
	# @echo "Activating the new Home Manager configuration..."
	# @./result/activate

	# ifeq ($(UNAME), Darwin)
	# 	nix build --extra-experimental-features nix-command --extra-experimental-features flakes ".#darwinConfigurations.${NIXNAME}.system"
	# 	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${NIXNAME}"
	# else
	# 		sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${NIXNAME}"
	# endif

.PHONY: update
update: ## Update the flake.lock file
	@echo "Updating flake.lock..."
	@nix flake update

.PHONY: clean
clean: ## Clean build artifacts
	@echo "Cleaning build artifacts..."
	@rm -rf result

.PHONY: edit
edit: ## Edit the configuration
	@echo "Opening configuration files for editing..."
	@$(EDITOR) flake.nix

.PHONY: status
status: ## Show the current status
	@echo "Showing current Nix-Darwin and Home Manager status..."
	@sudo darwin-rebuild dry-run
	@home-manager build

.PHONY: darwin-refresh
darwin-refresh: ## Refresh Nix-Darwin configuration
	@echo "Refreshing Nix-Darwin configuration..."
	@darwin-rebuild switch --flake . --show-trace
