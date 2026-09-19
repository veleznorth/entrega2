load "../HDL/sumN.asm",
output-file "sumN_N0.out",
output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1;
set RAM[0] 0;
repeat 100 { ticktock; }
output;
echo "sumN_N0: RAM[0] inicial=0";
