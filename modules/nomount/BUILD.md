# NoMount module package

This is the module template from `maxsteeel/nomount` `dev`, pinned in
`Documentation/admin-guide/miatoll-root-stack.rst`. The in-kernel NoMount
implementation is built in-tree from `fs/nomount` with `CONFIG_NOMOUNT=y`.

The upstream release package normally supplies architecture-specific `nm` and
`lkmloader` binaries. They are not checked in here because this checkout does
not contain a trusted ARM64 compiler/toolchain and a host binary must never be
used on the phone. Build the userspace binary with the upstream workflow (or a
matching Android NDK), then place the resulting `nm-arm64` and loader artifacts
under this package before packaging it as a KernelSU module.
