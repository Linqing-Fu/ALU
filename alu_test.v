////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 10ns / 1ns
 `define DATA_WIDTH 4
module alu_test
();

    reg [`DATA_WIDTH - 1:0] A;
	reg [`DATA_WIDTH - 1:0] B;
	reg [2:0] ALUop;
	wire Overflow;
	wire CarryOut;
	wire Zero;
	wire [`DATA_WIDTH - 1:0] Result;
	alu alu
	(
		.A(A),
		.B(B),
		.ALUop(ALUop),
	 	.Overflow(Overflow),
	 	.CarryOut(CarryOut),
	 	.Zero(Zero),
	 	.Result(Result)
	 );
	
   // integer alufile; 
	initial
	begin
	A=4'b0;
	B=4'b0;
	ALUop=3'b0;
	//#256 ALUop=3'b001;
	//#256 ALUop=3'b010;
	//#256 ALUop=3'b110;
    //#256 ALUop=3'b111;
	end
	
	always@(*)
	begin
        #0.5 if(ALUop==3'b010)
        begin
           if(Result==A+B)
               $fdisplay(alufile,"at time%d add:correct Result=%d A=%d B=%d\n",$time,Result,A,B);
           else
               $fdisplay(alufile,"at time%d add:error Result=%d A=%d B=%d\n",$time,Result,A,B);
     
                $fdisplay(alufile,"at time%d add: Overflow=%d A=%d B=%d",$time,Overflow,A,B);
                $fdisplay(alufile,"at time%d add: CarryOut=%d A=%d B=%d",$time,CarryOut,A,B);
          
        end
        else if(ALUop==3'b110)
        begin
           if(Result==A-B)
                $fdisplay(alufile,"at time%d sub:correct Result=%d A=%d B=%d",$time,Result,A,B);
           else
                $fdisplay(alufile,"at time%d sub:error Result=%d A=%d B=%d",$time,Result,A,B);
        
                $fdisplay(alufile,"at time%d sub:correct Overflow=%d A=%d B=%d",$time,Overflow,A,B);
               $fdisplay(alufile,"at time%d sub: CarryOut=%d A=%d B=%d",$time,CarryOut,A,B);
        end
        
         if(ALUop==3'b111)
                $fdisplay(alufile,"at time%d slt:correct Result=%d A=%d B=%d",$time,Result,A,B);
           
    end
	always #1 A=A+1;
	always #16 B=B+1;
	 
	

endmodule

