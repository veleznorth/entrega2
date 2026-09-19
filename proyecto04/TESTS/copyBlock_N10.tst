load "../HDL/copyBlock.asm",
output-file "copyBlock_N10.out",
output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1 RAM[200]%D1.6.1 RAM[201]%D1.6.1 RAM[202]%D1.6.1 RAM[203]%D1.6.1 RAM[204]%D1.6.1 RAM[205]%D1.6.1 RAM[206]%D1.6.1 RAM[207]%D1.6.1 RAM[208]%D1.6.1 RAM[209]%D1.6.1;
set RAM[0] 100;
set RAM[1] 200;
set RAM[2] 10;
set RAM[100] 1;
set RAM[101] 2;
set RAM[102] 3;
set RAM[103] 4;
set RAM[104] 5;
set RAM[105] 6;
set RAM[106] 7;
set RAM[107] 8;
set RAM[108] 9;
set RAM[109] 10;
repeat 500 { ticktock; }
output;
echo "copyBlock_N10: RAM[0] inicial=100, RAM[1] inicial=200, RAM[2] inicial=10";
