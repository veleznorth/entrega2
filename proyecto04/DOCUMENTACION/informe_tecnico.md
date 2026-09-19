# Informe Técnico — Proyecto 4: Programas en Ensamblador Hack

**Curso:** Organización de Computadores 2026-2  
**Universidad:** EAFIT  
**Docente:** José Luis Montoya Pareja

---

## 1. Introducción

Este informe describe las decisiones de diseño, la lógica de implementación y los resultados de prueba de los cuatro programas escritos en lenguaje ensamblador Hack para el Proyecto 4 de Nand2Tetris. Los programas son: `Mult.asm`, `Fill.asm`, `SumN.asm` y `CopyBlock.asm`.

El lenguaje ensamblador Hack solo tiene dos tipos de instrucciones: la instrucción A (que carga un valor en el registro A) y la instrucción C (que realiza una operación en la ALU y puede escribir el resultado y/o hacer un salto). Toda la lógica de control se construye combinando estas dos instrucciones con etiquetas y saltos condicionales.

---

## 2. Mult.asm — Multiplicación por sumas repetidas

### ¿Qué hace?
Calcula `RAM[0] * RAM[1]` y guarda el resultado en `RAM[2]`. La multiplicación se implementa sumando `RAM[0]` un total de `RAM[1]` veces.

### Lógica
El programa inicializa `RAM[2] = 0` para limpiar cualquier valor previo. Luego usa `RAM[1]` como contador: en cada iteración suma `RAM[0]` al acumulador `RAM[2]` y decrementa el contador. Cuando el contador llega a cero, el programa termina en un bucle infinito (convención de Hack).

Un caso especial es cuando `RAM[1] = 0`: en ese caso el salto al final ocurre antes de entrar al loop, dejando `RAM[2] = 0` correctamente.

### Casos de prueba

| RAM[0] | RAM[1] | RAM[2] esperado |
|--------|--------|-----------------|
| 3      | 4      | 12              |
| 0      | 5      | 0               |
| 5      | 0      | 0               |
| 7      | 7      | 49              |

---

## 3. Fill.asm — Pantalla interactiva con teclado

### ¿Qué hace?
Monitorea el teclado continuamente. Si hay alguna tecla presionada, pinta toda la pantalla de negro. Cuando se suelta la tecla, la limpia y la deja en blanco.

### Lógica
La pantalla de Hack ocupa las direcciones de memoria `0x4000` a `0x5FFF` (8192 palabras de 16 bits). El teclado está en `0x6000`. Escribir `-1` (todos los bits en 1) en una palabra de pantalla la pone negra; escribir `0` la pone blanca.

El programa lee el valor de `KBD`. Si es distinto de cero hay una tecla presionada y se asigna `color = -1`; si es cero se asigna `color = 0`. Luego un único loop recorre todas las palabras de pantalla desde `SCREEN` hasta `KBD - 1` y escribe el color elegido. Al terminar, vuelve al inicio para releer el teclado.

Usar una variable `color` para unificar ambos casos evita tener dos loops de pintado separados, lo que simplifica el código y reduce la posibilidad de errores.

### Casos de prueba
- Presionar cualquier tecla → pantalla completamente negra.
- Soltar la tecla → pantalla completamente blanca.
- Mantener presionada y soltar varias veces → el cambio debe ser consistente.

---

## 4. SumN.asm — Suma de los primeros N naturales

### ¿Qué hace?
Calcula `1 + 2 + 3 + ... + N` y guarda el resultado en `RAM[1]`. El valor de N viene en `RAM[0]`.

### Lógica
Se usa un contador `i` que empieza en 1 y sube hasta N. En cada iteración se suma `i` al acumulador en `RAM[1]` y se incrementa `i`. La condición de parada es `i > N`, que se evalúa restando N de i y comprobando si el resultado es positivo.

El resultado inicial de `RAM[1]` se fija en 0 antes de entrar al loop para garantizar resultados correctos en ejecuciones repetidas.

### Casos de prueba

| N (RAM[0]) | Resultado esperado (RAM[1]) |
|------------|----------------------------|
| 0          | 0                          |
| 1          | 1                          |
| 5          | 15                         |
| 10         | 55                         |

---

## 5. CopyBlock.asm — Copia de bloque de memoria

### ¿Qué hace?
Copia N palabras consecutivas desde una dirección origen hacia una dirección destino.  
- `RAM[0]` = dirección de origen  
- `RAM[1]` = dirección de destino  
- `RAM[2]` = cantidad de palabras a copiar

### Lógica
El programa copia los valores de las tres entradas a variables simbólicas (`src`, `dst`, `i`) para no modificar las entradas originales durante la ejecución. Luego en cada iteración del loop: lee el valor en `RAM[src]`, lo escribe en `RAM[dst]`, avanza ambos punteros y decrementa el contador. Cuando `i = 0` el programa termina.

El uso de variables simbólicas en lugar de acceder directamente a RAM[0], RAM[1] y RAM[2] en cada iteración es más limpio y evita confusiones cuando los bloques origen y destino están cerca.

### Casos de prueba

| Origen | Destino | N  | Resultado                         |
|--------|---------|----|-----------------------------------|
| 100    | 200     | 3  | RAM[200..202] = RAM[100..102]     |
| 100    | 500     | 10 | RAM[500..509] = RAM[100..109]     |
| 50     | 51      | 0  | No se copia nada                  |
| 10     | 20      | 1  | RAM[20] = RAM[10]                 |

---

## 6. Conclusiones

Los cuatro programas demuestran los conceptos fundamentales del lenguaje ensamblador Hack:

- **Control de flujo:** todos los programas usan saltos condicionales (`JEQ`, `JGT`, `JNE`) para implementar bucles y condiciones.
- **Direccionamiento indirecto:** `CopyBlock.asm` y `Fill.asm` usan punteros (variables que contienen direcciones) y el operador `A=M` para acceder a memoria de forma dinámica.
- **Convenciones de la plataforma:** los programas respetan las convenciones de Hack (variables en RAM desde la posición 16, programa termina en bucle infinito, registros especiales SCREEN y KBD).
