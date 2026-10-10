# 📦 BoardPort — lk2nd Builder

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![Project: BoardPort](https://img.shields.io/badge/Project-BoardPort-green.svg)](https://github.com/boardport)
[![Upstream: lk2nd](https://img.shields.io/badge/Upstream-lk2nd-00d7d7.svg)](https://github.com/msm8916-mainline/lk2nd)
[![Markdownlint](https://github.com/boardport/lk2nd-builder/actions/workflows/markdownlint.yml/badge.svg)](https://github.com/boardport/lk2nd-builder/actions/workflows/markdownlint.yml)

Modular out-of-tree builder for modified lk2nd and lk1st bootloader images for embedded boards, cellular 4G/LTE modems, and mobile platforms.

This repository is part of the **[BoardPort](https://github.com/boardport)** ecosystem, providing a clean customization layer
over standard lk2nd build environments without tracking heavy upstream trees or polluting baseline sources.

> 🤖 **Note for AI Assistants:** Autonomous AI agents and LLM assistants must review project guidelines
> in [AGENTS.md](./AGENTS.md) before performing tasks in this repository.

---

## 🎯 About the Project

The primary mission of **lk2nd Builder** is orchestrating containerized and reproducible builds of modified `lk2nd` and `lk1st`
bootloader images tailored to hardware-specific constraints across diverse embedded platforms:

- 📶 **Cellular 4G/LTE USB Modems and Portable Routers:** Compact mobile gateways, USB dongles, and Qualcomm-based hardware.
- 🧩 **Development Single-Board Computers (SBCs):** Evaluation kits and computing modules.
- 📱 **Repurposed Mobile & Embedded Platforms:** Converted smartphones and boards transitioning into mainline Linux systems.

### Repository Architecture

The project is structured as a modular orchestrator coordinating decoupled submodules:

- **`docker/` ([lk2nd-docker](https://github.com/boardport/lk2nd-docker)):** Multi-stage container build recipes providing isolated compilation
  toolboxes and cross-toolchains (`arm-none-eabi-`, `aarch64-linux-gnu-`, etc.).
- **`overlay/` ([lk2nd-overlay](https://github.com/boardport/lk2nd-overlay)):** Out-of-tree hardware overlay containing device trees,
  target definitions, and proprietary board customizations.

---

## ⚡ Quick Start Workflow

The repository includes a ready-to-use Make automation toolkit:

### 1. Inspect Available Commands

```bash
make help
make list
```

### 2. Inspect Submodules

Ensure all git submodules are checked out and initialized:

```bash
git submodule update --init --recursive
```

### 3. Build Base Toolbox Container

Build the foundational Debian build environment containing all host and cross-compilation tools:

```bash
make lk2nd-build-toolbox
```

### 4. Build Toolchain Environment with Upstream lk2nd

Build the Docker container preloaded with the lk2nd secondary bootloader source tree (default or specific release tag):

```bash
# Build default branch (main) or specific tag (e.g. 23.1)
make lk2nd-build-toolchain LK2ND_REF=23.1
```

### 5. Build Target Image with Baked-in Overlay (Optional)

Build the ready-to-use target container with integrated BoardPort overlay:

```bash
make lk2nd-build-target LK2ND_REF=23.1 OVERLAY_REF=23.1
```

### 6. Compile Target Bootloader with Hardware Overlay

Trigger bootloader compilation inside the container with automatic application of `overlay/`:

```bash
# Build specific release tag and target profile
make lk2nd-build LK2ND_REF=23.1 LK2ND_TARGET=lk2nd-msm8916-boardport
```

Compiled bootloader binaries are placed into `docker/volumes/output/`.

### 7. Interactive Container Development

Spawn an interactive container shell with the hardware overlay bound into the build workspace:

```bash
make lk2nd-sh-toolchain LK2ND_REF=23.1
```

## 📚 Project Documentation Hub

- 🐳 **[Docker Submodule Documentation](./docker/README.md)** — container architecture, toolchains, and build stages.
- 🧩 **[Overlay Submodule Documentation](./overlay/README.md)** — hardware overlay hierarchy, targets, and driver catalog.
- 🤖 **[AI Guidelines & Agents Context](./AGENTS.md)** — operational protocols and conventions for autonomous AI agents.
- 🤝 **[Contributing Guide](./.github/CONTRIBUTING.md)** — contribution standards, commit rules, and PR requirements.
- 🔒 **[Security Policy](./.github/SECURITY.md)** — vulnerability disclosure procedures.
- 💬 **[Support Resources](./.github/SUPPORT.md)** — community channels and assistance.

---

## 📄 License & Acknowledgments

- Build orchestration recipes, documentation, and tooling are released under the
  **[MIT License](./LICENSE)**.
- lk2nd is licensed primarily under the Little Kernel MIT/BSD-style licenses and GPL-2.0.
  Sincere appreciation to the lk2nd and Little Kernel communities.
