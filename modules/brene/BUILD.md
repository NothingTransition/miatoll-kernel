# BRENE module package

This package is vendored from `rrr333nnn333/BRENE` and its provenance is
recorded in `Documentation/admin-guide/miatoll-root-stack.rst`. It expects the
KernelSU SUSFS command ABI. The kernel tree carries SUSFS v2.3.0 and the
package includes BRENE's `tools/susfs` helper from the same upstream snapshot.

BRENE changes system properties and hides selected paths only when its options
are enabled. It is not a guarantee that root is undetectable; test each target
application and keep a recovery/disable path available.
