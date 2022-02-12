global start
extern long_mode
global read_port
global write_port
global load_idt
extern main	
extern keyboard_handler_main
global keyboard_handler
section .text
bits 32
start:
    mov esp, stack_top
	call checkMlt
	call checkCpu
	call checkLmode
	call page_tables
	call enable_paging
	lgdt [gdt64.pointer]
	jmp gdt64.code_segment:long_mode
	hlt
checkMlt:
	cmp eax, 0x36d76289
	jne .multibootOff
	ret
.multibootOff:
	mov al, "M"
	jmp error
checkCpu:
	pushfd
	pop eax
	mov ecx, eax
	xor eax, 1 << 21
	push eax
	popfd
	pushfd
	pop eax
	push ecx
	popfd
	cmp eax, ecx
	je .no_cpuid
	ret
.no_cpuid:
	mov al, "C"
	jmp error
checkLmode:
	mov eax, 0x80000000
	cpuid
	cmp eax, 0x80000001
	jb .lmodeOff

	mov eax, 0x80000001
	cpuid
	test edx, 1 << 29
	jz .lmodeOff
	ret
.lmodeOff:
	mov al, "L"
	jmp error
page_tables:
	mov eax, table_3
	or eax, 0b11 
	mov [table_4], eax
	mov eax, table_2
	or eax, 0b11 
	mov [table_3], eax
	mov ecx, 0 
.loop:
	mov eax, 0x200000 
	mul ecx
	or eax, 0b10000011 
	mov [table_2 + ecx * 8], eax
	inc ecx 
	cmp ecx, 512 
	jne .loop 
	ret
enable_paging:
	mov eax, table_4
	mov cr3, eax
	mov eax, cr4
	or eax, 1 << 5
	mov cr4, eax
	mov ecx, 0xC0000080
	rdmsr
	or eax, 1 << 8
	wrmsr
	mov eax, cr0
	or eax, 1 << 31
	mov cr0, eax
	ret
error:
	mov dword [0xb8000], 0x4f524f45
	mov dword [0xb8004], 0x4f3a4f52
	mov dword [0xb8008], 0x4f204f20
	mov byte  [0xb800a], al
	hlt

read_port:
	mov edx, [esp + 4]
	in al, dx	
	ret
write_port:
	mov   edx, [esp + 4]    
	mov   al, [esp + 4 + 4]  
	out   dx, al  
	ret
load_idt:
	mov edx, [esp + 4]
	lidt [edx]
	sti 				;turn on interrupts
	ret
	; hlt
keyboard_handler:                 
	call    keyboard_handler_main
	iretd
section .bss
align 4096
table_4:
	resb 4096
table_3:
	resb 4096
table_2:
	resb 4096
stack_bottom:
	resb 4096 * 4
stack_top:
section .rodata
gdt64:
	dq 0 
.code_segment: equ $ - gdt64
	dq (1 << 43) | (1 << 44) | (1 << 47) | (1 << 53)
.pointer:
	dw $ - gdt64 - 1 
	dq gdt64 