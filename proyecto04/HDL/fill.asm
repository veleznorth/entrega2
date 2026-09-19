// fill.asm
// Mantiene la pantalla negra mientras haya una tecla presionada,
// y blanca cuando no hay ninguna tecla presionada.
// Lee continuamente el teclado (KBD) y pinta toda la pantalla
// con -1 (negro) o 0 (blanco) segun corresponda.

(LOOP)
    @KBD
    D=M             // D = valor del teclado

    @FILL_BLACK
    D;JNE           // si D != 0 hay tecla, pintar negro

    // Si no hay tecla, pintar blanco
    @color
    M=0             // color = 0 (blanco)
    @PAINT
    0;JMP

(FILL_BLACK)
    @color
    M=-1            // color = -1 (negro, 1111111111111111)

(PAINT)
    // Inicializa el puntero al inicio de la pantalla
    @SCREEN
    D=A
    @addr
    M=D             // addr = SCREEN

(PAINT_LOOP)
    // Pinta la palabra actual con el color elegido
    @color
    D=M
    @addr
    A=M
    M=D             // RAM[addr] = color

    // Avanza al siguiente word
    @addr
    M=M+1

    // Comprueba si llegamos al teclado (fin de pantalla)
    @KBD
    D=A
    @addr
    D=D-M           // D = KBD - addr
    @PAINT_LOOP
    D;JGT           // mientras addr < KBD, seguir pintando

    // Vuelve al inicio para releer el teclado
    @LOOP
    0;JMP
