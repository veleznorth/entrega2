load "../HDL/sumN.asm",
output-file "sumN_test1.out",
output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1;
set RAM[0] 5;
repeat 250 { ticktock; }
output;
echo "sumN_test1: RAM[0] inicial=5";
