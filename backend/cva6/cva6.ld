OUTPUT_ARCH( "riscv" )

BOOT_MEM  = 0x80060000;
DRAM_BASE = 0x80060000;
DRAM_TOP  = 0x80070000;

SECTIONS
{
  . = 0x80000000;

  .tohost : { *(.tohost) }

  . = BOOT_MEM;

  .text   : { *.o(.text) }
  .bss    : { *.o(.bss) }
  .data   : { *.o(.data) }
  .rodata : { *.o(.rodata*) }
}
