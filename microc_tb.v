// Testbench para sumador con predicción de acarreo
`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulación y el del paso de simulacion
module microc_tb;

//declaracion de señales
wire[5:0] test_Opcode;
wire test_zero;
reg test_clk;
reg test_reset;
reg test_s_inc;
reg test_s_inm;
reg test_we;
reg test_wez;
reg[2:0] test_ALUOp;

//instancia del modulo a testear
microc microc_1(test_Opcode, test_zero, test_clk, test_reset, test_s_inc, test_s_inm, test_we, test_wez, test_ALUOp);

  always
  #20 test_clk = ~test_clk;

initial
  begin
    test_clk = 1;
    test_reset = 1;
    # 10;
    test_reset = 0;
  end

initial
  begin
    $dumpfile("microc_tb.vcd");
    $dumpvars;
    # 20;
    // Test de operaciones
    // LI #3, R1
    test_s_inc = 1; // Señal de incremento desactivada
    test_s_inm = 1; // Señal de inmediato activada
    test_we = 1;  // permiso de escritura
    test_wez = 1; // permiso de escritura en el registro zero
    test_ALUOp = 3'b000; //operacion del alu =

    #40; // MOV R1, R2
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1;
    test_ALUOp = 3'b000;

    #40; // SBI #2, R1
    test_s_inc = 1;
    test_s_inm = 1;
    test_we = 1;
    test_wez = 1;
    test_ALUOp = 3'b011; // OpCode para SBI

    #40; // ADI #4, R3
    test_s_inc = 1;
    test_s_inm = 1;
    test_we = 1;
    test_wez = 1;
    test_ALUOp = 3'b010; // OpCode para ADI

    #40; // CHECK: SUB R3 R1 R3
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1; // Podría ser 1 si se debe escribir la dirección en el registro
    test_wez = 1;
    test_ALUOp = 3'b011; // OpCode para SUB

    #40; // JZ CLOSE
    test_s_inc = ~test_zero;
    test_s_inm = 0;
    test_we = 0;
    test_wez = 0;
    test_ALUOp = 3'b000; // OpCode para JZ, no se si está bien

    #40; // SUB R2 R1 R2
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1;
    test_ALUOp = 3'b011; // OpCode para SUB

    #40; // J CHECK
    test_s_inc = 0; //siempre salta a CHECK
    test_s_inm = 0;
    test_we = 0; // Podría ser 1 si se debe escribir la dirección en el registro
    test_wez = 0;
    test_ALUOp = 3'b010; // OpCode para J, nose sie sta bien

/////
    #40; // CHECK: SUB R3 R1 R3
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1; // Podría ser 1 si se debe escribir la dirección en el registro
    test_wez = 1;
    test_ALUOp = 3'b011; // OpCode para SUB

    #40; // JZ CLOSE
    test_s_inc = ~test_zero;
    test_s_inm = 0;
    test_we = 0;
    test_wez = 0;
    test_ALUOp = 3'b000; // OpCode para JZ, no se si está bien

    #40; // SUB R2 R1 R2
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1;
    test_ALUOp = 3'b011; // OpCode para SUB

    #40; // J CHECK
    test_s_inc = 0; //siempre salta a CHECK
    test_s_inm = 0;
    test_we = 0; // Podría ser 1 si se debe escribir la dirección en el registro
    test_wez = 0;
    test_ALUOp = 3'b010; // OpCode para J, nose sie sta bien
/////
    #40; // CHECK: SUB R3 R1 R3
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1; // Podría ser 1 si se debe escribir la dirección en el registro
    test_wez = 1;
    test_ALUOp = 3'b011; // OpCode para SUB

    #40; // JZ CLOSE
    test_s_inc = ~test_zero;
    test_s_inm = 0;
    test_we = 0;
    test_wez = 0;
    test_ALUOp = 3'b000; // OpCode para JZ, no se si está bien

    #40; // SUB R2 R1 R2
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1;
    test_ALUOp = 3'b011; // OpCode para SUB

    #40; // J CHECK
    test_s_inc = 0; //siempre salta a CHECK
    test_s_inm = 0;
    test_we = 0; // Podría ser 1 si se debe escribir la dirección en el registro
    test_wez = 0;
    test_ALUOp = 3'b010; // OpCode para J, nose sie sta bien
/////
    #40; // CHECK: SUB R3 R1 R3
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1; // Podría ser 1 si se debe escribir la dirección en el registro
    test_wez = 1;
    test_ALUOp = 3'b011; // OpCode para SUB

    #40; // JZ CLOSE
    test_s_inc = ~test_zero;
    test_s_inm = 0;
    test_we = 0;
    test_wez = 0;
    test_ALUOp = 3'b000; // OpCode para JZ, no se si está bien
////

    #40; // CLOSE: ADD R3 R3 R4
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1;
    test_ALUOp = 3'b010; // OpCode para ADD

    #40; // FINISH: END: J END
    test_s_inc = 0;
    test_s_inm = 0;
    test_we = 0; 
    test_wez = 0;
    test_ALUOp = 3'b010; // OpCode para J

    #40;
      $finish;
  end

endmodule