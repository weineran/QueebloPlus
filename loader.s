global loader                   ; the entry symbol for ELF

MAGIC_NUMBER equ 0x1BADB002     ; define the magic number constant
FLAGS        equ 0x0            ; multiboot flags
CHECKSUM     equ -MAGIC_NUMBER  ; calculate the checksum
                                ; (magic number + checksum + flags should equal 0)
KERNEL_STACK_SIZE equ 4096


section .bss
align 4 
  kernel_stack:                   ; label points to beginning of memory
  resb KERNEL_STACK_SIZE        ; reserve stack for the kernel

section .text:                  ; start of the text (code) section
align 4                         ; the code must be 4 byte aligned
  dd MAGIC_NUMBER             ; write the magic number to the machine code,
  dd FLAGS                    ; the flags,
  dd CHECKSUM                 ; and the checksum
  dd KERNEL_STACK_SIZE

loader:                         ; the loader label (defined as entry point in linker script)
  mov ebx, 0x600D600D 
  mov eax, 0xCAFEBAB1         ; place the number 0xCAFEBABE in the register eax
  mov esp, kernel_stack + KERNEL_STACK_SIZE ; point esp to start of the stack 
.loop:
  jmp .loop                   ; loop forever











