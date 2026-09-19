# Informe Técnico — Proyecto 5: CPU y Computador Hack

**Curso:** Organización de Computadores 2026-2  
**Universidad:** EAFIT  
**Docente:** José Luis Montoya Pareja

---

## 1. Introducción

Este informe describe la implementación de los tres chips que completan la plataforma Hack: `Memory.hdl`, `CPU.hdl` y `Computer.hdl`. Estos chips integran todo lo construido en prácticas anteriores (compuertas, ALU, registros, RAM) en un computador funcional capaz de ejecutar programas escritos en lenguaje ensamblador.

---

## 2. Memory.hdl — El espacio de memoria completo

### ¿Qué hace?
Implementa el mapa de memoria del computador Hack. Todas las lecturas y escrituras del programa pasan por este chip. La dirección de 15 bits determina a cuál de los tres dispositivos se accede:

| Rango de direcciones | Dispositivo  |
|----------------------|--------------|
| 0x0000 – 0x3FFF      | RAM (16K)    |
| 0x4000 – 0x5FFF      | Pantalla     |
| 0x6000               | Teclado      |

### Decisiones de diseño

El chip usa `DMux` en cascada para decidir a dónde va la señal de escritura:

1. El bit 14 de la dirección separa RAM (0) de los dispositivos de I/O (1).
2. El bit 13 separa la pantalla (0) del teclado (1) dentro del bloque de I/O.

El teclado es de solo lectura, así que aunque `loadKbd` pudiera activarse por error de dirección, no tiene efecto porque el chip `Keyboard` ignora la señal de carga.

Para la lectura, dos `Mux16` en cascada seleccionan la salida correcta según los mismos bits 14 y 13.

### Por qué funciona así
El diseño refleja exactamente la especificación de la arquitectura Hack: el espacio de I/O empieza en el bit 14 = 1, y dentro de ese espacio la pantalla y el teclado se distinguen por el bit 13. Usar `DMux` en cascada es la traducción directa de esa lógica de decodificación de direcciones.

---

## 3. CPU.hdl — La unidad central de procesamiento

### ¿Qué hace?
Decodifica y ejecuta una instrucción por ciclo de reloj. Soporta los dos tipos de instrucciones de la arquitectura Hack:

- **Instrucción A** (`instrucción[15] = 0`): carga el valor de los 15 bits inferiores en el registro A.
- **Instrucción C** (`instrucción[15] = 1`): ejecuta una operación en la ALU y puede escribir el resultado en A, D o memoria, y puede saltar.

### Estructura interna

La CPU se compone de los siguientes elementos conectados:

**Registro A**  
Puede recibir dos tipos de valores: la instrucción completa (cuando es instrucción A) o el resultado de la ALU (cuando es instrucción C con destino A). El `Mux16` selecciona entre los dos usando el bit 15 de la instrucción. La carga del registro A se activa si es instrucción A, o si es instrucción C y el bit de destino 5 está en 1.

**Registro D**  
Solo se carga cuando es una instrucción C con el bit de destino 4 en 1. Siempre alimenta la entrada X de la ALU.

**Selección de operando Y de la ALU**  
Un `Mux16` elige entre el valor del registro A y el valor leído de memoria (`inM`) según el bit 12 de la instrucción (el bit `a`). Si `a = 0` la ALU opera sobre el registro A; si `a = 1` opera sobre memoria.

**ALU**  
Recibe los bits de control `zx, nx, zy, ny, f, no` directamente de los bits 11 al 6 de la instrucción. Produce el resultado y las banderas `zr` (resultado cero) y `ng` (resultado negativo).

**Lógica de salto**  
Se combinan tres condiciones con `And` y `Or`:
- Salto si negativo: `instruction[2] AND ng`
- Salto si cero: `instruction[1] AND zr`
- Salto si positivo: `instruction[0] AND (NOT ng AND NOT zr)`

Si alguna condición se cumple y es instrucción C, el PC carga el valor de A. Si no, el PC se incrementa normalmente.

**Escritura en memoria**  
`writeM` se activa cuando es instrucción C y el bit de destino 3 está en 1.

### Por qué funciona así
Cada bit de la instrucción C tiene un significado preciso en la especificación de Hack. El diseño mapea directamente esos bits a las señales de control de cada componente, sin lógica adicional innecesaria. Esto hace que sea fácil de verificar contra la especificación y de depurar cuando algo no funciona.

---

## 4. Computer.hdl — El computador completo

### ¿Qué hace?
Conecta los tres componentes principales (ROM32K, CPU, Memory) en un único chip que representa el computador Hack completo. Tiene una sola entrada: `reset`.

### Conexiones

```
ROM32K  →  instrucción  →  CPU
CPU     →  outM, writeM, addressM  →  Memory
Memory  →  memOut  →  CPU (inM)
CPU     →  pc  →  ROM32K (address)
```

El ciclo es:
1. La ROM entrega la instrucción que apunta el PC.
2. La CPU la ejecuta, posiblemente escribe en memoria y calcula el siguiente PC.
3. La memoria entrega el valor leído para el siguiente ciclo.
4. El PC actualizado apunta a la siguiente instrucción.

Cuando `reset = 1` el PC vuelve a 0 y el programa comienza desde el principio.

### Por qué es tan simple
La complejidad real está en la CPU y la Memory. El chip Computer es casi solo un cable que los conecta de la manera correcta. Esta separación de responsabilidades es una decisión de diseño intencional de la arquitectura Hack: cada nivel de abstracción oculta su complejidad al nivel superior.

---

## 5. Conclusiones

La implementación de estos tres chips cierra el ciclo completo desde compuertas lógicas hasta un computador funcional:

- **Memory** demuestra cómo el hardware mapea dispositivos físicos distintos (RAM, pantalla, teclado) en un único espacio de direcciones lineal.
- **CPU** muestra cómo una instrucción de 16 bits se descompone en señales de control que coordinan la ALU, los registros y el contador de programa.
- **Computer** ilustra el principio de abstracción: componentes complejos se usan como cajas negras para construir sistemas más grandes.

Al ejecutar un programa como `Fill.asm` en el computador ensamblado, se puede ver en acción toda la cadena: el ensamblador convierte el código a binario, la ROM lo almacena, la CPU lo ejecuta instrucción por instrucción, y la memoria conecta el resultado con la pantalla.
