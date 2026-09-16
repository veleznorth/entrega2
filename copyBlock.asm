// copyBlock.asm
// Copia un bloque de memoria de un lado a otro
// RAM[0] = direccion de origen
// RAM[1] = direccion de destino
// RAM[2] = cantidad de palabras a copiar

// Inicializamos el puntero de origen con la direccion base
@0
D=M
@src
M=D

// Inicializamos el puntero de destino con la direccion base
@1
D=M
@dst
M=D

// Guardamos cuantas palabras hay que copiar en el contador
@2
D=M
@i
M=D

(LOOP)
    // Si ya copiamos todo, terminamos
    @i
    D=M
    @END
    D;JEQ

    // Leemos el valor en la posicion actual del origen
    @src
    A=M
    D=M     // D = RAM[src]

    // Lo escribimos en la posicion actual del destino
    @dst
    A=M
    M=D     // RAM[dst] = D

    // Avanzamos ambos punteros al siguiente elemento
    @src
    M=M+1
    @dst
    M=M+1

    // Descontamos una palabra del contador
    @i
    M=M-1

    // Repetimos
    @LOOP
    0;JMP

(END)
@END
0;JMP
