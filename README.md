# Práctica 2 — Construcción de la Plataforma Hack

**Curso:** Organización de Computadores 2026-2  
**Universidad:** EAFIT  
**Docente:** José Luis Montoya Pareja  
**Entrega:** 18 de septiembre de 2026

---

## ¿De qué trata este proyecto?

Este proyecto une todo lo que se construyó en la práctica anterior (compuertas, ALU, registros, RAM) para armar un computador completo que puede ejecutar programas reales. Hay dos grandes partes:

- **Proyecto 4:** programas escritos en lenguaje ensamblador Hack.
- **Proyecto 5:** los chips Memory, CPU y Computer implementados en HDL.

---

## Estructura del repositorio

```
proyecto04/
├── HDL/                  ← código fuente de los programas .asm
├── DOCUMENTACION/        ← informe técnico del proyecto 4
└── TESTS/                ← capturas de ejecución en el simulador

proyecto05/
├── HDL/                  ← chips Memory.hdl, CPU.hdl, Computer.hdl
├── DOCUMENTACION/        ← informe técnico del proyecto 5
└── TESTS/                ← capturas de los tests oficiales

README.md                 ← este archivo
```

---

## Proyecto 4 — Programas en Ensamblador

### Mult.asm
Multiplica dos números usando sumas repetidas.  
- Entrada: `RAM[0]` y `RAM[1]`  
- Salida: `RAM[2] = RAM[0] * RAM[1]`

### Fill.asm
Pinta la pantalla de negro mientras se presiona cualquier tecla, y la limpia (blanco) cuando se suelta.  
- No tiene entradas ni salidas en RAM, trabaja directamente con el mapa de memoria de la pantalla y el teclado.

### SumN.asm
Suma todos los números del 1 hasta N.  
- Entrada: `RAM[0] = N`  
- Salida: `RAM[1] = 1 + 2 + 3 + ... + N`

### CopyBlock.asm
Copia un bloque de palabras de memoria desde una dirección origen a una dirección destino.  
- Entrada: `RAM[0] = dirección origen`, `RAM[1] = dirección destino`, `RAM[2] = cantidad de palabras`

---

## Proyecto 5 — Hardware en HDL

### Memory.hdl
Implementa el espacio de direcciones completo del computador Hack: RAM de 16K, pantalla (Screen) y teclado (Keyboard), mapeados en memoria.

### CPU.hdl
La unidad central de procesamiento. Decodifica y ejecuta instrucciones tipo A y tipo C. Maneja los registros A y D, la ALU y el contador de programa (PC).

### Computer.hdl
Integra la ROM32K, la CPU y la Memory en un único chip que representa el computador Hack completo. Basta con conectar `reset` para arrancar la ejecución.

---

## Cómo probar

**Programas assembler (Proyecto 4):**
1. Abrir el CPU Emulator de nand2tetris.
2. Cargar el archivo `.asm` deseado.
3. Setear los valores de entrada en la RAM.
4. Ejecutar y verificar el resultado.

**Chips HDL (Proyecto 5):**
1. Abrir el Hardware Simulator de nand2tetris.
2. Cargar el `.hdl` correspondiente.
3. Correr el script de test oficial (`.tst`).
4. Verificar que el output coincide con el archivo `.cmp`.

---

## Decisiones de diseño relevantes

- En `Fill.asm` se decidió usar una variable simbólica `color` para evitar duplicar el loop de pintado. Un solo loop de pintura sirve tanto para negro como para blanco, simplemente cambiando el valor de `color` antes de entrar.
- En `Mult.asm` el resultado se inicializa en `RAM[2] = 0` al inicio para garantizar que ejecuciones repetidas no acumulen resultados anteriores.
- En `CPU.hdl` la lógica de salto se descompone en tres condiciones independientes (negativo, cero, positivo) que se combinan con `Or` para mayor claridad.
- En `Memory.hdl` se usa `DMux` en cascada para rutear correctamente las escrituras entre RAM, Screen y Keyboard según los bits 14 y 13 de la dirección.
