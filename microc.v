module microc(output wire [5:0] Opcode, output wire zero, input wire clk, reset, s_inc, s_inm, we, wez, input wire [2:0] ALUOp);
//Microcontrolador sin memoria de datos de un solo ciclo
    Opcode = Datum[15:10];

//mux_1
    reg [9:0] s_mp; //cable que sale de mux_1 y entra a PC
    reg [9:0] dir_salto = Datum[9:0];
    reg [9:0] s_sm; //cable que sale de sum y entra a mux_1
    mux2 #(10) mux_1(s_mp, dir_salto, s_sm, s_inc);

//sumador
    reg [9:0] s_pc;  //cable que sale de PC
    sum sum_1(s_sm, 10'b0000000001, s_pc);

//memoria de programa
    reg [15:0] Datum; //salida de memoria de programa
    memprog memprog(Datum, clk, s_pc);

//mux_2
    reg [3:0] s_mb; //salida de mux_2 a banco de registros
    reg [3:0] RA1 = Datum[11:8]; //Primera entrada al mux_2, usando los bits del 11 al 8 del reg Datum
    reg [3:0] WA3 = Datum[3:0]; //Segunda entrada al mux_2, usando los bits del 3 al 0 del reg Datum
    mux2 #(4) mux_2(s_mb, RA1, WA3, s_inm);

//Banco de registros
    reg [3:0] RA2 = Datum[7:4];
    reg [7:0] WD3;
    reg [7:0] RD1;
    reg [7:0] RD2;
    regfile regfile_1(RD1, RD2, clk, we, s_mb, RA2, WA3, WD3);

//mux_3
    reg [7:0] s_ma; //salida del mux_3 al alu
    reg [7:0] Inm = Datum[11:4];
    mux2 #(8) mux_3(s_ma, RD2, Inm, s_inm);

//ALU
    reg zALU;
    alu alu_1(WD3, zALU, RD1, s_ma, ALUOp);

//flipflop
    ffd ffz(clk, reset, zALU, wez, zero);
    
endmodule