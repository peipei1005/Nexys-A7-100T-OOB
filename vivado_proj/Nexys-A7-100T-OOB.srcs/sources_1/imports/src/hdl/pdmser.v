//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// ?? ?? 29 2023 16:30:56
//
//      Input file      : 
//      Component name  : pdmser
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module PdmSer(clk_i, en_i, done_o, data_i, pwm_audio_o);
   parameter                C_NR_OF_BITS = 16;
   parameter                C_SYS_CLK_FREQ_MHZ = 75;
   parameter                C_PDM_FREQ_HZ = 2000000;
   input                    clk_i;
   input                    en_i;
   
   output                   done_o;
   input [C_NR_OF_BITS-1:0] data_i;
   
   inout                    pwm_audio_o;
   
   
   reg [7:0]                cnt_clk;
   wire                     clk_int;
   
   reg                      pdm_clk_rising;
   
   reg [(C_NR_OF_BITS-1):0] pdm_s_tmp;
   reg [4:0]                cnt_bits;
   
   reg                      en_int;
   reg                      done_int;
   
   
   always @(posedge clk_i)
   begin: SYNC
      
         en_int <= en_i;
   end
   
   
   always @(posedge clk_i)
   begin: CNT
      
      begin
         if (en_int == 1'b0)
            cnt_bits <= 0;
         else
            if (pdm_clk_rising == 1'b1)
            begin
               if (cnt_bits == (C_NR_OF_BITS - 1))
                  cnt_bits <= 0;
               else
                  cnt_bits <= cnt_bits + 1;
            end
      end
   end
   
   
   always @(posedge clk_i)
      
      begin
         if (pdm_clk_rising == 1'b1)
         begin
            if (cnt_bits == (C_NR_OF_BITS - 1))
               done_int <= 1'b1;
         end
         else
            done_int <= 1'b0;
      end
   
   assign done_o = done_int;
   
   
   always @(posedge clk_i)
   begin: SHFT_OUT
      
      begin
         if (pdm_clk_rising == 1'b1)
         begin
            if (cnt_bits == 0)
               pdm_s_tmp <= data_i;
            else
               pdm_s_tmp <= {pdm_s_tmp[C_NR_OF_BITS - 2:0], 1'b0};
         end
      end
   end
   
   assign pwm_audio_o = (pdm_s_tmp[C_NR_OF_BITS - 1] == 1'b0) ? 1'b0 : 
                        1'bZ;
   
   
   always @(posedge clk_i)
   begin: CLK_CNT
      
      begin
         if (en_int == 1'b0)
         begin
            cnt_clk <= 0;
            pdm_clk_rising <= 1'b0;
         end
         else
            if (cnt_clk == (((C_SYS_CLK_FREQ_MHZ * 1000000)/C_PDM_FREQ_HZ) - 1))
            begin
               cnt_clk <= 0;
               pdm_clk_rising <= 1'b1;
            end
            else
            begin
               cnt_clk <= cnt_clk + 1;
               pdm_clk_rising <= 1'b0;
            end
      end
   end
   
endmodule


