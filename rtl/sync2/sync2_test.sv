`timescale 1ns/1ps

module tb_sync2 #(
	parameter WIDTH_P = 8
);
	logic [0:0] clk = 1'b0;
	logic [0:0] rstn = 1'b0;
	logic [WIDTH_P-1:0] sync_i = '0;
	logic [WIDTH_P-1:0] sync_o;

	sync2 #(
		.WIDTH_P(WIDTH_P)
	) dut_inst (
		.clk_sync_i(clk),
		.rstn_i(rstn),
		.sync_i(sync_i),
		.sync_o(sync_o)
	);

	always #5 clk = ~clk;

	a_latency: assert property (@(posedge clk)
		($past(rstn) && $past(rstn, 2)) |-> sync_o == $past(sync_i, 2))
	else $fatal(1, "latency: sync_o=%0h expected %0h", sync_o, $past(sync_i, 2));

	a_reset: assert property (@(posedge clk)
		(!$past(rstn) || !$past(rstn, 2)) |-> sync_o == '0)
	else $fatal(1, "reset: sync_o=%0h not cleared", sync_o);

	initial begin
		repeat (2) @(negedge clk);
		rstn = 1'b1;
		sync_i = '1;
		repeat (3) @(negedge clk);

		rstn = 1'b0;
		#1;
		if (sync_o != '1) $fatal(1, "reset changed sync_o before clock edge: %0h", sync_o);

		for (int i = 0; i < 1000; i++) begin
			@(negedge clk);
			sync_i = WIDTH_P'($urandom);
			rstn = !($urandom_range(0, 49) == 0);
		end

		$display("tb_sync2 PASSED");
		$finish;
	end
endmodule
