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

## 📚 Project Documentation Hub

- 📖 **[Project Overview](./docs/overview.en.md)** — mission, platform targets, and bootloader image formats.
- 🏛️ **[System Architecture](./docs/architecture.en.md)** — system design, OCI container hierarchy, and compatibility matrix.
- 🛠️ **[Development & Build Guide](./docs/development.en.md)** — container workflows, Make targets, options, and debugging.
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
