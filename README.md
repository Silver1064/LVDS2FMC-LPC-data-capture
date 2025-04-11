# LVDS2FMC-LPC-data-capture
LVDS to FMC-LPC synchronization
#Design file name	          File type	  Description
top_adc_data_capturing	    VHDL	      Wrapper of adc_data_capturing. The buffer to receive LVDS signal is utilized here. <ins> </ins>
adc_data_capturing	        VHDL	      Top level module for the FPGA, including MMCM, bit_clock_synchronization, frame_alignment and data_receive.
bit_clock_synchronyzation	  VHDL	      A function implement “new clock phase shift alignment”
phase_shift_alignment	      VHDL	      A submodule of bit_clock_synchronyzation block, which controls phase shift alignment
frame_alignment	            VHDL	      A function implement “new frame alignment”
frame_arrange	              VHDL	      A submodule of frame_alignment block, which controls bit slip submodule of all the ISERDES
data_receive	              VHDL	      A function implement “data reception”
adc_data_capture_constain	  xdc	        File constraint to specify clock, timing, direction and standard for pinout
readme	                    text	      Instructions on how to rebuild the project
