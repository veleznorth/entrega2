load "../HDL/mult.asm",
output-file "mult_test1.out",
output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1;
set RAM[0] 3;
set RAM[1] 4;
repeat 200 { ticktock; }
output;
echo "mult_test1: RAM[0] inicial=3, RAM[1] inicial=4";
