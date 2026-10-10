# Project Passport and Operational Guidelines for AI Agents: lk2nd Builder

> **Project:** BoardPort — lk2nd Builder  
> **Organization:** [BoardPort](https://github.com/boardport) | **Repository:** `boardport/lk2nd-builder`  
> **Mission:** Modular overlay-based builder for modified lk2nd/lk1st bootloader images  
> **Target Ecosystem:** Embedded hardware platforms, 4G/LTE modems, and mobile devices | **License:** [MIT](./LICENSE)  

---

## 1. AI Context Organization

The root [`AGENTS.md`](./AGENTS.md) and [`AGENTS_RU.md`](./AGENTS_RU.md) files serve as the authoritative baseline guidelines for all AI assistants.
Developers directly control, isolate, and customize secondary context for their specific tools:

- **Specialized Directories (`.(gemini|claude|cursor|continue|qwen|etc)/`):** Individual context for specific AI assistants
  (prompts, skills, reports, session dumps). These directories are isolated and excluded from git indexing (`.gitignore`).
- **Context Routing Files:** Navigation and indexing within specialized directories are organized via
  `.{ai}/README(_RU).md` or `.{ai}/AGENTS(_RU).md`. Specialized instructions complement the root guidelines and take precedence within their own context.
- **`.aiignore` File:** Defines resources strictly excluded from background indexing and scanning
  (build trees, downloads, firmware binaries, temporary caches). Agents may only access these files upon explicit user instruction.

---

## 2. Architecture & Submodule Organization

- **Master Orchestrator Repository:** `boardport/lk2nd-builder` coordinates compilation environments and customization layers.
- **Submodule Layers:**
  - `docker/` (`boardport/lk2nd-docker`): Container build recipes (`toolbox`, `toolchain`),
    Dockerfiles, and cross-compilation environment definitions.
  - `overlay/` (`boardport/lk2nd-overlay`): Out-of-tree hardware overlay (target profiles, DTS files,
    bootloader patches, and board quirks).
- **Clean Git Tracking:** Upstream source trees (`/lk2nd*`, `/littlekernel*`), local working copies,
  generated bootloader images (`output/`, `volumes/output/`), and temporary caches (`tmp/`, `volumes/tmp/`) must never be tracked in version control.

---

## 3. Automation Toolkit (Makefile)

The project includes a root orchestrator `Makefile` and modular tasks in `.make/`:

- `make help` / `make list`: Inspect all available automation commands.
- Specific build and container tasks are imported from `.make/*.mk`.
- **Root Makefile Policy:** It is strictly forbidden to add new commands directly to the master `Makefile`. All targets belong in modular `*.mk` files.

Detailed technical documentation is located in `docs/` (`docs/overview.en.md`, `docs/architecture.en.md`, `docs/development.en.md`).
Submodule documentation is available in `docker/README.md` and `overlay/README.md`.

---

## 4. Markdown Documentation Standards

- **Formatting Rules:** Syntax and formatting constraints are governed by `.editorconfig` and `.markdownlint-cli2.jsonc`.
- **Mandatory Lint Command:** Run `npx markdownlint-cli2 "**/*.md"` (must return `0 issues in 0 files` before completing work).
- **Mirrored Bilingualism:** All public user documentation is maintained in parallel (`*.md` in English and `*_RU.md` in Russian).

---

## 5. Git and GitHub Standards (`.github/`)

- Organizational policies, issue templates, PR descriptions, and CI workflows reside in [`.github/`](./.github/).
- Commit message standards follow the Conventional Commits specification (e.g., `feat:`, `fix:`, `docs:`, `chore:`).
- **Git Commits Rule:** Creating Git commits is allowed **only upon direct user confirmation**.
