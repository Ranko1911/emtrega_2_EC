// Testbench para sumador con predicción de acarreo
`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulación y el del paso de simulacion
module microc_tb;

//declaracion de señales
wire[5:0] test_Opcode;
wire test_zero
reg test_clk, test_reset, test_s_inc, test_s_inm, test_we, test_wez;
reg[2:0] test_ALUOp;

//instancia del modulo a testear
microc microc_1(test_Opcode, test_zero, test_clk, test_reset, test_s_inc, test_s_imn, test_we, test_wez, test_ALUOp);

initial
  always @(test_clk)
  begin // Genera un reloj 
      clk = 1;
      # 20;
      clk = 0;
      # 20;
  end

initial
  begin
    $monitor("tiempo=%0d reset=%b s_inc=%b s_inm=%b we=%b wez=%b =%b Opcode=%b zero=%b", $time, test_reset, test_s_inc, test_s_inm, test_we, test_wez, test_Opcode, test_zero);
    $dumpfile("microc_tb.vcd");
    $dumpvars;
    
    // Inicializa las señales
    test_reset = 1;
    test_s_inc = 0;
    test_s_inm = 0;
    test_we = 0;
    test_ALUOp = 3'b000;
    #20 test_reset = 0;

    // Test de operaciones
    // LI #1, R1
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1
    test_Opcode = 4'b0000; // OpCode para LI

    #40; // LI #3, R4
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1;
    test_Opcode = 4'b0000; // OpCode para LI

    #40; // MOV R4, R5
    test_s_inc = 1;
    test_s_inm = 1;
    test_we = 1;
    test_wez = 1;
    test_Opcode = 4'b1010; // OpCode para MOV

    #40; // CC: ADD R1, R4, R7
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1;
    test_Opcode = 4'b0111; // OpCode para ADD

    #40; // JNZ COSAS
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 0; // Podría ser 1 si se debe escribir la dirección en el registro
    test_wez = 0;
    test_Opcode = 4'b0110; // OpCode para JNZ

    #40; // SUB R7, R1, R7
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1;
    test_Opcode = 4'b1000; // OpCode para SUB

    #40; // COSAS: ADD R3, R4, R8
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 1;
    test_wez = 1;
    test_Opcode = 4'b0111; // OpCode para ADD

    #40; // J CC
    test_s_inc = 1;
    test_s_inm = 0;
    test_we = 0; // Podría ser 1 si se debe escribir la dirección en el registro
    test_wez = 0;
    test_Opcode = 4'b0100; // OpCode para J

      $finish;
  end

endmodule