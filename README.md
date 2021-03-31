# Bootloader
implementation of a bootloader,booted via a legacy BIOS. The bootable binary represents the boot sector of a disk and is recognized by the BIOS as a bootable image. The program switches to the protected mode (32-bits) and thereafter print “Hello world!” and the contents of the CR0 register (the one used to turn on protected mode).
