## Description

Provide a clear and concise description of the changes proposed in this Pull Request.

## Affected Components

- [ ] Target Profiles & Board Configurations (DTS, partition definitions)
- [ ] Bootloader Source & Patches (lk2nd / lk1st modifications)
- [ ] Packaging & Image Generation (fastboot boot.img, qhypstub wrapping)
- [ ] Docker Environment & Toolchains (Dockerfiles, multi-stage images)
- [ ] Build Orchestration & Tooling (Scripts, Makefile automation)
- [ ] AI Agent Context & Guidelines (`AGENTS.md`, `.aiignore`)
- [ ] GitHub Infrastructure & CI (`.github/`)
- [ ] Documentation (`README.md`, `docs/`, guides)

## Type of Change

- [ ] New board or device target support
- [ ] Bug fix / build recipe correction
- [ ] Bootloader feature enhancement
- [ ] Performance / build time optimization
- [ ] Documentation update
- [ ] Refactoring / code cleanup
- [ ] Breaking architectural change

## Quality Checklist

- [ ] Out-of-tree overlay principle is respected (no upstream lk2nd sources committed).
- [ ] Build directories and outputs (`output/`, `tmp/`, `*.img`, `*.bin`, `*.mbn`) are not tracked.
- [ ] Target profile compiles cleanly without errors.
- [ ] Markdown linting passes: `npx markdownlint-cli2` returns 0 issues.
- [ ] Mirrored documentation (`*.md` and `*_RU.md`) is synchronized.
- [ ] No secrets or test keys are present in repository commits.

## Related Issues

Closes #[Issue Number]
