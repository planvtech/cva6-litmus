PLATFORM="cva6"

CC="riscv64-unknown-elf-gcc"
AS="riscv64-unknown-elf-as"
LD="riscv64-unknown-elf-ld"
OBJCOPY="riscv64-unknown-elf-objcopy"
OBJDUMP="riscv64-unknown-elf-objdump"

OPT="-O -fno-builtin"          #optimize even more and avoid to use standard c functions
CFLAGS="$OPT -I. -mcmodel=medany -g"  #include actuar directory to search directories
LDFLAGS="-G 0 -T $PLATFORM/$PLATFORM.ld"

CFILES="main io log hash rand riscv/arch cva6/platform cva6/uart test"
OFILES=""
for F in $CFILES
do
  OFILES="$OFILES `basename $F.o`"
  $CC $CFLAGS -std=gnu99 -Wall -c -o `basename $F.o` $F.c  #-std define the standard used
done

$AS -o entry.o cva6/entry.s
$LD $LDFLAGS -o main.elf entry.o $OFILES
$OBJDUMP -S main.elf > main.dump
$OBJCOPY -O verilog main.elf main.vh
/home/max/Workarea/culsans/tests/integration/test_automation/vh2hex.py -m main.vh -o main.hex -b 0x80000000 -d 0x80000000 -i 0x80100000
rm main.vh
#elf2hex 16 65536 main.elf >
