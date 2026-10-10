# 🛠️ Development & Build Guide: BoardPort — lk2nd Builder

Practical developer manual detailing local container workflows, Make automation targets,
build configuration options, and interactive debugging.

---

## 📋 Prerequisites

To build bootloaders with **BoardPort — lk2nd Builder**, ensure the host system has:

- **Git:** with submodule support (`git submodule update --init --recursive`)
- **Container Engine:** Docker Engine (v20.10+) or Podman
- **GNU Make:** standard automation frontend

---

## ⚡ Automation Workflow (Make)

The repository provides automated workflows wrapping container builds:

### 1. Inspect Available Targets

List all supported automation commands with help descriptions:

```bash
make help
make list
```

### 2. Initialize Submodules

Before running local builds, check out and initialize all git submodules:

```bash
git submodule update --init --recursive
```

### 3. Build Base Toolbox Container

Build the foundational Debian image preloaded with all host utilities and cross-compilation toolchains:

```bash
make lk2nd-build-toolbox
```

### 4. Build Toolchain Environment with Upstream lk2nd

Fetch upstream `lk2nd` source code into an isolated container layer at a specific branch or release tag:

```bash
# Build default development branch (main)
make lk2nd-build-toolchain LK2ND_REF=main

# Build specific pinned release tag (e.g. 23.1)
make lk2nd-build-toolchain LK2ND_REF=23.1
```

### 5. Build Target Image with Integrated Overlay

Bake the hardware overlay directly into the container image for standalone or offline compilation:

```bash
make lk2nd-build-target LK2ND_REF=23.1 OVERLAY_REF=23.1
```

### 6. Compile Bootloader Images

Trigger target compilation inside the container with automatic application of the out-of-tree hardware overlay:

```bash
# Compile specific target profile for release 23.1
make lk2nd-build LK2ND_REF=23.1 LK2ND_TARGET=lk2nd-msm8916-boardport
```

Compiled binaries are placed into `docker/volumes/output/`:

- `lk2nd.img` — Android boot image format bootloader for fastboot booting or recovery partition flashing.
- `emmc_appsboot.mbn` — Primary bootloader payload for raw partition flashing or EDL emergency flashing.
- `qcdt.img` — Qualcomm device tree table (QCDT) appended to boot images.
- `lk.bin` — Raw Little Kernel executable binary.

### 7. Interactive Container Shell

Spawn an interactive shell inside the toolchain container with the local hardware overlay mounted into the workspace:

```bash
make lk2nd-sh-toolchain LK2ND_REF=23.1
```

---

## ⚙️ Configuration Variables

The build system accepts parameters via environment variables or CLI flags:

| Variable | Default | Description |
| :--- | :--- | :--- |
| `LK2ND_REF` | `main` | Git reference (branch or tag) of upstream `msm8916-mainline/lk2nd` |
| `LK2ND_COMMIT` | *(empty)* | Optional exact git commit SHA of upstream lk2nd |
| `OVERLAY_REF` | `main` | Release tag or git branch of `lk2nd-overlay` to bake into Target images |
| `LK2ND_TARGET` | `lk2nd-msm8916-boardport` | Target build profile defined in `overlay/project/` |
| `CONTAINER_TOOL` | `docker` | Container engine runtime (`docker` or `podman`) |
