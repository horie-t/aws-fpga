module cl_hello_world_core (input logic         clk_main_a0,
			    input logic 	rst_main_n_sync,
			    input logic [31:0] 	wr_addr,
			    input logic [31:0] 	wdata,
			    input logic 	wready,
			    output logic [31:0] hello_world_q_byte_swapped,
			    output logic [15:0] cl_sh_status_vled,
			    output logic [15:0] vled_q
			    )
  `include "cl_common_defines.vh"      // CL Defines for all examples

  logic [31:0] hello_world_q;
  logic [15:0] sh_cl_status_vdip_q;
  logic [15:0] sh_cl_status_vdip_q2;
  logic [15:0] pre_cl_sh_status_vled;
  
  //-------------------------------------------------
  // Hello World Register
  //-------------------------------------------------
  // When read it, returns the byte-flipped value.

  always_ff @(posedge clk_main_a0)
    if (!rst_main_n_sync) begin                    // Reset
       hello_world_q[31:0] <= 32'h0000_0000;
    end
    else if (wready & (wr_addr == `HELLO_WORLD_REG_ADDR)) begin  
       hello_world_q[31:0] <= wdata[31:0];
    end
    else begin                                // Hold Value
       hello_world_q[31:0] <= hello_world_q[31:0];
    end

   assign hello_world_q_byte_swapped[31:0] = {hello_world_q[7:0],   hello_world_q[15:8],
                                              hello_world_q[23:16], hello_world_q[31:24]};

   //-------------------------------------------------
   // Virtual LED Register
   //-------------------------------------------------
   // Flop/synchronize interface signals
   always_ff @(posedge clk_main_a0)
     if (!rst_main_n_sync) begin                    // Reset
	sh_cl_status_vdip_q[15:0]  <= 16'h0000;
	sh_cl_status_vdip_q2[15:0] <= 16'h0000;
	cl_sh_status_vled[15:0]    <= 16'h0000;
     end
     else begin
	sh_cl_status_vdip_q[15:0]  <= sh_cl_status_vdip[15:0];
	sh_cl_status_vdip_q2[15:0] <= sh_cl_status_vdip_q[15:0];
	cl_sh_status_vled[15:0]    <= pre_cl_sh_status_vled[15:0];
     end

   // The register contains 16 read-only bits corresponding to 16 LED's.
   // For this example, the virtual LED register shadows the hello_world
   // register.
   // The same LED values can be read from the CL to Shell interface
   // by using the linux FPGA tool: $ fpga-get-virtual-led -S 0

   always_ff @(posedge clk_main_a0)
     if (!rst_main_n_sync) begin                    // Reset
	vled_q[15:0] <= 16'h0000;
     end
     else begin
	vled_q[15:0] <= hello_world_q[15:0];
     end

   // The Virtual LED outputs will be masked with the Virtual DIP switches.
   assign pre_cl_sh_status_vled[15:0] = vled_q[15:0] & sh_cl_status_vdip_q2[15:0];


endmodule // cl_hello_world_core
