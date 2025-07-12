module Booth_Multiplier(
     input clk,  //ckt updates at each rising edge of the clk
     input start,   //a control signal to start multiplication
     input [7:0] multiplicand,   //first no. to be multiplied (M)
     input [7:0] multiplier,    // second no. to be multiplied (Q)
     output reg [15:0] product,   //(A and C combine)- final output of multiplication
     output reg done      //does (1)- when multiplication is complete
     );
     reg [7:0] A; //Accumulator (initially 0) stores intermediate result during add or sub
     reg [7:0] Q; //Holds the multiplier; bits shift right during each cycle
     reg Q_1;  //imaginary bit
     reg [7:0] M;  //stores Multiplicand
     reg [3:0] count;   //count how many steps are done (for 8 bit mul- 8 steps)
     reg running;  //flag that indicates multiplier is running
     
     always @(posedge clk) begin
           if (start && !running) begin
                 A <= 8'b0;
                 M <= multiplicand;
                 Q <= multiplier;
                 Q_1 <= 1'b0;
                 count <= 4'd8;
                 done <= 0;
                 running <= 1;
           end
           else if (running) begin
           //step 1
                  case ({Q[0], Q_1})
                     2'b01 : A <= A + M;
                     2'b10 : A <= A - M;
                     default : A <= A;
                   endcase
                  //step 2
                      {A, Q, Q_1} <= {A[7], A, Q, Q_1} >>1;
                   //step 3
                   count <= count - 1;
                   //step 4
                   if (count == 1) begin
                        product <= {A,Q};
                        done <= 1;
                        running <= 0;
                   end
           end
     end
endmodule
