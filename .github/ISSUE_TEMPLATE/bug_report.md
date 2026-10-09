---
name: 'Bug Report'
about: 'Report a build failure, recipe issue, or target problem in lk2nd Builder'
title: '[BUG] '
labels: 'bug'
assignees: ''
---

## Description

Provide a clear and concise description of the bug.

## Affected Area

Select all that apply:

- [ ] Target Profile & Device Definition (DTS, partition layout, hardware quirks)
- [ ] Bootloader Source & Patches (lk2nd / lk1st modifications)
- [ ] Packaging & Boot Images (fastboot boot.img, qhypstub, header wrappers)
- [ ] Docker Environment & Toolchains (Cross-compilers, dtc, python tools)
- [ ] Build Orchestration & Automation (Makefile, scripts)
- [ ] Documentation / Metadata (`README.md`, `.github/`)

## Hardware & Environment Details

- **Device Model:** [e.g. Board / Dongle / Phone model]
- **SoC / Architecture:** [e.g. MSM8916 / MSM8953 / ARM / AArch64]
- **Target Profile Name:** [e.g. lk2nd-msm8916 / board profile name]
- **Host OS & Architecture:** [e.g. Ubuntu 24.04 x86_64]

## Build Command Executed

Specify the exact command executed:

```bash
# Example build invocation command
make build TARGET=...
```

## Steps to Reproduce

1. Configure target with '...'
2. Run build command '...'
3. See error output '...'

## Expected Behavior

A clear description of what you expected to happen.

## Actual Behavior

A clear description of what occurred, including compilation or packaging error output.

## Terminal Logs & Build Output

```text
Paste raw compilation logs, compiler errors, or stack traces here
```
