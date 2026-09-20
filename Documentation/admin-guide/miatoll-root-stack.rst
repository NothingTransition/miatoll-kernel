Miatoll root/concealment stack
==============================

Target
------

This tree is the ARM64 ``miatoll`` kernel for the Xiaomi Redmi Note 9 Pro
family, including curtana.  The selected defconfig is
``arch/arm64/configs/vendor/xiaomi/miatoll_defconfig``.  It is intended for
AOSP-based miatoll builds such as Infinity X Android 16, while retaining the
vendor tree's Linux 4.14 ABI (4.14.344-openela).

Integrated components
---------------------

The following upstream snapshots are vendored or applied in-tree:

* ``backslashxx/KernelSU``: ``v3.3.0+`` / tag ``32630c`` at commit
  ``0b2fa25b7e021215f82d274610239525f45d2c37`` (KernelSU version code
  ``32630`` in its vendored build metadata).
* ``nanix06/susfs4ksu``: ``kernel-4.14`` at commit
  ``63a76f2aa1ae4245f7831e3afd479c26baef14ff``.  Its 4.14 integration patch
  supplies SUSFS v2.3.0 and the KernelSU supercall integration.
* ``maxsteeel/nomount``: ``dev`` at commit
  ``d6cb7158b5a98a8168fa7bae191e23cbcfd38974``.  The built-in source is in
  ``fs/nomount`` and is selected with ``CONFIG_NOMOUNT=y``.
* ``rrr333nnn333/BRENE``: commit
  ``b255fec7e21ee6a0ed8c9cab6476a2b8bb900b15`` (module v0.0.67).  The
  source module package is in ``modules/brene`` and includes its SUSFS helper.

SUSFS and KernelSU are deliberately integrated as a matched pair.  Do not
flash the BRENE helper with a kernel carrying a different SUSFS command ABI.
The supplied kernel reports SUSFS ``v2.3.0``; BRENE's helper must report a
compatible v2 version before its configuration is enabled.

Defconfig choices
------------------

The target defconfig keeps the existing eBPF stack and makes its intent
explicit through the following enabled options:

* ``CONFIG_BPF_SYSCALL``, ``CONFIG_BPF_JIT``, and
  ``CONFIG_BPF_JIT_ALWAYS_ON``;
* ``CONFIG_CGROUP_BPF``, ``CONFIG_NET_CLS_BPF``, and
  ``CONFIG_NET_ACT_BPF``; and
* ``CONFIG_KSU=y``, the 4.14-compatible syscall-table hook,
  ``CONFIG_KSU_SUSFS=y``, all SUSFS concealment primitives, and
  ``CONFIG_NOMOUNT=y``.

The routine SUSFS log is disabled in the target config, and the KSU/SUSFS
symbols are hidden where supported.  These settings reduce ordinary telemetry;
they do not make a compromised kernel or a determined application unable to
detect modifications.

Build
-----

Use an Android Clang toolchain compatible with this vendor tree.  The existing
``build.config.aarch64`` describes the original Android 4.14 toolchain
variables.  A typical out-of-tree build is:

.. code-block:: sh

   export ARCH=arm64
   export LLVM=1
   export LLVM_IAS=1
   export O="$PWD/out/miatoll"
   make O="$O" ARCH=arm64 vendor/xiaomi/miatoll_defconfig
   make -j"$(nproc)" O="$O" ARCH=arm64 LLVM=1 LLVM_IAS=1 \
        CROSS_COMPILE=aarch64-linux-androidkernel- Image.gz dtbs

The repository also contains ``anykernel.sh`` and
``.github/workflows/build-flashable.yml``.  The workflow builds the ARM64
``Image.gz`` and packages it with the current AnyKernel3 tooling as
``Miatoll-KernelSU-SUSFS-<commit>.zip``.  The package replaces only the kernel
and preserves the boot image's existing ramdisk and device tree.  It is
available as a GitHub Actions artifact after a workflow-dispatch or a matching
source push; generated ZIPs are intentionally not committed to Git.

Check the resulting ``.config`` for the options above before flashing.  Keep a
known-good boot image and a way to disable KernelSU modules available.  Verify
the boot partition layout on the actual phone/recovery before using the ZIP;
AnyKernel3 cannot protect against an incorrect vendor boot layout.

NoMount packaging
------------------

The kernel integration is built-in, so the phone does not need a NoMount LKM
for this tree.  ``modules/nomount`` is the upstream module template and
userspace source.  Its release workflow normally creates architecture-specific
``nm`` and ``lkmloader`` binaries; those binaries are not fabricated or copied
from another architecture in this repository.  Build the ARM64 userspace
artifacts with the upstream workflow or a matching Android/zig toolchain before
creating a flashable NoMount module.

Concealment scope and testing
-----------------------------

KernelSU/SUSFS, BRENE, NoMount, and the pre-existing ``fs/suspicious.c`` hooks
provide configurable path, mount, metadata, map, property, and module hiding.
They are concealment mechanisms, not a claim of absolute or ``undetectable``
root.  Test on the actual Infinity X build with the target applications,
including clean-boot, module-disable, `/proc`/`/sys` visibility, SELinux
enforcing, BPF, and recovery paths.  A failed test must be treated as a
compatibility issue rather than hidden by adding more unconditional hooks.
