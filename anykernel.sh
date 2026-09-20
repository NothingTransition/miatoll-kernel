### AnyKernel3 Ramdisk Mod Script
## Miatoll KernelSU/SUSFS kernel package
## AnyKernel3 by osm0sis; this script only replaces the boot kernel.

properties() { '
kernel.string=miatoll KernelSU/SUSFS
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=curtana
device.name2=miatoll
device.name3=joyeuse
device.name4=excalibur
device.name5=gram
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties

# Xiaomi Miatoll uses a single boot partition name even on A/B firmware.
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# Import AnyKernel3 functions and boot-image handling.
. tools/ak3-core.sh;

ui_print " ";
ui_print "Miatoll KernelSU/SUSFS";
ui_print "KernelSU + SUSFS + NoMount + BRENE support";
ui_print "Target devices: curtana / miatoll family";
ui_print " ";

# Preserve the existing ramdisk and device tree; replace only the kernel.
dump_boot;
write_boot;
## end boot install
