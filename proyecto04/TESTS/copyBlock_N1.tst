load "../HDL/copyBlock.asm",
output-file "copyBlock_N1.out",
output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1 RAM[200]%D1.6.1;
set RAM[0] 100;
set RAM[1] 200;
set RAM[2] 1;
set RAM[100] 7;
set RAM[201] 123;
repeat 200 { ticktock; }
output;
echo "copyBlock_N1: RAM[0] inicial=100, RAM[1] inicial=200, RAM[2] inicial=1";
