load "../HDL/copyBlock.asm",
output-file "copyBlock_distante.out",
output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1 RAM[500]%D1.6.1 RAM[501]%D1.6.1 RAM[502]%D1.6.1;
set RAM[0] 100;
set RAM[1] 500;
set RAM[2] 3;
set RAM[100] 7;
set RAM[101] 9;
set RAM[102] 4;
repeat 300 { ticktock; }
output;
echo "copyBlock_distante: RAM[0] inicial=100, RAM[1] inicial=500, RAM[2] inicial=3";
