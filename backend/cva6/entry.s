HARTID=0xf14
TO_HOST=0x80000000

  # Get hardware thread id
  csrr a0, HARTID

  # Set stack pointer to DRAM_TOP - (id * 2K)
  la sp, DRAM_TOP
  sll a0, a0, 13
  sub sp, sp, a0

  # Allocate 32 bytes of stack space
  add sp, sp, -32

  # Jump-and-link to main
  jal main

  csrr a0, HARTID
  bnez a0, 1f
  li a5, 1
  slli a5, a5, 31
  li a4, 1
  sd a4, 0(a5)
1:
  j .
