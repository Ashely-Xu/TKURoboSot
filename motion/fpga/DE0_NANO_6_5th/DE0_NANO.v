// ============================================================================
// Copyright (c) 2011 by Terasic Technologies Inc. 
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
// Major Functions/Design Description:
//
//   Please refer to DE0_Nano_User_manual.pdf in DE0_Nano system CD.
//
// ============================================================================
// Revision History:
// ============================================================================
//   Ver.: |Author:   |Mod. Date:    |Changes Made:
//   V1.0  |EricChen  |02/01/2011    |
// ============================================================================

//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================
`default_nettype  none
module DE0_NANO(

	//////////// CLOCK //////////
	CLOCK_50,

	//////////// LED //////////
	LED,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

	//////////// SDRAM //////////
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_DQM,
	DRAM_RAS_N,
	DRAM_WE_N,

	//////////// EPCS //////////
	EPCS_ASDO,
	EPCS_DATA0,
	EPCS_DCLK,
	EPCS_NCSO,

	//////////// Accelerometer and EEPROM //////////
	G_SENSOR_CS_N,
	G_SENSOR_INT,
	I2C_SCLK,
	I2C_SDAT,

	//////////// ADC //////////
	ADC_CS_N,
	ADC_SADDR,
	ADC_SCLK,
	ADC_SDAT,

	//////////// 2x13 GPIO Header //////////
	GPIO_2,
	GPIO_2_IN,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	GPIO_0_D,
	GPIO_0_IN,

	//////////// GPIO_0, GPIO_1 connect to GPIO Default //////////
	GPIO_1_D,
	GPIO_1_IN,

);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;

//////////// LED //////////
output		     [7:0]		LED;

//////////// KEY //////////
input 		     [1:0]		KEY;

//////////// SW //////////
input 		     [3:0]		SW;

//////////// SDRAM //////////
output		    [12:0]		DRAM_ADDR;
output		     [1:0]		DRAM_BA;
output		          		DRAM_CAS_N;
output		          		DRAM_CKE;
output		          		DRAM_CLK;
output		          		DRAM_CS_N;
inout 		    [15:0]		DRAM_DQ;
output		     [1:0]		DRAM_DQM;
output		          		DRAM_RAS_N;
output		          		DRAM_WE_N;

//////////// EPCS //////////
output		          		EPCS_ASDO;
input 		          		EPCS_DATA0;
output		          		EPCS_DCLK;
output		          		EPCS_NCSO;

//////////// Accelerometer and EEPROM //////////
output		          		G_SENSOR_CS_N;
input 		          		G_SENSOR_INT;
output		          		I2C_SCLK;
inout 		          		I2C_SDAT;

//////////// ADC //////////
output		          		ADC_CS_N;
output		          		ADC_SADDR;
output		          		ADC_SCLK;
input 		          		ADC_SDAT;

//////////// 2x13 GPIO Header //////////
inout 		    [12:0]		GPIO_2;
input 		     [2:0]		GPIO_2_IN;

//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
inout 		    [33:0]		GPIO_0_D;
input 		     [1:0]		GPIO_0_IN;

//////////// GPIO_0, GPIO_1 connect to GPIO Default //////////
inout 		    [33:0]		GPIO_1_D;
input 		     [1:0]		GPIO_1_IN;

`include "param.h"
//=======================================================
//  REG/WIRE declarations
//=======================================================
wire 			oFLASH_RST_N;
wire			iReset_n;

wire  		iMotor1_PA;
wire  		iMotor1_PB;
wire  		oMotor1_PWM;
wire  		oMotor1_DIR;
wire  		iMotor2_PA;
wire  		iMotor2_PB;
wire 			oMotor2_PWM;
wire   		oMotor2_DIR;
wire  		iMotor3_PA;
wire  		iMotor3_PB;
wire 			oMotor3_PWM;
wire  		oMotor3_DIR;

wire			oTXD;
wire			iRXD;
wire 	[7:0]		wLED;
wire	[7:0]		iPower;
wire	[15:0]	iCMD_Motor1;
wire	[15:0]	iCMD_Motor2;
wire	[15:0]	iCMD_Motor3;
wire	[7:0]		iSignal;
wire	[7:0]		wPower;
wire	[15:0]	wCMD_Motor1;
wire	[15:0]	wCMD_Motor2;
wire	[15:0]	wCMD_Motor3;
wire	[7:0]		wSignal;
wire	[7:0]		wHoldBall_L;
wire	[7:0]		wHoldBall_R;
wire	[3:0]		wHoldBall_DIR;
wire				oWHoldBall_L;
wire				oWHoldBall_R;

wire	[31:0]	wFB_Motor1;
wire	[31:0]	wFB_Motor2;
wire	[31:0]	wFB_Motor3;


wire			wFB_FREQ;
wire			wFB_FREQ1;
wire			wFB_FREQ2;
wire			wFB_FREQ3;

wire			iRX;

wire			waylight;
wire			oKick;


//=======================================================
//  Structural coding
//=======================================================
assign iReset_n = KEY[0];


//assign LED[7:5] = iSignal[7:5];
//assign LED[6] = oKick;
//assign LED[7] = waylight;
//assign LED[7:4] = wHoldBall_DIR;
//assign LED[3] = wHoldBall_R;
//assign LED = wHoldBall_L;
//assign LED[7:0] =iPower[7:0];
/*for 6th*/
//assign GPIO_0_D[33] = oTXD;
//assign iRXD = GPIO_0_D[11];
//
//assign iMotor1_PA = GPIO_0_D[22];
//assign iMotor1_PB = GPIO_0_D[28];
//assign GPIO_0_D[20] = oMotor1_PWM;
//assign GPIO_0_D[16] = oMotor1_DIR;
//assign GPIO_0_D[18] = wSignal[7];
//assign GPIO_0_D[14] = wSignal[4];
//
//assign iMotor2_PA = GPIO_0_D[30];
//assign iMotor2_PB = GPIO_0_D[32];
//assign GPIO_0_D[21] = oMotor2_PWM;
//assign GPIO_0_D[25] = oMotor2_DIR;
//assign GPIO_0_D[23] = wSignal[6];
//assign GPIO_0_D[27] = wSignal[3];
//
//assign iMotor3_PA = GPIO_0_D[17];
//assign iMotor3_PB = GPIO_0_D[19];
//assign GPIO_0_D[1] = oMotor3_PWM;
//assign GPIO_0_D[5] = oMotor3_DIR;
//assign GPIO_0_D[3] = wSignal[5];
//assign GPIO_0_D[7] = wSignal[2];
//
//assign GPIO_0_D[29] = oKick;
/*for 7th*/

assign GPIO_1_D[16] = oKick;
assign GPIO_1_D[18] = waylight;
assign GPIO_0_D[0] = oWHoldBall_L;
assign GPIO_0_D[1] = oWHoldBall_R;
assign GPIO_0_D[5:2] = wHoldBall_DIR;

assign LED = wLED;
assign wLED[2] = oKick;
assign wLED[3] = waylight;
assign wLED[7:5] = iSignal[7:5];
//assign wLED[4] = oWHoldBall_L;
//assign wLED[5] = oWHoldBall_R;

assign GPIO_1_D[9] = oTXD;
assign iRXD = GPIO_1_D[7];

assign iMotor1_PA = GPIO_1_D[13];
assign iMotor1_PB = GPIO_1_D[11];
assign GPIO_1_D[5] = oMotor1_PWM;
assign GPIO_1_D[1] = oMotor1_DIR;
assign GPIO_1_D[3] = iSignal[7];
assign GPIO_1_D[0] = iSignal[4];

assign iMotor2_PA = GPIO_1_D[17];
assign iMotor2_PB = GPIO_1_D[15];
assign GPIO_1_D[29] = oMotor2_PWM;
assign GPIO_1_D[2] = oMotor2_DIR;
assign GPIO_1_D[31] = iSignal[6];
assign GPIO_1_D[4] = iSignal[3];

assign iMotor3_PA = GPIO_1_D[21];
assign iMotor3_PB = GPIO_1_D[19];
assign GPIO_1_D[8] = oMotor3_PWM;
assign GPIO_1_D[12] = oMotor3_DIR;
assign GPIO_1_D[10] = iSignal[5];
assign GPIO_1_D[14] = iSignal[2];

 sopc u0 (
	  .clk_clk                         (CLOCK_50),           //                      clk.clk
	  .reset_reset_n                   (iReset_n),           //                    reset.reset_n

	  .sdram_clk_clk                   (DRAM_CLK),           //                sdram_clk.clk
	  .sdram_wire_addr                 (DRAM_ADDR),          //               sdram_wire.addr
	  .sdram_wire_ba                   (DRAM_BA),            //                         .ba
	  .sdram_wire_cas_n                (DRAM_CAS_N),         //                         .cas_n
	  .sdram_wire_cke                  (DRAM_CKE),           //                         .cke
	  .sdram_wire_cs_n                 (DRAM_CS_N),          //                         .cs_n
	  .sdram_wire_dq                   (DRAM_DQ),            //                         .dq
	  .sdram_wire_dqm                  (DRAM_DQM),           //                         .dqm
	  .sdram_wire_ras_n                (DRAM_RAS_N),         //                         .ras_n
	  .sdram_wire_we_n                 (DRAM_WE_N),          //                         .we_n
	  .rs232_rxd                       (iRXD),               //                    rs232.rxd
	  .rs232_txd                       (oTXD),               //                         .txd

	  .motor1_export                   (iCMD_Motor1),        //                   motor1.export
	  .motor2_export                   (iCMD_Motor2),        //                   motor2.export	  
	  .motor3_export                   (iCMD_Motor3),        //                   motor3.export
	  .motor1_fb_export                (wFB_Motor1),         //                motor1_fb.export
	  .motor2_fb_export                (wFB_Motor2),         //                motor2_fb.export
	  .motor3_fb_export                (wFB_Motor3),         //                motor3_fb.export
	  .tx_export                       (wFB_FREQ),           //                       tx.export
	  //	  .altpll_phasedone_conduit_export (), // altpll_phasedone_conduit.export
//	  .altpll_locked_conduit_export    (),    //    altpll_locked_conduit.export
	  .altpll_areset_conduit_export    (0),    //    altpll_areset_conduit.export
	  .epcs_flash_controller_0_external_dclk  (EPCS_DCLK),   // epcs_flash_controller_0_external.dclk
     .epcs_flash_controller_0_external_sce   (EPCS_NCSO),   //                                 .sce
     .epcs_flash_controller_0_external_sdo   (EPCS_ASDO),   //                                 .sdo
     .epcs_flash_controller_0_external_data0 (EPCS_DATA0),  //                                 .data0
	  .led_export                             (wLED[1:0]),    //                              led.export
	  .sig_export                             (iSignal),     //                              sig.export
	  .shoot_export                           (iPower),      //                            shoot.export
     .rx_export                              (),          //                               rx.export
	  .hold_ball_l_export                     (wHoldBall_L),                     //                      hold_ball_l.export
	  .hold_ball_r_export                     (wHoldBall_R),                     //                      hold_ball_r.export
	  .hold_ball_dir_export                   (wHoldBall_DIR)                    //                    hold_ball_dir.export
 );

assign wFB_FREQ = wFB_FREQ1 & wFB_FREQ2 & wFB_FREQ3;


MotorController MotorA (
	.iCLK		(CLOCK_50),			// 50MHz, System Clock
	.iRst_n		(iReset_n),		// Reset
	.iCMD		(iCMD_Motor1),		// Command, SPD + DIR
	.iPA		(iMotor1_PA),		// Encoder Channel A
	.iPB		(iMotor1_PB),		// Encoder Channel B
	.oPWM_Pulse	(oMotor1_PWM),	// PWM of motor
	.oDIR		(oMotor1_DIR),		// Direction of motor
//	.oDIR_Now	(wDIR_Motor1),	// Direction of motor now
	.oFB		(wFB_Motor1),		// Feedback of motor
	.oFB_FREQ	(wFB_FREQ1)		// Feedback renew trigger
);
/*for 7th*/

/*for 6th*/

MotorController MotorB (
	.iCLK		(CLOCK_50),			// 50MHz, System Clock
	.iRst_n		(iReset_n),		// Reset
	.iCMD		(iCMD_Motor2),		// Command, SPD + DIR
	.iPA		(iMotor2_PA),		// Encoder Channel A
	.iPB		(iMotor2_PB),		// Encoder Channel B
	.oPWM_Pulse	(oMotor2_PWM),	// PWM of motor
	.oDIR		(oMotor2_DIR),		// Direction of motor
//	.oDIR_Now	(wDIR_Motor2),	// Direction of motor now
	.oFB		(wFB_Motor2),		// Feedback of motor
	.oFB_FREQ	(wFB_FREQ2)		// Feedback renew trigger
);

MotorController MotorC (
	.iCLK		(CLOCK_50),			// 50MHz, System Clock
	.iRst_n		(iReset_n),		// Reset
	.iCMD		(iCMD_Motor3),		// Command, SPD + DIR
	.iPA		(iMotor3_PA),		// Encoder Channel A
	.iPB		(iMotor3_PB),		// Encoder Channel B
	.oPWM_Pulse	(oMotor3_PWM),	// PWM of motor
	.oDIR		(oMotor3_DIR),		// Direction of motor
//	.oDIR_Now	(wDIR_Motor3),	// Direction of motor now
	.oFB		(wFB_Motor3),		// Feedback of motor
	.oFB_FREQ	(wFB_FREQ3)		// Feedback renew trigger
);
/* hold ball and shoot control */
holdball7(
.holdPower(wHoldBall_L),
.holdPower1(wHoldBall_R),
.reset(iReset_n),
.clk(CLOCK_50),
.oPower(oWHoldBall_L),
.oPower1(oWHoldBall_R)
);

ShootControl(
	.iClk(CLOCK_50),
	.iRst_n(iReset_n),
	.iPower(iPower),
	.oPower(oKick)	
);


// Combine feedbacks to package

/*
//RS-232 Module
UART_if RS_232 (
	.iClk		(CLOCK_50),		// Clock Input
	.iRst_n		(iReset_n),	// Reset Input

	// RS232 control signal
	.iTX_send	(wTx_send),
	.iTX_data	(wTx_data),
	.oTX_busy	(wTx_busy),
	.oRX_drdy	(wRx_ready),
	.oRX_data	(wRx_data),
	
	// RS232 interface
	.oRs232_tx	(oTXD),
	.iRs232_rx	(iRXD)
	//.oRs232_tx	(wRXD),
	//.iRs232_rx	(wTXD)
);

//assign LED = SW[0] ? wTx_data : wRx_data;
//assign GPIO_0_D[] = oLight;


	
// Sperate packet to command
Serial2CMD #(
	.MOTOR_STREAM_SIZE(RX_MOTOR_SIZE*8)
)(
	.iCLK		(CLOCK_50),				// 50MHz, System Clock
	.iRst_n		(iReset_n),			// Reset
	.iData		(wRx_data),
	.iRx_ready	(wRx_ready),
	.oCMD_Motor1(wCMD_Motor1),		// Command of motor1
	.oCMD_Motor2(wCMD_Motor2),		// Command of motor2
	.oCMD_Motor3(wCMD_Motor3),		// Command of motor3
	.oSignal	(wSignal),			// Command of Enable & Stop signal
	.oPower		(wPower),				// shoot a ball at the goal
	.oRx_done	(wRx_done)
);

// Combine command to serial
CMD2Serial (
	.iCLK			(CLOCK_50),				// 50MHz, System Clock	
	.iRst_n			(iReset_n),			// Reset
	.iSend_Ready	(wFB_CNT_FREQ), 	// Feedback frequency
	.iTx_busy		(wTx_busy),
	.iFB_Motor1		(wFB_Motor1),	// Feedback of motor1
	.iFB_Motor2		(wFB_Motor2),	// Feedback of motor2
	.iFB_Motor3		(wFB_Motor3),	// Feedback of motor3
//	.iFB_Motor4		(wFB_CNT_Motor4),	// Feedback of motor4
	.iDIR_Motor1	(wDIR_Motor1),		// Direction of motor1
	.iDIR_Motor2	(wDIR_Motor2),		// Direction of motor2
	.iDIR_Motor3	(wDIR_Motor3),		// Direction of motor3
//	.iDIR_Motor4	(wDIR_Motor4),		// Direction of motor4
	.oTx_send		(wTx_send), //Send trigger
	.oTx_data		(wTx_data)  //Send data
);
*/
endmodule
