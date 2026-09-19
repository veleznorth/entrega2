load "../HDL/fill.asm",
output-file "fill_blanco.out",
output-list RAM[24576]%D1.6.1 RAM[16384]%D1.6.1 RAM[24575]%D1.6.1;
set RAM[24576] 0;
repeat 250000 { ticktock; }
output;
echo "fill_blanco: RAM[24576] inicial=0";
