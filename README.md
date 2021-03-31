# Bootloader
implementation of a bootloader,booted via a legacy BIOS. The bootable binary represents the boot sector of a disk and is recognized by the BIOS as a bootable image. The program switches to the protected mode (32-bits) and thereafter print “Hello world!” and the contents of the CR0 register (the one used to turn on protected mode).
For compilation use the nasm compiler nasm boot.asm -o boot.bin
For booting use x86_64 architecture emulated by qemu
qemu-system-x86_64 boot.bin
Booting instructions-
1. to compile the binary for booting use "make compile"
2. to boot use "make boot"
