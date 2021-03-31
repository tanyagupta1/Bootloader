compile:boot.asm
	nasm boot.asm -o boot.bin
boot:compile
	qemu-system-x86_64 boot.bin
