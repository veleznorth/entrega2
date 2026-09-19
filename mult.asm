//Nos aseguramos de que el resultado inicie en 0
@2
M=0

//Guardamos en temporal la cantidad de veces que hay que sumar el numero
@1
D=M

//Finalizamos si la cantidad de veces que hay que sumar es 0
@END
D;JEQ



(LOOP)

//Guardamos en temporal el numero que vamos a sumar
@0
D=M

//Sumamos el numero
@2
M=D+M

//Restamos al contador
@1
M=M-1
D=M

//Reiniciamos el loop si el temporal es mayor  a 0
@LOOP
D;JGT

(END)

//Dejamos en bucle el programa
@END
0;JMP
