/*
 * Copyright (c) 2017 Adeas B.V. All rights reserved.
 *
 * This file contains the AXI register space of the AudioClockRecoveryUnit.
 *
 * MODIFICATION HISTORY:
 *
 * Ver   Who Date         Changes
 * ----- --- ----------   -----------------------------------------------
 * X.XX  XX  YYYY/MM/DD
 * 1.00  RHe 2017/03/01   First release
 *
 *****************************************************************************/
 
`timescale 1ns / 1ps

module audio_clock_recovery_v1_0_axi
#(
  parameter pVERSION_NR = 32'hDEADBEEF
)
(
  // AXI4-Lite bus (cpu control)
  input             iAxiClk,
  input             iAxiResetn,
  // - Write address
  input             iAxi_AWValid,
  output reg        oAxi_AWReady,
  input      [ 7:0] iAxi_AWAddr,
  // - Write data
  input             iAxi_WValid,
  output reg        oAxi_WReady,
  input      [31:0] iAxi_WData,
  // - Write response
  output reg        oAxi_BValid,
  input             iAxi_BReady,
  output reg [ 1:0] oAxi_BResp,
  // - Read address   
  input             iAxi_ARValid,
  output reg        oAxi_ARReady,
  input      [ 7:0] iAxi_ARAddr,
  // - Read data/response
  output reg        oAxi_RValid,
  input             iAxi_RReady, 
  output reg [31:0] oAxi_RData,
  output reg [ 1:0] oAxi_RResp,
  
  output            oIRQ,
  
  input      [31:0] iCoreConfig,
  output            oEnable,
  output      [2:0] oMode,
  
  output     [15:0] oFifoSetPoint,
  output     [15:0] oMaxSumDelta,
  output     [15:0] oDelta,
  
  output     [ 7:0] oFifoAvgNumSamples,
  output     [15:0] oSampleGenDiv,
  
  output     [23:0] oUsrNVal,
  output     [23:0] oUsrCTSVal,
  
  output      [3:0] oPreMult,
  output      [7:0] oOutputDiv
  
);

// AXI Bus responses
localparam cAXI4_RESP_OKAY   = 2'b00; // Okay
localparam cAXI4_RESP_SLVERR = 2'b10; // Slave error

// Register map addresses
localparam cADDR_VER       = 'h00; // Version register
localparam cADDR_CFG       = 'h04; // Configuration register
localparam cADDR_CTRL      = 'h08; // Control register

localparam cADDR_IRQ_CTRL  = 'h10; // Interrupt Control
localparam cADDR_IRQ_STS   = 'h14; // Interrupt Status

localparam cADDR_MODE      = 'h20; // Operating Mode

localparam cADDR_FIFOSETPOINT = 'h30; // FIFO Set point value
localparam cADDR_MAXSUMDELTA  = 'h34; // Maximum delta sum value
localparam cADDR_DELTA        = 'h38; // Delta value
localparam cADDR_SAMPLECTRL   = 'h3C; // Sample Generator Control
localparam cADDR_FIFOAVGCTRL  = 'h40; // Fifo Sample Average Control

localparam cADDR_USR_N        = 'h50; // User Selected N value 
localparam cADDR_USR_CTS      = 'h54; // User Selected CTS value

localparam cADDR_PREMULT   = 'h60; // Pre-multiplier
localparam cADDR_OUTDIV    = 'h70; // Output Divider


// IRQ signals
localparam cIRQ_GLOBAL       = 31;
localparam cIRQ_AES_BLKCMPLT = 0;

logic        rIrq;
logic [31:0] rIrqEnables;
logic [30:0] rIrqStatus;
logic [31:0] rClearIrqs;

logic [31:0] rVersionNr;
logic        rEnable;
logic        rEnableLoopCtrl;
logic  [2:0] rMode; 

logic [15:0] rFifoSetPoint;
logic [15:0] rMaxSumDelta;
logic [15:0] rDelta;

logic [ 7:0] rFifoAvgNumSamples;
logic [15:0] rSampleGenDiv;

logic [23:0] rUsr_NVal;
logic [23:0] rUsr_CTSVal;

logic  [7:0] rOutputDiv;
logic  [3:0] rPreMult;

// Input Capture
always_ff @(posedge iAxiClk)
begin
  if (!iAxiResetn) begin
  end
  else begin
  end
end

// IRQ Generation
always_ff @(posedge iAxiClk)
begin

  foreach (rIrqStatus[i]) begin
    if (rIrqEnables[cIRQ_GLOBAL]) begin
      if (rIrqStatus[i] & rIrqEnables[i]) begin
        rIrq   <= 1'b1;
      end
    end
  end
  
  if (rClearIrqs[cIRQ_GLOBAL]) begin
    rIrq       <= 1'b0;
  end
  
  if (!iAxiResetn) begin
    rIrqStatus <= 'h0;
    rIrq       <= 1'b0;
  end
end


////////////////////////////////////////////////////////
// Write channel

typedef enum { sWriteReset,
               sWriteAddr,
               sWriteData,
               sWriteResp
             } tStmAXI4L_Write;
             
tStmAXI4L_Write stmWrite;

logic [7:0] rWriteAddr;

// Statemachine for taking care of the write signals
always_ff @(posedge iAxiClk)
begin
  if (!iAxiResetn)
  begin
    oAxi_AWReady        <= 1'b0;
    oAxi_WReady         <= 1'b0;
    oAxi_BValid         <= 1'b0;
    rWriteAddr          <=  'h0;
    stmWrite            <= sWriteReset;
  end
  else
  begin
    case (stmWrite) 
      sWriteReset :
      begin
        oAxi_AWReady    <= 1'b1;
        oAxi_WReady     <= 1'b0;
        oAxi_BValid     <= 1'b0;
        stmWrite        <= sWriteAddr;
      end
      
      sWriteAddr :
      begin
        oAxi_AWReady    <= 1'b1;
        if (iAxi_AWValid)
        begin
          oAxi_AWReady  <= 1'b0;
          oAxi_WReady   <= 1'b1;
          rWriteAddr    <= iAxi_AWAddr;
          stmWrite      <= sWriteData;
        end
      end
      
      sWriteData :
      begin
        oAxi_WReady     <= 1'b1;
        
        if (iAxi_WValid)
        begin
          oAxi_WReady   <= 1'b0;
          oAxi_BValid   <= 1'b1;
          stmWrite      <= sWriteResp;
        end
      end
      
      sWriteResp :
      begin
        oAxi_BValid     <= 1'b1;
        if (iAxi_BReady)
        begin
          oAxi_BValid   <= 1'b0;
          stmWrite      <= sWriteReset;
        end
      end 
      
      default :
        stmWrite        <= sWriteReset;
    endcase
  end
end

// Write address decoder
always_ff @(posedge iAxiClk)
begin
  if (!iAxiResetn)
  begin
    oAxi_BResp        <= cAXI4_RESP_OKAY;
    rEnable           <= 1'b0;
    
    rFifoSetPoint     <= 'h0;
    rMaxSumDelta      <= 'h0;
    rDelta            <= 'h0;
    
    rFifoAvgNumSamples <= 'h0;
    rSampleGenDiv      <= 'h0;
    
    rUsr_NVal         <= 'h0;
    rUsr_CTSVal       <= 'h0;
    
    rPreMult          <= 'h0;
    rOutputDiv        <= 'h1;
    
    rVersionNr        <= pVERSION_NR;
  end
  else
  begin
    // Defaults
    rClearIrqs        <= 'h0;
    
    if (oAxi_WReady && iAxi_WValid)
    begin
      oAxi_BResp      <= cAXI4_RESP_OKAY;
      
      case (rWriteAddr)
        cADDR_VER :
        begin
        end
        
        cADDR_CTRL :
        begin
          rEnable     <= iAxi_WData[0];
        end
        
        cADDR_IRQ_CTRL :
        begin
          rIrqEnables <= iAxi_WData;
        end
        
        cADDR_IRQ_STS :
        begin
          rClearIrqs  <= iAxi_WData;
        end
        
        cADDR_MODE :
        begin
          rMode       <= iAxi_WData[2:0];
        end
        
        cADDR_FIFOSETPOINT :
        begin
          rFifoSetPoint <= iAxi_WData[15:0];
        end
        
        cADDR_MAXSUMDELTA :
        begin
          rMaxSumDelta  <= iAxi_WData[15:0];
        end
        
        cADDR_DELTA :
        begin
          rDelta        <= iAxi_WData[15:0];
        end
        
        cADDR_FIFOAVGCTRL :
        begin
          rFifoAvgNumSamples <= iAxi_WData[7:0];
        end
        
        cADDR_SAMPLECTRL :
        begin
          rSampleGenDiv <= iAxi_WData[15:0];
        end
        
        cADDR_USR_N :
        begin
          rUsr_NVal   <= iAxi_WData[23:0];
        end
        
        cADDR_USR_CTS :
        begin
          rUsr_CTSVal <= iAxi_WData[23:0];
        end
        
        cADDR_PREMULT :
        begin
          rPreMult    <= iAxi_WData[3:0];
        end
        
        cADDR_OUTDIV :
        begin
          rOutputDiv  <= iAxi_WData[7:0];
        end
        
        default :
          oAxi_BResp  <= cAXI4_RESP_SLVERR;
      endcase
    end
  end
end

////////////////////////////////////////////////////////
// Read channel

typedef enum { sReadReset,
               sReadAddr,
               sDecodeAddr,
               sReadData
             } tStmAXI4L_Read;
             
tStmAXI4L_Read stmRead;

logic        ReadAddrNOK;
logic [ 7:0] rReadAddr;
logic [31:0] nReadData;

// Statemachine for taking care of the read signals
always_ff @(posedge iAxiClk)
begin
  if (!iAxiResetn)
  begin
    oAxi_ARReady        <= 1'b0;    
    oAxi_RResp          <= cAXI4_RESP_OKAY;
    oAxi_RValid         <= 1'b0;
    oAxi_RData          <=  'h0;
    rReadAddr           <=  'h0;
    stmRead             <= sReadReset;
  end
  else
  begin
    case (stmRead) 
      sReadReset :
      begin
        oAxi_ARReady    <= 1'b1;
        oAxi_RResp      <= cAXI4_RESP_OKAY;
        oAxi_RValid     <= 1'b0;
        oAxi_RData      <=  'h0;
        rReadAddr       <=  'h0;
        stmRead         <= sReadAddr;
      end
      
      sReadAddr :
      begin
        oAxi_ARReady    <= 1'b1;
        if (iAxi_ARValid)
        begin
          oAxi_ARReady  <= 1'b0;
          rReadAddr     <= iAxi_ARAddr;
          stmRead       <= sDecodeAddr;
        end
      end
      
      sDecodeAddr :
      begin
        if (ReadAddrNOK)
          oAxi_RResp    <= cAXI4_RESP_SLVERR;
        else
          oAxi_RResp    <= cAXI4_RESP_OKAY;
          
        oAxi_RData      <= nReadData;
        oAxi_RValid     <= 1'b1;
        stmRead         <= sReadData;
      end
      
      sReadData :
      begin
        oAxi_RValid     <= 1'b1;
        if (iAxi_RReady)
        begin
          oAxi_RValid   <= 1'b0;
          stmRead       <= sReadReset;
        end
      end
      
      default :
        stmRead         <= sReadReset;
    endcase
  end
end

// Read address decoder
always_comb
begin
  ReadAddrNOK        = 1'b0;
  nReadData          =  'h0;
  case (rReadAddr)
    cADDR_VER :
    begin
      nReadData      = rVersionNr;
    end
    
    cADDR_CFG :
    begin
      nReadData      = iCoreConfig;
    end
    
    cADDR_CTRL :
    begin
      nReadData[0]   = rEnable;
    end
    
    cADDR_IRQ_CTRL :
    begin
      nReadData      = rIrqEnables;
    end
    
    cADDR_IRQ_STS :
    begin
      nReadData      = {rIrq, rIrqStatus};
    end
    
    cADDR_MODE :
    begin
      nReadData      = rMode;
    end
    
    cADDR_FIFOSETPOINT :
    begin
      nReadData      = rFifoSetPoint;
    end
    
    cADDR_MAXSUMDELTA :
    begin
      nReadData      = rMaxSumDelta;
    end
    
    cADDR_DELTA :
    begin
      nReadData      = rDelta;
    end
    
    cADDR_FIFOAVGCTRL :
    begin
      nReadData      = rFifoAvgNumSamples;
    end
    
    cADDR_SAMPLECTRL :
    begin
      nReadData      = rSampleGenDiv;
    end
    
    cADDR_USR_N :
    begin
      nReadData      = rUsr_NVal;
    end
    
    cADDR_USR_CTS :
    begin
      nReadData      = rUsr_CTSVal;
    end
    
    cADDR_PREMULT :
    begin
      nReadData      = rPreMult;
    end
    
    cADDR_OUTDIV :
    begin
      nReadData      = rOutputDiv;
    end
    
    default : 
      ReadAddrNOK    = 1'b1;
  endcase  
end

// Assign the outputs
assign oIRQ       = rIrq;

assign oEnable    = rEnable;
assign oMode      = rMode;

assign oFifoSetPoint = rFifoSetPoint;
assign oMaxSumDelta  = rMaxSumDelta;
assign oDelta        = rDelta;

assign oFifoAvgNumSamples = rFifoAvgNumSamples;
assign oSampleGenDiv      = rSampleGenDiv;

assign oUsrNVal   = rUsr_NVal;
assign oUsrCTSVal = rUsr_CTSVal;

assign oPreMult   = rPreMult;
assign oOutputDiv = rOutputDiv;

endmodule

/*
 * Copyright (c) 2017 Adeas B.V. All rights reserved.
 *
 * This file contains the top-level of the Audio Clock Recovery Unit System.
 *
 * MODIFICATION HISTORY:
 *
 * Ver   Who Date         Changes
 * ----- --- ----------   -----------------------------------------------
 * X.XX  XX  YYYY/MM/DD
 * 1.00  RHe 2017/03/01   First release
 *
 *****************************************************************************/
 
`timescale 1 ps / 1 ps
 
module audio_clock_recovery_v1_0_sys
#(
)
(
  // Clocks and Resets
  input         iAxiClk,    // AXI Lite Clock
  input         iAxiResetn, // AXI Lite Resetn
  
  input         iRefClk,    // Reference Clock
  input         iRefResetn, // Reference Clock Resetn
  
  input         iAudClk,    // ACR Clock
  input         iAudResetn, // ACR Clock Resetn
  
  input         iMClk,      // Audio Master Clock
  input         iMRst,      // Audio Master Clock Reset
  
  // AXI4-Lite bus (cpu control)
  // - Write address
  input         iAxi_AWValid,
  output        oAxi_AWReady,
  input  [7:0] iAxi_AWAddr,
  // - Write data
  input         iAxi_WValid,
  output        oAxi_WReady,
  input  [31:0] iAxi_WData,
  // - Write response
  output        oAxi_BValid,
  input         iAxi_BReady,
  output [ 1:0] oAxi_BResp,
  // - Read address   
  input         iAxi_ARValid,
  output        oAxi_ARReady,
  input  [7:0] iAxi_ARAddr,
  // - Read data/response
  output        oAxi_RValid,
  input         iAxi_RReady, 
  output [31:0] oAxi_RData,
  output [ 1:0] oAxi_RResp,
  
  // IRQ
  output        oIRQ,
  
  // HDMI ACR In
  input  [19:0] iAcr_Cts,
  input  [19:0] iAcr_N,
  input         iAcr_Valid,
  
  // FIFO Data Count In
  input  [11:0] iFifoDataCount,
  
  // Generated Audio Clock Out
  output        oAudioClock
);

localparam pCORE_VERSION = 32'hDEADBEEF;
localparam pFIFO_READ_THRESHOLD = 16;

logic [ 31:0] aclk_nCoreConfig;
logic         aclk_nEnable;
logic   [2:0] aclk_nMode;

logic  [15:0] aclk_nFifoSetPoint;
logic  [15:0] aclk_nMaxSumDelta;
logic  [15:0] aclk_nDelta;

logic   [7:0] aclk_nFifoAvgNumSamples;
logic  [15:0] aclk_nSampleGenDiv;

logic  [23:0] aclk_nUsrNVal;
logic  [23:0] aclk_nUsrCTSVal;

logic   [3:0] aclk_nPreMult;
logic   [7:0] aclk_nOutputDiv;

logic [2:0]   aclk_nChMuxSelect[4];

logic  mclk_nEnable;

logic  mclk_rSampleGenPulse;
logic  mclk_rIncrDelta;
logic  mclk_rDecrDelta;
logic signed [15:0] mclk_rFifoLoadError;
logic signed [15:0] mclk_rPrevFifoLoadError;
logic [15:0]  mclk_nSampleGenDiv;
logic [15:0]  mclk_rSampleGenCounter;
logic  [7:0]  mclk_nFifoAvgNumSamples;
logic [15:0]  mclk_nFifoSetPoint;

logic [25:0]  mclk_rFifoLoadAcc;
logic [19:0]  mclk_rFifoSampleCounter;
logic [11:0]  mclk_rFifoLoadAvg;

logic [19:0] aud_rNCapt;
logic [19:0] aud_rCTSCapt;
logic        aud_rAcrValid;

logic        ref_nEnable;
logic [25:0] ref_rCounter;
logic [25:0] ref_rCTSCapt = 'h0;
logic [25:0] ref_rNCapt = 'h0;
logic [25:0] ref_nCTSCapt;
logic [25:0] ref_nNCapt;
logic        ref_nAcrValid;

logic signed [15:0] ref_rNDelta;
logic [25:0] ref_rNVal = 'h0;
logic [25:0] ref_rCTSVal = 'h0;


logic  [15:0] ref_nDeltaSet;
logic  [15:0] ref_nMaxDeltaSet;
logic signed [15:0] ref_rMaxDeltaThreshold;
logic signed [15:0] ref_rMinDeltaThreshold;
logic signed [15:0] ref_rLoopCtrlDelta;

logic ref_rClk128FsDelayed;
logic ref_rClk128Fs;

logic [7:0] ref_rOutputDivider;
logic [7:0] ref_rOutputCounter;
logic       ref_rClkOut;

logic ref_nSampleGenPulse;
logic ref_nIncrDelta;
logic ref_nDecrDelta;

logic ref_rUpdateNCOValues;

logic   [2:0] ref_nMode;
logic  [23:0] ref_nUsrNVal;
logic  [23:0] ref_nUsrCTSVal;
logic   [3:0] ref_nPreMult;
logic   [7:0] ref_nOutputDiv;


always_comb
begin
  aclk_nCoreConfig = 'h0;
  
end

audio_clock_recovery_v1_0_axi
#(
  .pVERSION_NR(pCORE_VERSION)
)
ACR_V1_0_AXI_INST
(
  // AXI4-Lite bus (cpu control)
  .iAxiClk      (iAxiClk),
  .iAxiResetn   (iAxiResetn),
  // - Write address
  .iAxi_AWValid (iAxi_AWValid),
  .oAxi_AWReady (oAxi_AWReady),
  .iAxi_AWAddr  (iAxi_AWAddr[7:0]),
  // - Write data
  .iAxi_WValid  (iAxi_WValid),
  .oAxi_WReady  (oAxi_WReady),
  .iAxi_WData   (iAxi_WData),
  // - Write response
  .oAxi_BValid  (oAxi_BValid),
  .iAxi_BReady  (iAxi_BReady),
  .oAxi_BResp   (oAxi_BResp),
  // - Read address   
  .iAxi_ARValid (iAxi_ARValid),
  .oAxi_ARReady (oAxi_ARReady),
  .iAxi_ARAddr  (iAxi_ARAddr[7:0]),
  // - Read data/response
  .oAxi_RValid  (oAxi_RValid),
  .iAxi_RReady  (iAxi_RReady), 
  .oAxi_RData   (oAxi_RData),
  .oAxi_RResp   (oAxi_RResp),
  // In/Out signals
  .oIRQ         (oIRQ),
  
  .iCoreConfig  (aclk_nCoreConfig),
  .oEnable      (aclk_nEnable),
  .oMode        (aclk_nMode),
  
  .oFifoSetPoint (aclk_nFifoSetPoint),
  .oMaxSumDelta  (aclk_nMaxSumDelta),
  .oDelta        (aclk_nDelta),
  
  .oFifoAvgNumSamples (aclk_nFifoAvgNumSamples),
  .oSampleGenDiv      (aclk_nSampleGenDiv),
  
  .oUsrNVal     (aclk_nUsrNVal),
  .oUsrCTSVal   (aclk_nUsrCTSVal),
  
  .oPreMult     (aclk_nPreMult),
  .oOutputDiv   (aclk_nOutputDiv)
);


always_ff @(posedge iAudClk)
begin
  aud_rAcrValid   <= 1'b0;
  if (iAcr_Valid) begin
    aud_rNCapt    <= iAcr_N;
    aud_rCTSCapt  <= iAcr_Cts;
    aud_rAcrValid <= 1'b1;
  end
  
  if (!iAudResetn) begin
    aud_rAcrValid <= 1'b0;
  end
end

always_ff @(posedge iMClk)
begin
  mclk_rSampleGenPulse <= 1'b0;
  mclk_rIncrDelta      <= 1'b0;
  mclk_rDecrDelta      <= 1'b0;
  
  if (mclk_rSampleGenCounter < mclk_nSampleGenDiv-1) begin
    mclk_rSampleGenCounter <= mclk_rSampleGenCounter + 1;
  end
  else begin
    mclk_rSampleGenCounter <= 'h0;
    mclk_rSampleGenPulse   <= 1'b1;
  end
  
  
  if (mclk_rFifoSampleCounter > 0) begin
    mclk_rFifoSampleCounter <= mclk_rFifoSampleCounter - 1;
    mclk_rFifoLoadAcc       <= mclk_rFifoLoadAcc + {iFifoDataCount, 2'b00};
  end
  else begin
    mclk_rFifoSampleCounter <= (1 << mclk_nFifoAvgNumSamples) - 1;
    
    mclk_rFifoLoadAcc       <= (mclk_rFifoLoadAcc >> mclk_nFifoAvgNumSamples) + {iFifoDataCount, 2'b00};
    //mclk_rFifoLoadAcc       <= 0 + {iFifoDataCount, 2'b00};
    mclk_rFifoLoadAvg       <= ((mclk_rFifoLoadAcc >> mclk_nFifoAvgNumSamples) >> 2);
  end
  
  mclk_rFifoLoadError <= signed'({1'b0, mclk_rFifoLoadAvg}) - signed'({1'b0, mclk_nFifoSetPoint});
  
  if (mclk_rSampleGenPulse) begin
    mclk_rPrevFifoLoadError <= mclk_rFifoLoadError;
    
    if (mclk_rFifoLoadError == 0) begin
      if (mclk_rPrevFifoLoadError < 0) begin
        mclk_rIncrDelta <= 1'b1;
      end
      if (mclk_rPrevFifoLoadError > 0) begin
        mclk_rDecrDelta <= 1'b1;
      end
    end
    else begin
      if (mclk_rFifoLoadError[$left(mclk_rFifoLoadError)]) begin // Negative?
        if (mclk_rFifoLoadError <= mclk_rPrevFifoLoadError) begin
          mclk_rDecrDelta <= 1'b1;
        end
      end
      else begin // Possitive
        if (mclk_rFifoLoadError >= mclk_rPrevFifoLoadError) begin
          mclk_rIncrDelta <= 1'b1;
        end
      end
    end
  end
  
  if (iMRst | !mclk_nEnable) begin
    mclk_rSampleGenCounter  <= 'h0;
    mclk_rPrevFifoLoadError <= 'h0;
    mclk_rIncrDelta         <= 1'b0;
    mclk_rDecrDelta         <= 1'b0;
    mclk_rSampleGenPulse    <= 1'b0;
    mclk_rFifoLoadAcc       <= 'h0;
    mclk_rFifoLoadAvg       <= 'h0;
    mclk_rFifoSampleCounter <= 'h0;
  end
end

xpm_cdc_pulse #(
  .DEST_SYNC_FF   (4),
  .REG_OUTPUT     (1),
  .RST_USED       (1),
  .SIM_ASSERT_CHK (0)
)
CDC_ACRVLD_INST (
  .src_clk    (iAudClk),
  .src_rst    (~iAudResetn),
  .src_pulse  (aud_rAcrValid),
  
  .dest_clk   (iRefClk),
  .dest_rst   (~iRefResetn),
  .dest_pulse (ref_nAcrValid)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aud_rNCapt))
)
CDC_EXT_N_INST (
  .src_clk   (iAudClk),
  .src_in    (aud_rNCapt),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nNCapt)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aud_rCTSCapt))
)
CDC_EXT_CTS_INST (
  .src_clk   (iAudClk),
  .src_in    (aud_rCTSCapt),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nCTSCapt)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nMode))
)
CDC_MODE_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nMode),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nMode)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nUsrNVal))
)
CDC_USR_N_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nUsrNVal),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nUsrNVal)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nUsrCTSVal))
)
CDC_USR_CTS_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nUsrCTSVal),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nUsrCTSVal)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nPreMult))
)
CDC_PREMULT_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nPreMult),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nPreMult)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nOutputDiv))
)
CDC_OUTDIV_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nOutputDiv),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nOutputDiv)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nDelta))
)
CDC_DELTASET_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nDelta),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nDeltaSet)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nMaxSumDelta))
)
CDC_MAXDELTASET_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nMaxSumDelta),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nMaxDeltaSet)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nFifoAvgNumSamples))
)
CDC_FIFOAVGNUMSMP_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nFifoAvgNumSamples),
  
  .dest_clk  (iMClk),
  .dest_out  (mclk_nFifoAvgNumSamples)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nSampleGenDiv))
)
CDC_SMPGENDIV_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nSampleGenDiv),
  
  .dest_clk  (iMClk),
  .dest_out  (mclk_nSampleGenDiv)
);

xpm_cdc_array_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (0),
  .WIDTH          ($size(aclk_nFifoSetPoint))
)
CDC_FIFOSETPOINT_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nFifoSetPoint),
  
  .dest_clk  (iMClk),
  .dest_out  (mclk_nFifoSetPoint)
);

xpm_cdc_pulse #(
  .DEST_SYNC_FF   (2),
  .REG_OUTPUT     (1),
  .RST_USED       (1),
  .SIM_ASSERT_CHK (0)
)
CDC_SMPGENPULSE_INST (
  .src_clk    (iMClk),
  .src_rst    (iMRst),
  .src_pulse  (mclk_rSampleGenPulse),
  
  .dest_clk   (iRefClk),
  .dest_rst   (~iRefResetn),
  .dest_pulse (ref_nSampleGenPulse)
);

xpm_cdc_pulse #(
  .DEST_SYNC_FF   (2),
  .REG_OUTPUT     (1),
  .RST_USED       (1),
  .SIM_ASSERT_CHK (0)
)
CDC_INCRDELTA_INST (
  .src_clk    (iMClk),
  .src_rst    (iMRst),
  .src_pulse  (mclk_rIncrDelta),
  
  .dest_clk   (iRefClk),
  .dest_rst   (~iRefResetn),
  .dest_pulse (ref_nIncrDelta)
);

xpm_cdc_pulse #(
  .DEST_SYNC_FF   (2),
  .REG_OUTPUT     (1),
  .RST_USED       (1),
  .SIM_ASSERT_CHK (0)
)
CDC_DECRDELTA_INST (
  .src_clk    (iMClk),
  .src_rst    (iMRst),
  .src_pulse  (mclk_rDecrDelta),
  
  .dest_clk   (iRefClk),
  .dest_rst   (~iRefResetn),
  .dest_pulse (ref_nDecrDelta)
);

xpm_cdc_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (1)
)
CDC_ENABLE_MCLK_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nEnable),
  
  .dest_clk  (iMClk),
  .dest_out  (mclk_nEnable)
);

xpm_cdc_single #(
  .DEST_SYNC_FF   (2),
  .SIM_ASSERT_CHK (0),
  .SRC_INPUT_REG  (1)
)
CDC_ENABLE_REFCLK_INST (
  .src_clk   (iAxiClk),
  .src_in    (aclk_nEnable),
  
  .dest_clk  (iRefClk),
  .dest_out  (ref_nEnable)
);

always_ff @(posedge iRefClk)
begin
  
  casez (ref_nMode)
    3'b??0 : begin
      if (ref_nAcrValid) begin
        ref_rNCapt    <= ref_nNCapt[$size(ref_nNCapt)-1:0];
        ref_rCTSCapt  <= ref_nCTSCapt[$size(ref_nCTSCapt)-1:0];
      end
    end
    
    3'b??1 : begin
      ref_rNCapt      <= ref_nUsrNVal[$size(ref_nUsrNVal)-1:0];
      ref_rCTSCapt    <= ref_nUsrCTSVal[$size(ref_nUsrCTSVal)-1:0];
    end
    
    default: begin
    
    end
  endcase
end

always_ff @(posedge iRefClk)
begin
  
  ref_rMaxDeltaThreshold <= signed'({1'b0, (ref_nMaxDeltaSet - ref_nDeltaSet)});
  ref_rMinDeltaThreshold <= -signed'({1'b0, (ref_nMaxDeltaSet - ref_nDeltaSet)});
  
  ref_rOutputDivider   <= ref_nOutputDiv;
  ref_rUpdateNCOValues <= ref_nAcrValid | ref_nIncrDelta | ref_nDecrDelta;
  
  if (ref_nIncrDelta) begin
    if (ref_rLoopCtrlDelta < ref_rMaxDeltaThreshold) begin
      ref_rLoopCtrlDelta  <= ref_rLoopCtrlDelta + signed'({1'b0, ref_nDeltaSet});
    end
    else begin
      ref_rLoopCtrlDelta  <= signed'({1'b0, ref_nMaxDeltaSet});
    end
  end
  if (ref_nDecrDelta) begin
    if (ref_rLoopCtrlDelta < ref_rMinDeltaThreshold) begin
      ref_rLoopCtrlDelta  <= 0 - signed'({1'b0, ref_nMaxDeltaSet});
    end
    else begin
      ref_rLoopCtrlDelta  <= ref_rLoopCtrlDelta - signed'({1'b0, ref_nDeltaSet});
    end
  end
  
  casez (ref_nMode)
    3'b000 : begin
      if (ref_rUpdateNCOValues) begin
        ref_rNVal     <= ref_rNCapt;
        ref_rCTSVal   <= ref_rCTSCapt;
      end
    end
    
    3'b001 : begin
      //ref_rNCapt      <= ref_nUsrNVal[$size(ref_nUsrNVal)-1:0];
      ref_rNVal       <= ref_rNCapt;
      //ref_rCTSCapt    <= ref_nUsrCTSVal[$size(ref_nUsrCTSVal)-1:0];
      ref_rCTSVal     <= ref_rCTSCapt;
    end
    
    3'b1?? : begin
      if (ref_rUpdateNCOValues) begin
        if (ref_rLoopCtrlDelta[$left(ref_rLoopCtrlDelta)]) begin
          ref_rNVal   <= ref_rNCapt - unsigned'(-ref_rLoopCtrlDelta);
        end
        else begin
          ref_rNVal   <= ref_rNCapt + unsigned'({1'b0, ref_rLoopCtrlDelta});
        end
        
        ref_rCTSVal   <= ref_rCTSCapt;
      end
    end
    
    default : begin
    end
  endcase
  
  if (!iRefResetn | !ref_nEnable) begin
    ref_rLoopCtrlDelta <= 'h0;
  end
end


always_ff @(posedge iRefClk)
begin
  
  ref_rClk128FsDelayed <= ref_rClk128Fs;
  
  if (ref_rNVal < ref_rCounter) begin
    ref_rCounter  <= ref_rCounter - ref_rNVal;
  end
  else begin
    ref_rClk128Fs <= ~ref_rClk128Fs;
    //ref_rCounter  <= (ref_rCTSVal + (ref_rCounter - ref_rNVal)); //0.182ps slack
    ref_rCounter  <= (ref_rCTSVal - (ref_rNVal - ref_rCounter));  //0.577ps slack
  end
  
  if (!iRefResetn | !ref_nEnable) begin
    ref_rClk128Fs      <= 1'b0;
    ref_rCounter       <= 'h0;
  end
end

always_ff @(posedge iRefClk)
begin
  
  if (ref_rClk128Fs & !ref_rClk128FsDelayed) begin
    if (ref_rOutputCounter > 0) begin
      ref_rOutputCounter <= ref_rOutputCounter-1;
    end
    else begin
      ref_rClkOut        <= ~ref_rClkOut;
      ref_rOutputCounter <= ref_rOutputDivider-1;
    end
  end

  if (!iRefResetn | !ref_nEnable) begin
    ref_rOutputCounter <= 'h0;
    ref_rClkOut <= 1'b0;
  end
end

assign oAudioClock = ref_rClkOut;


endmodule


/*
 * Copyright (c) 2017 Adeas B.V. All rights reserved.
 *
 * This file contains the top-level of the Audio Clock Recovery Unit.
 *
 * MODIFICATION HISTORY:
 *
 * Ver   Who Date         Changes
 * ----- --- ----------   -----------------------------------------------
 * X.XX  XX  YYYY/MM/DD
 * 1.00  RHe 2017/04/13   First release
 *
 *****************************************************************************/
 
`timescale 1 ns / 1 ps
 
module audio_clock_recovery_v1_0
#(
)
(
  // Clocks and Resets
  input         s_axi_ctrl_aclk,    // AXI Lite Clock
  input         s_axi_ctrl_aresetn, // AXI Lite Resetn
  
  input         ref_clk,            // Reference Clock of the NCO
  input         ref_clk_resetn,     // Reference Clock Resetn
  
  input         acr_clk,            // ACR Clock
  input         acr_resetn,         // ACR Resetn
  
  input         aud_mclk,           // Audio Master Clock
  input         aud_mrst,           // Audio Master Reset
  
  // AXI4-Lite bus (cpu control)
  // - Write address
  input         s_axi_ctrl_awvalid,
  output        s_axi_ctrl_awready,
  input  [7:0] s_axi_ctrl_awaddr,
  // - Write data
  input         s_axi_ctrl_wvalid,
  output        s_axi_ctrl_wready,
  input  [31:0] s_axi_ctrl_wdata,
  // - Write response
  output        s_axi_ctrl_bvalid,
  input         s_axi_ctrl_bready,
  output [ 1:0] s_axi_ctrl_bresp,
  // - Read address   
  input         s_axi_ctrl_arvalid,
  output        s_axi_ctrl_arready,
  input  [7:0] s_axi_ctrl_araddr,
  // - Read data/response
  output        s_axi_ctrl_rvalid,
  input         s_axi_ctrl_rready, 
  output [31:0] s_axi_ctrl_rdata,
  output [ 1:0] s_axi_ctrl_rresp,
  
  // IRQ
  output        irq,
  
  // HDMI ACR In
  input [19:0]  acr_cts_in,
  input [19:0]  acr_n_in,
  input         acr_valid_in,
  
  // FIFO Data Count In
  input [11:0]  fifo_datacount_in,
  
  // Generated Audio Clock Out
  output        aud_clk_out
);

audio_clock_recovery_v1_0_sys
#(
)
ACR_V1_0_SYS_INST
(
  // Clock and Resets
  .iAxiClk         (s_axi_ctrl_aclk),    // AXI Lite Clock
  .iAxiResetn      (s_axi_ctrl_aresetn), // AXI Lite Resetn
  
  .iRefClk         (ref_clk),            // Reference Clock
  .iRefResetn      (ref_clk_resetn),     // Reference Clock Resetn
                        
  .iAudClk         (acr_clk),            // ACR Clock
  .iAudResetn      (acr_resetn),         // ACR Clock Resetn
  
  .iMClk           (aud_mclk),           // Audio Master Clock
  .iMRst           (aud_mrst),           // Audio Master Reset
  
  // AXI4-Lite bus (cpu control)
  .iAxi_AWValid    (s_axi_ctrl_awvalid),
  .oAxi_AWReady    (s_axi_ctrl_awready),
  .iAxi_AWAddr     (s_axi_ctrl_awaddr),
  
  .iAxi_WValid     (s_axi_ctrl_wvalid),
  .oAxi_WReady     (s_axi_ctrl_wready),
  .iAxi_WData      (s_axi_ctrl_wdata),
  
  .oAxi_BValid     (s_axi_ctrl_bvalid),
  .iAxi_BReady     (s_axi_ctrl_bready),
  .oAxi_BResp      (s_axi_ctrl_bresp),
  
  .iAxi_ARValid    (s_axi_ctrl_arvalid),
  .oAxi_ARReady    (s_axi_ctrl_arready),
  .iAxi_ARAddr     (s_axi_ctrl_araddr),
  
  .oAxi_RValid     (s_axi_ctrl_rvalid),
  .iAxi_RReady     (s_axi_ctrl_rready),
  .oAxi_RData      (s_axi_ctrl_rdata),
  .oAxi_RResp      (s_axi_ctrl_rresp),
  
  // Interrupt 
  .oIRQ            (irq),
  
  // HDMI ACR In
  .iAcr_Cts        (acr_cts_in),
  .iAcr_N          (acr_n_in),
  .iAcr_Valid      (acr_valid_in),
  
  // FIFO Data Count In
  .iFifoDataCount  (fifo_datacount_in),
  
  // Generated Audio Clock Out
  .oAudioClock     (aud_clk_out)
);

endmodule


