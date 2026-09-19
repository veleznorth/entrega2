load "../HDL/mult.asm",
output-file "mult_test2.out",
output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1;
set RAM[0] 7;
set RAM[1] 7;
repeat 200 { ticktock; }
output;
echo "mult_test2: RAM[0] inicial=7, RAM[1] inicial=7";
