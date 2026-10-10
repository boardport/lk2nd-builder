# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Module: lk2nd Docker Container Workflows
# Description: Build, pull, and execution commands for lk2nd toolbox, toolchains, and bootloader targets.
# ----------------------------------------------------------------
# Repository: https://github.com/boardport/lk2nd-builder
# Author: BoardPort Community <boardport@proton.me>
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Context variables
PROJECT_MAKE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
PROJECT_ROOT_DIR ?= $(abspath $(PROJECT_MAKE_DIR)/..)
CTX_UID          := $(shell id -u)
CTX_GID          := $(shell id -g)

# Docker variables
DOCKER_DIR          ?= $(PROJECT_ROOT_DIR)/docker
OVERLAY_DIR         ?= $(PROJECT_ROOT_DIR)/overlay
DOCKER_REGISTRY     ?= ghcr.io
DOCKER_IMAGE_PREFIX ?= $(DOCKER_REGISTRY)/boardport

# lk2nd build variables
LK2ND_BRANCH        ?=
LK2ND_REF           ?= $(if $(LK2ND_BRANCH),$(LK2ND_BRANCH),23.1)
LK2ND_COMMIT        ?=
LK2ND_TARGET        ?= lk2nd-msm8916-boardport
LK2ND_REPO          ?= https://github.com/msm8916-mainline/lk2nd.git
OVERLAY_BRANCH      ?=
OVERLAY_REF         ?= $(if $(OVERLAY_BRANCH),$(OVERLAY_BRANCH),$(LK2ND_REF))
OVERLAY_COMMIT      ?=
GITHUB_TOKEN        ?=

# Helper macro to check if a CLI tool exists in system PATH
define check_tool_installed
	@command -v $(1) > /dev/null 2>&1 || { \
		echo "[ERROR] Make: Utility '$(1)' is not installed. Please install it first."; \
		exit 1; \
	}
endef

# ------------------------------------------------------------------------------
# Pre-execution Checks (Internal)
# ------------------------------------------------------------------------------

docker-check-bin::
	$(call check_tool_installed,docker)

lk2nd-check-dirs::
	@mkdir -p "$(DOCKER_DIR)/volumes/output" "$(DOCKER_DIR)/volumes/build"

lk2nd-check:: \
	docker-check-bin \
	lk2nd-check-dirs

# ------------------------------------------------------------------------------
# Registry Pull Commands
# ------------------------------------------------------------------------------

.PHONY: \
	lk2nd-pull-toolbox \
	lk2nd-pull-toolchain \
	lk2nd-pull-target \
	lk2nd-pull

lk2nd-pull-toolbox:: docker-check-bin ## Pull lk2nd toolbox image from container registry
	@echo "[INFO] Make: Pulling lk2nd toolbox image from $(DOCKER_REGISTRY)..."
	@docker pull "$(DOCKER_IMAGE_PREFIX)/lk2nd-toolbox:latest"

lk2nd-pull-toolchain:: docker-check-bin ## Pull lk2nd toolchain image from registry (Usage: make lk2nd-pull-toolchain [LK2ND_REF=...])
	@echo "[INFO] Make: Pulling lk2nd toolchain image ($(LK2ND_REF)) from $(DOCKER_REGISTRY)..."
	@docker pull "$(DOCKER_IMAGE_PREFIX)/lk2nd-toolchain:$(LK2ND_REF)" || \
		docker pull "$(DOCKER_IMAGE_PREFIX)/lk2nd-toolchain:latest"

lk2nd-pull-target:: docker-check-bin ## Pull lk2nd target image from registry (Usage: make lk2nd-pull-target [LK2ND_REF=...])
	@echo "[INFO] Make: Pulling lk2nd target image ($(LK2ND_REF)) from $(DOCKER_REGISTRY)..."
	@docker pull "$(DOCKER_IMAGE_PREFIX)/lk2nd-target:$(LK2ND_REF)"

lk2nd-pull:: ## Pull all lk2nd container images from container registry
lk2nd-pull:: \
	lk2nd-pull-toolbox \
	lk2nd-pull-toolchain

# ------------------------------------------------------------------------------
# Image Build Commands
# ------------------------------------------------------------------------------

.PHONY: \
	lk2nd-build-toolbox \
	lk2nd-build-toolchain \
	lk2nd-build-target

lk2nd-build-toolbox:: docker-check-bin ## Build minimal Debian toolbox environment image
	@echo "[INFO] Make: Building lk2nd toolbox base image..."
	@docker image build \
		--file "$(DOCKER_DIR)/images/toolchain/Dockerfile.debian" \
		--target toolbox \
		--tag "$(DOCKER_IMAGE_PREFIX)/lk2nd-toolbox:latest" \
		"$(DOCKER_DIR)"

lk2nd-build-toolchain:: docker-check-bin ## Build lk2nd toolchain image with upstream sources (Usage: make lk2nd-build-toolchain [LK2ND_REF=...])
	@echo "[INFO] Make: Building lk2nd toolchain image ($(LK2ND_REF))..."
	@docker image build \
		--file "$(DOCKER_DIR)/images/toolchain/Dockerfile.debian" \
		--target toolchain \
		--build-arg LK2ND_REPO="$(LK2ND_REPO)" \
		--build-arg LK2ND_REF="$(LK2ND_REF)" \
		$(if $(LK2ND_COMMIT),--build-arg LK2ND_COMMIT="$(LK2ND_COMMIT)",) \
		--tag "$(DOCKER_IMAGE_PREFIX)/lk2nd-toolchain:$(LK2ND_REF)" \
		--tag "$(DOCKER_IMAGE_PREFIX)/lk2nd-toolchain:latest" \
		"$(DOCKER_DIR)"

lk2nd-build-target:: docker-check-bin ## Build target image with baked-in overlay (Usage: make lk2nd-build-target [LK2ND_REF=...] [OVERLAY_REF=...])
	@echo "[INFO] Make: Building lk2nd target image with integrated overlay ($(OVERLAY_REF))..."
	@docker image build \
		--file "$(DOCKER_DIR)/images/target/Dockerfile.debian" \
		--build-arg DOCKER_IMAGE_PREFIX="$(DOCKER_IMAGE_PREFIX)" \
		--build-arg LK2ND_REF="$(LK2ND_REF)" \
		--build-arg OVERLAY_REF="$(OVERLAY_REF)" \
		$(if $(OVERLAY_COMMIT),--build-arg OVERLAY_COMMIT="$(OVERLAY_COMMIT)",) \
		$(if $(GITHUB_TOKEN),--build-arg GITHUB_TOKEN="$(GITHUB_TOKEN)",) \
		--tag "$(DOCKER_IMAGE_PREFIX)/lk2nd-target:$(LK2ND_REF)" \
		--tag "$(DOCKER_IMAGE_PREFIX)/lk2nd-target:latest" \
		"$(DOCKER_DIR)"

# ------------------------------------------------------------------------------
# Container Runtime & Interactive Shells
# ------------------------------------------------------------------------------

.PHONY: \
	lk2nd-sh-toolbox \
	lk2nd-sh-toolchain \
	lk2nd-sh-target

lk2nd-sh-toolbox:: lk2nd-check ## Open interactive shell inside toolbox container
	@echo "[INFO] Make: Spawning interactive shell in toolbox container..."
	@docker run --rm -it \
		-v "$(DOCKER_DIR)/volumes/output:/opt/lk2nd/output" \
		-v "$(OVERLAY_DIR):/opt/lk2nd-overlay:ro" \
		"$(DOCKER_IMAGE_PREFIX)/lk2nd-toolbox:latest" \
		bash

lk2nd-sh-toolchain:: lk2nd-check ## Open interactive shell inside toolchain container (Usage: make lk2nd-sh-toolchain [LK2ND_REF=...])
	@echo "[INFO] Make: Spawning interactive shell in toolchain container ($(LK2ND_REF))..."
	@docker run --rm -it \
		-v "$(DOCKER_DIR)/volumes/output:/opt/lk2nd/output" \
		-v "$(OVERLAY_DIR):/opt/lk2nd-overlay:ro" \
		"$(DOCKER_IMAGE_PREFIX)/lk2nd-toolchain:$(LK2ND_REF)" \
		bash

lk2nd-sh-target:: lk2nd-check ## Open interactive shell inside target container (Usage: make lk2nd-sh-target [LK2ND_REF=...])
	@echo "[INFO] Make: Spawning interactive shell in target container ($(LK2ND_REF))..."
	@docker run --rm -it \
		-v "$(DOCKER_DIR)/volumes/output:/opt/lk2nd/output" \
		"$(DOCKER_IMAGE_PREFIX)/lk2nd-target:$(LK2ND_REF)" \
		bash

# ------------------------------------------------------------------------------
# Bootloader Compilation & Workspace Management
# ------------------------------------------------------------------------------

.PHONY: \
	lk2nd-build \
	lk2nd-clean \
	lk2nd-clean-all

lk2nd-build:: lk2nd-check ## Compile lk2nd target in container (Usage: make lk2nd-build [LK2ND_TARGET=...] [LK2ND_REF=...])
	@echo "[INFO] Make: Building lk2nd target '$(LK2ND_TARGET)' in container ($(LK2ND_REF))..."
	@docker run --rm \
		-v "$(DOCKER_DIR)/volumes/output:/opt/lk2nd/output" \
		-v "$(OVERLAY_DIR):/opt/lk2nd-overlay:ro" \
		"$(DOCKER_IMAGE_PREFIX)/lk2nd-toolchain:$(LK2ND_REF)" \
		bash -c 'set -eux; \
			sudo chown -R lk2nd:lk2nd /opt/lk2nd/output; \
			cp -rf /opt/lk2nd-overlay/lk2nd/. ./lk2nd/ 2>/dev/null || true; \
			cp -rf /opt/lk2nd-overlay/project/. ./project/ 2>/dev/null || true; \
			make -j$$(nproc) $(LK2ND_TARGET); \
			mkdir -p /opt/lk2nd/output; \
			cp -rf build-$(LK2ND_TARGET)/* /opt/lk2nd/output/; \
			sudo chown -R $(CTX_UID):$(CTX_GID) /opt/lk2nd/output; \
			echo "[INFO] Build completed. Artifacts saved to docker/volumes/output/"'

lk2nd-clean:: ## Clean compiled bootloader artifacts from output volume
	@echo "[INFO] Make: Cleaning output directory..."
	@rm -rf "$(DOCKER_DIR)/volumes/output"/*
	@echo "[INFO] Make: Output volume cleaned."

lk2nd-clean-all:: lk2nd-clean ## Clean all container volumes and local build caches
	@echo "[INFO] Make: Cleaning build caches..."
	@rm -rf "$(DOCKER_DIR)/volumes/build"/*
	@echo "[INFO] Make: All volumes cleaned."
