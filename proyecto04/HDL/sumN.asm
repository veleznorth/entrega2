// sumN.asm
// Suma todos los numeros del 1 hasta N
// El valor de N esta en RAM[0]
// El resultado queda en RAM[1]

// Arrancamos con resultado = 0
@1
M=0

// Usamos i como contador, empieza en 1
@i
M=1

(LOOP)
    // Cargamos el contador actual
    @i
    D=M

    // Si i > N terminamos
    @0
    D=D-M   // D = i - N
    @END
    D;JGT

    // Sumamos i al resultado
    @i
    D=M
    @1
    M=D+M

    // Avanzamos el contador
    @i
    M=M+1

    // Repetimos
    @LOOP
    0;JMP

(END)
@END
0;JMP
