// Define la escala de tiempo de la simulación: <time_unit> / <time_precision>
`timescale 10 ns / 100 ps
`include  "SPI.v"
// Nombre del testbench
module moudule_tb();

		//señales que se capturan del modulo bajo pruebas (DUT)
    wire    miso;

    // Señales con las que se estimula el modulo bajo pruebas
    reg     clk = 0;
    reg     rst = 0;      
    reg     cs = 1;
    reg     mosi = 0;
    reg     [7:0] buffer_m = 8'b11111111;
    reg      m7 = 0;
    reg     f = 0;      

    // Tiempo de simulación: 10000 * 10 ns = 100 us
    localparam DURATION = 100;
    
    // Simulación del clock: 1 / ((2 * 1) * 10 ns) = 50 MHz
    always begin
        
        // Delay de 1 <time units>
        #1
        
        // Toggle clock
        clk = ~clk;
    end

		// Gener una pulso breve para initializar internamente el modulo de pruebas
    initial begin
        #10
        rst = 1'b1;
        #1
        rst = 1'b0;
    end
    
    SPI slv(cs, clk, mosi, miso);

    // Controla lo relacionado a la simulación
    initial begin

        $dumpfile("tb.vcd");
        $dumpvars(0, moudule_tb);
        
        // Espera a que el tiempo de simulación se cumpla
        #(DURATION)
        
        // Mesaje indicando que la simulación ha terminado
        $display("Finished!");
        $finish;
    end

	initial begin
		
		//para analizar las salidas o generar otros estimulos.
    //Inicio de definición del modulo maestro
    
    #15
    cs = 1;
    m7 <= buffer_m[7];
    buffer_m <= buffer_m << 1'b1;
    buffer_m[0] <= miso;
    mosi <= m7;
    #1
    cs=0;
    #1
    cs = 1;
    m7 <= buffer_m[7];
    buffer_m <= buffer_m << 1'b1;
    buffer_m[0] <= miso;
    mosi <= m7;
    #1
    cs=0;
    #1
    cs = 1;
    m7 <= buffer_m[7];
    buffer_m <= buffer_m << 1'b1;
    buffer_m[0] <= miso;
    mosi <= m7;
    #1
    cs=0;
    
    
    
   

	end


endmodule