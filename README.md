# Segunda Practica de Estructuras de Computadores

Creacion de una CPU "Simple"

## Autores

Ancor Gonzalez Carballo && Ángel Vladislav Alonso Yemelyantseva

## Pasos para trabajar con verilog

iverilog -o ha_v1.vvp ha_v1_tb.v ha_v1.v
./ha_v1.vvp
gtkwave ha_v1_tb.vcd &

## Descripcion del trabajo

Ahora mismo falta saber si el test_bench funciona de forma correcta porque
a la hora de asignar valores a las entradas no sabemos si lo estamos haciendo
de la forma que se nos pide.

## Descripcion de la CPU

**Instrucción de operación aritmética o lógica:**

1 - Instrucción de operación aritmética o lógica:
  Opcode de 4 bits (15-12): Un código de operación (número) de 4 bits que identifica el tipo de operación a realizar.

2 - Campos de registros (operando y destino):
  Campo de primer registro operando de 4 bits (RA1, 11-8): Un conjunto de 4 bits que representa el primer operando (dato) obtenido de un registro de la memoria.
  Campo de segundo registro operando de 4 bits (RA2, 7-4): Otro conjunto de 4 bits que representa el segundo operando obtenido de otro registro de la memoria.
  Campo de registro de destino de 4 bits (WA3, 3-0): Un conjunto de 4 bits que indica en qué registro se almacenará el resultado de la operación.

3 - Operación con la ALU (Unidad Lógica Aritmética):
  Si la señal s_inm está a 0:
  El contenido de RA1 se envía como el primer operando (RD1) a la ALU.
  El contenido de RA2 se envía como el segundo operando (RD2) a la ALU.

4 - Nuevo PC (Contador de Programa):
  Se incrementa en 1 el valor del PC previo (contador de programa) para pasar a la siguiente instrucción.

5 - Señales de Control:
  La señal s_inc debe tener el valor 1 para activar el incremento del PC.
  Estas instrucciones deben afectar al flag de zero (ZF), que generalmente indica si el resultado de una operación es cero.
  Se deben generar señales de control específicas para escribir en el banco de registros y afectar al ZF según la operación.
______________________
**Instrucción de operación aritmética o lógica con constante inmediata:**

1 - Instrucción de operación aritmética o lógica con constante inmediata:
  Opcode de 4 bits (15-12): Un número de 4 bits que dice qué tipo de operación se va a realizar.
  Operando constante inmediata de 8 bits (11-4): Un número de 8 bits que se usará en la operación.

2 - Campo de registro de 4 bits:
  Indica qué registro se usará tanto como primer operando como destino de la operación.

3 - Operación (Reg ● Cte_Inm → Reg):
  La operación consiste en tomar un registro, multiplicarlo (o hacer una operación aritmética/lógica) con una constante inmediata y guardar el resultado en el mismo registro.

4 - Condición s_inm (bandera de constante inmediata):
  Cuando s_inm es igual a 1, significa que se está utilizando la constante inmediata como segundo operando en la operación.

5 - Operaciones Permitidas (sólo cuatro):
  LI: Carga la constante en el registro destino.
  ADI: Suma el contenido del registro especificado con la constante inmediata, y el resultado queda en el mismo registro.
  SBI: Resta el contenido del registro especificado con la constante inmediata, y el resultado queda en el mismo registro.
  NAI: Realiza la operación NAND (una operación lógica) entre el contenido del registro y la constante inmediata, y el resultado queda en el mismo registro.

6 - Acciones Adicionales:
  Se debe incrementar el Contador de Programa (PC).
  Permitir escrituras en el banco de registros.
  Permitir escrituras en la bandera de cero (ZF), que generalmente indica si el resultado de una operación es cero.
______________________
**Instrucciones de saltos (absolutos)**

1- Instrucciones de saltos (absolutos):
  Son instrucciones que indican al programa que "salte" a otra parte del código.

2- Tipos de Saltos:
  Incondicional (J): Siempre se ejecuta, sin importar qué.
  Condicional al flag de cero activado (JZ): Se ejecuta solo si la bandera de cero (ZF) está activada.
  Condicional al flag de cero desactivado (JNZ): Se ejecuta solo si la bandera de cero (ZF) está desactivada.

3 - Códigos de Operación (Opcode):
  Son como "etiquetas" que indican qué tipo de salto se debe hacer.
  Están representados por un número de 6 bits (15-10).

4 - Destino del Salto:
  Son los 10 bits restantes de la instrucción (9-0).
  Estos bits representan la dirección a la que se saltará, es decir, el nuevo valor del Contador de Programa (PC).

5 - Control de s_inc (señal para incrementar el PC):
  Se utiliza para llevar la dirección de salto al PC.
  En el salto incondicional (J), siempre se activa (s_inc) para cambiar el PC al destino.
  En los saltos condicionales (JZ y JNZ), se activa o desactiva según si la condición (zero o no zero) se cumple.

6 - Evaluación de Condiciones:
  En el salto condicional, se evalúa si la bandera de cero (ZF) está activada o desactivada.
  Si está activada y es un JZ, se activa s_inc para realizar el salto.
  Si está desactivada y es un JNZ, se activa s_inc para realizar el salto.