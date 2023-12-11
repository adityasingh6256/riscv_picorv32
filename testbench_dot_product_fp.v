`timescale 1 ns / 1 ps

module testbench;
	
	reg clk, resetn;
	wire trap;

	wire        mem_valid;
	wire        mem_instr;
	reg             mem_ready;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
  wire [ 3:0]  mem_wstrb;
	reg      [31:0] mem_rdata;
	
	// Pico Co-Processor Interface (PCPI)
	wire        pcpi_valid;
	wire [31:0] pcpi_insn;
	wire     [31:0] pcpi_rs1;
	wire     [31:0] pcpi_rs2;
	reg             pcpi_wr;
	reg      [31:0] pcpi_rd;
	reg             pcpi_wait;
	reg             pcpi_ready;
	
	// IRQ interface
	reg  [31:0] irq;
	wire [31:0] eoi;

	
	// Trace Interface
	wire        trace_valid;
	wire [35:0] trace_data;

	picorv32 dut (
		.clk      (clk   ),
		.resetn   (resetn),
		.trap     (trap  ),

		.mem_valid(mem_valid),
		.mem_addr (mem_addr ),
		.mem_wdata(mem_wdata),
		.mem_wstrb(mem_wstrb),
		.mem_instr(mem_instr),
		.mem_ready(mem_ready),
		.mem_rdata(mem_rdata),

		.pcpi_valid(pcpi_valid),
		.pcpi_insn (pcpi_insn ),
		.pcpi_rs1  (pcpi_rs1  ),
		.pcpi_rs2  (pcpi_rs2  ),
		.pcpi_wr   (pcpi_wr   ),
		.pcpi_rd   (pcpi_rd   ),
		.pcpi_wait (pcpi_wait ),
		.pcpi_ready(pcpi_ready),

		.irq(irq),
		.eoi(eoi),

		.trace_valid(trace_valid),
		.trace_data (trace_data)
	);
	
	initial begin
		clk <= 1;
		resetn <= 0;
		#40 resetn <= 1;
		mem_rdata <= 32'b0000001_0000000000_000_00000_0110011;
		mem_ready <= 1;
		pcpi_ready <= 0;
		pcpi_wr <= 0;
		pcpi_wait <= 0;
		pcpi_rd <= 32'b0;
		#100;
		
		dut.cpuregs.rdata1 <= 32'h42350000;	//45.25
		dut.cpuregs.rdata2 <= 32'h40480000;	//3.125
		// output = (45.25 * 45.25) + (3.125 * 3.125) = 2057.328125 = 36'h045009540
     #1000; $display("inputs...(a)pcpi_rs1= 0x%08x: (b)pcpi_rs2= 0x%08x :output.. a^2+b^2= trace_data= 0x%08x ", pcpi_rs1, pcpi_rs2,trace_data); 
		#1000;
		dut.cpuregs.rdata1 <= 32'hC1FC0000;	//-31.5
		dut.cpuregs.rdata2 <= 32'hC0FC0000;	//-7.875
		// output = (-31.5 * -31.5) + (-7.875 * -7.875) = 1054.265625 = 36'h041F22000
     #1000; $display("inputs...(a)pcpi_rs1= 0x%08x: (b)pcpi_rs2= 0x%08x :output.. a^2+b^2= trace_data= 0x%08x ", pcpi_rs1, pcpi_rs2,trace_data); 
		#1000;
		dut.cpuregs.rdata1 <= 32'hC0480000;	//-3.125
		dut.cpuregs.rdata2 <= 32'h40E80000;	//7.25
		//output = (-3.125 * -3.125) + (7.25 * 7.25) = 62.328125 = 36'h042795000
     #1000; $display("inputs...(a)pcpi_rs1= 0x%08x: (b)pcpi_rs2= 0x%08x :output.. a^2+b^2= trace_data= 0x%08x ", pcpi_rs1, pcpi_rs2,trace_data); 
	end
	
	always #20 clk = ~clk;

	initial begin
			$dumpfile("testbench.vcd");
			$dumpvars(0, testbench);
		
		#20000 $finish;
	end
endmodule
