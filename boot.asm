bits 16
org 0x7c00
mystring: db "Hello world! CR0:",0
one: db '0000000000000000000000000010001',0
zero: db '0',0

boot:
	mov ax, 0x2401
	int 0x15           ; this helps use more than 1MB memory by using the A20-gate activate function
	mov ax, 0x3          
	int 0x10           ;this initialises the VGA mode 
	cli
	lgdt [gdt_pointer]  ;loading the global descriptor table
	mov eax, cr0
	or eax,0x1
	mov cr0, eax
	jmp CODE_SEG:boot32bit
gdt_start:                           ;setting up the global descriptor table
	dq 0x0
gdt_code:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0
gdt_data:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
gdt_end:
gdt_pointer:
	dw gdt_end - gdt_start
	dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

bits 32
boot32bit:
        mov esi,mystring
        mov ebx,0xb8000
	mov ax, DATA_SEG
        mov ss, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	
	
.loophello:                          ;printing hello world
	lodsb                        ;loads single byte from esi to al
	or al,al
	jz .loopcrreg
	or eax,0x0200
	mov word [ebx], ax
	add ebx,2
	jmp .loophello

.loopcrreg:
       mov ecx,cr0
       mov edx,32                     ;to print 32 bits using a loop
       add ebx,64 
       ; mov esi,one
       ; add ebx,2

.loopreg:                             ;printing contents of cr0
	mov eax, 00000330h
        
	shr ecx,1                     ;shifting left by 1 bit, the rightmost bit gets stored in carry flag
	adc eax,0
	mov word [ebx], ax
        sub ebx, 2
        dec edx
        jnz .loopreg 
	jz endprog
clearreg:
endprog:
	cli
	hlt


times 510 - ($-$$) db 0     ;padding with 0s
dw 0xaa55                   ; making the sector bootable by designating the511 and 512 byte as 0xaa55
