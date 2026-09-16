(LOOP1)
    @KBD
    D=M


    @LOOP1
    D;JEQ
    //Detectamos el oprimir de de la tecla
    @FILL
    D;JNE

    //ROl iF seccion de llenado
    (FILL)
        //Carga la direccion simbolica de screen
        @SCREEN
        D=A
        @addr
        M=D         // addr = inicio de pantalla

        (LOOP)
            @addr
            A=M
            M=-1        // pinta negro (1111111111111111)

            @addr
            M=M+1       // addr++

            @KBD
            D=A
            @addr
            D=D-M       // D = KBD - addr
            @LOOP
            D;JGT       // si quedan palabras, sigue


        @LOOP
        0;JMP
@LOOP1
0;JMP


//bucle infinito 
(END)
@END
0;JMP