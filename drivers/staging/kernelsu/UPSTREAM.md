# Vendored KernelSU source

This directory contains the `kernel/` implementation from
[backslashxx/KernelSU](https://github.com/backslashxx/KernelSU), pinned to:

- Commit: `0b2fa25b7e021215f82d274610239525f45d2c37`
- KernelSU release line: `v3.3.0+` (`32630c`)
- KernelSU version code in the vendored Makefile: `32630`
- SUSFS integration: `nanix06/susfs4ksu` `kernel-4.14` at
  `63a76f2aa1ae4245f7831e3afd479c26baef14ff`

The SUSFS integration patch is applied to the vendored KernelSU tree before it
is built. The upstream license is retained in `kernel/LICENSE`.
