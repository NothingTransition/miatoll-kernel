# Vendored KernelSU source

This directory contains the `kernel/` implementation from
[backslashxx/KernelSU](https://github.com/backslashxx/KernelSU), pinned to:

- Commit: `5a2eee6a851493f39310918386e094cb03c4397b`
- KernelSU version code in the vendored Makefile: `32630`
- SUSFS integration: `nanix06/susfs4ksu` `kernel-4.14` at
  `63a76f2aa1ae4245f7831e3afd479c26baef14ff`

The SUSFS integration patch is applied to the vendored KernelSU tree before it
is built. The upstream license is retained in `kernel/LICENSE`.
