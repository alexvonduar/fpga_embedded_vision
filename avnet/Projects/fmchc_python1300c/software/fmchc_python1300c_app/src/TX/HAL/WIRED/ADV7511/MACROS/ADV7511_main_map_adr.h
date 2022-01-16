/**********************************************************************************************
*																						      *
* Copyright (c) 2008 - 2012 Analog Devices, Inc.  All Rights Reserved.                        *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/
/*******************************************************************************
*                                                                              *

* This software is intended for use with the ADV7511 part only.                *
*                                                                              *
*******************************************************************************/

/*******************************************************************************
*                                                                              *
* FILE AUTOMATICALLY GENERATED.                                                *
* DATE: 4 Nov 2009 18:16:18                                                    *
*                                                                              *
*******************************************************************************/


#ifndef ADV7511_MAIN_MAP_ADR_H
#define ADV7511_MAIN_MAP_ADR_H

#define HTX_REG_X_1                                         0x00

#define HTX_REG_X_2                                         0x01

#define HTX_REG_X_3                                         0x04

#define HTX_REG_X_4                                         0x07

#define HTX_REG_X_5                                         0x0A
#define HTX_BIT_CTS_SEL                                     0x80

#define HTX_REG_X_6                                         0x0B
#define HTX_BIT_SPDIF_EN                                    0x80
#define HTX_BIT_MCLK_POL                                    0x40
#define HTX_BIT_MCLK_EN                                     0x20

#define HTX_REG_X_7                                         0x0C
#define HTX_BIT_EXT_AUDIOSF_SEL                             0x80
#define HTX_BIT_CS_BIT_OVERRIDE                             0x40

#define HTX_REG_X_8                                         0x0D

#define HTX_REG_X_9                                         0x0E

#define HTX_REG_X_10                                        0x0F

#define HTX_REG_X_11                                        0x10

#define HTX_REG_X_12                                        0x11

#define HTX_REG_X_13                                        0x12
#define HTX_BIT_CR_BIT                                      0x20

#define HTX_REG_X_14                                        0x13

#define HTX_REG_X_15                                        0x14

#define HTX_REG_X_16                                        0x15

#define HTX_REG_X_17                                        0x16
#define HTX_BIT_VFE_INPUT_EDGE                              0x02
#define HTX_BIT_VFE_INPUT_CS                                0x01

#define HTX_REG_X_18                                        0x17
#define HTX_BIT_ITU_VSYNC_POL                               0x40
#define HTX_BIT_ITU_HSYNC_POL                               0x20
#define HTX_BIT_GEN_444_EN                                  0x04
#define HTX_BIT_ASP_RATIO                                   0x02
#define HTX_BIT_DEGEN_EN                                    0x01

#define HTX_REG_X_19                                        0x18
#define HTX_BIT_CSC_EN                                      0x80

#define HTX_REG_X_20                                        0x19

#define HTX_REG_X_21                                        0x1A
#define HTX_BIT_COEFFI_UPDATE                               0x20

#define HTX_REG_X_22                                        0x1C

#define HTX_REG_X_23                                        0x1E

#define HTX_REG_X_24                                        0x1F

#define HTX_REG_X_25                                        0x20

#define HTX_REG_X_26                                        0x21

#define HTX_REG_X_27                                        0x22

#define HTX_REG_X_28                                        0x23

#define HTX_REG_X_29                                        0x24

#define HTX_REG_X_30                                        0x25

#define HTX_REG_X_31                                        0x26

#define HTX_REG_X_32                                        0x27

#define HTX_REG_X_33                                        0x28

#define HTX_REG_X_34                                        0x29

#define HTX_REG_X_35                                        0x2A

#define HTX_REG_X_36                                        0x2B

#define HTX_REG_X_37                                        0x2C

#define HTX_REG_X_38                                        0x2D

#define HTX_REG_X_39                                        0x2E

#define HTX_REG_X_40                                        0x2F

#define HTX_REG_X_41                                        0x30

#define HTX_REG_X_42                                        0x31

#define HTX_REG_X_43                                        0x32

#define HTX_REG_X_44                                        0x33

#define HTX_REG_X_45                                        0x34

#define HTX_REG_X_46                                        0x35

#define HTX_REG_X_47                                        0x36

#define HTX_REG_X_48                                        0x37

#define HTX_REG_X_49                                        0x38

#define HTX_REG_X_50                                        0x39

#define HTX_REG_X_51                                        0x3A

#define HTX_REG_X_52                                        0x3B
#define HTX_BIT_NC_EXT_AUDIOSF_SEL                          0x80
#define HTX_BIT_NC_CSC_EN                                   0x01

#define HTX_REG_X_53                                        0x3C

#define HTX_REG_X_54                                        0x3D

#define HTX_REG_X_55                                        0x3E

#define HTX_REG_X_56                                        0x3F

#define HTX_REG_X_57                                        0x40
#define HTX_BIT_GC_PKT_EN                                   0x80
#define HTX_BIT_SPD_PKT_EN                                  0x40
#define HTX_BIT_MPEG_PKT_EN                                 0x20
#define HTX_BIT_ACP_PKT_EN                                  0x10
#define HTX_BIT_ISRC_PKT_EN                                 0x08
#define HTX_BIT_GM_PKT_EN                                   0x04
#define HTX_BIT_SPARE_PKT1_EN                               0x02
#define HTX_BIT_SPARE_PKT0_EN                               0x01

#define HTX_REG_X_58                                        0x41
#define HTX_BIT_SYSTEM_PD                                   0x40
#define HTX_BIT_LOGIC_RESET                                 0x20
#define HTX_BIT_INTR_POL                                    0x10
#define HTX_BIT_SYNC_GEN_EN                                 0x02

#define HTX_REG_X_59                                        0x42
#define HTX_BIT_PD_POL                                      0x80
#define HTX_BIT_HPD_STATE                                   0x40
#define HTX_BIT_MSEN_STATE                                  0x20
#define HTX_BIT_I2S_32BIT_MODE                              0x08
#define HTX_BIT_AUDIOFIFO_TESTDONE                          0x04

#define HTX_REG_X_60                                        0x43

#define HTX_REG_X_61                                        0x44
#define HTX_BIT_NC_SPDIF_EN                                 0x80
#define HTX_BIT_N_CTS_PKT_EN                                0x40
#define HTX_BIT_AUDIO_SAMPLE_PKT_EN                         0x20
#define HTX_BIT_AVIIF_PKT_EN                                0x10
#define HTX_BIT_AUDIOIF_PKT_EN                              0x08
#define HTX_BIT_PKT_READ_MODE                               0x01

#define HTX_REG_X_62                                        0x45

#define HTX_BIT_DSD_MUX_EN                                  0x80
#define HTX_BIT_PAPB_SYNC                                   0x40

#define HTX_BIT_LOW_FREQ_VIDEO                              0x80
#define HTX_BIT_BIT_REVERSE                                 0x40
#define HTX_BIT_DDR_MSB                                     0x20

#define HTX_REG_X_63                                        0x4A
#define HTX_BIT_AUTO_CHECKSUM_EN                            0x80
#define HTX_BIT_AVI_UPDATE                                  0x40
#define HTX_BIT_AUDIO_UPDATE                                0x20
#define HTX_BIT_GCP_UPDATE                                  0x10

#define HTX_REG_X_64                                        0x4B
#define HTX_BIT_CLEAR_AVMUTE                                0x80
#define HTX_BIT_SET_AVMUTE                                  0x40

#define HTX_REG_X_65                                        0x4C

#define HTX_REG_X_66                                        0x4D

#define HTX_REG_X_67                                        0x4E

#define HTX_REG_X_68                                        0x4F

#define HTX_REG_X_69                                        0x50

#define HTX_REG_X_70                                        0x51

#define HTX_REG_X_71                                        0x52

#define HTX_REG_X_72                                        0x53

#define HTX_REG_X_74                                        0x56

#define HTX_REG_X_75                                        0x57
#define HTX_BIT_ITC                                         0x80

#define HTX_REG_X_76                                        0x58
#define HTX_BIT_AVI_BYTE4_7                                 0x80

#define HTX_REG_X_77                                        0x59

#define HTX_REG_X_78                                        0x5A

#define HTX_REG_X_79                                        0x5B

#define HTX_REG_X_80                                        0x5C

#define HTX_REG_X_81                                        0x5D

#define HTX_REG_X_82                                        0x5E

#define HTX_REG_X_83                                        0x5F

#define HTX_REG_X_84                                        0x60

#define HTX_REG_X_85                                        0x61

#define HTX_REG_X_86                                        0x62

#define HTX_REG_X_87                                        0x63

#define HTX_REG_X_88                                        0x64

#define HTX_REG_X_89                                        0x65

#define HTX_REG_X_90                                        0x66

#define HTX_REG_X_91                                        0x67

#define HTX_REG_X_92                                        0x68

#define HTX_REG_X_93                                        0x69

#define HTX_REG_X_94                                        0x6A

#define HTX_REG_X_95                                        0x6B

#define HTX_REG_X_96                                        0x6C

#define HTX_REG_X_97                                        0x6D

#define HTX_REG_X_98                                        0x6E

#define HTX_REG_X_99                                        0x6F

#define HTX_REG_X_100                                       0x71

#define HTX_REG_X_101                                       0x72

#define HTX_REG_X_102                                       0x73
#define HTX_BIT_AUDIOIF_BYTE1_3                             0x08

#define HTX_REG_X_103                                       0x74

#define HTX_REG_X_104                                       0x75

#define HTX_REG_X_105                                       0x76

#define HTX_REG_X_106                                       0x77
#define HTX_BIT_AUDIOIF_DM_INH                              0x80

#define HTX_REG_X_107                                       0x78

#define HTX_REG_X_108                                       0x79

#define HTX_REG_X_109                                       0x7A

#define HTX_REG_X_110                                       0x7B

#define HTX_REG_X_111                                       0x7C

#define HTX_REG_X_112                                       0x94
#define HTX_BIT_HPD_INTR_MASK                               0x80
#define HTX_BIT_MSEN_INTR_MASK                              0x40
#define HTX_BIT_VS_INTR_MASK                                0x20
#define HTX_BIT_AUDIOFIFO_FULL_INTR_MASK                    0x10
#define HTX_BIT_ITU656_ERROR_INTR_MASK                      0x08
#define HTX_BIT_EDID_RDY_INTR_MASK                          0x04
#define HTX_BIT_RI_RDY_INTR_MASK                            0x02

#define HTX_REG_X_113                                       0x95
#define HTX_BIT_HDCP_ERROR_INTR_MASK                        0x80
#define HTX_BIT_BKSV_FLAG_MASK                              0x40
#define HTX_BIT_TX_READY_INTR_MASK                          0x20
#define HTX_BIT_TX_ARBITRATION_LOST_INTR_MASK               0x10
#define HTX_BIT_TX_RETRY_TIMEOUT_INTR_MASK                  0x08

#define HTX_REG_X_114                                       0x96
#define HTX_BIT_HPD_INTR                                    0x80
#define HTX_BIT_MSEN_INTR                                   0x40
#define HTX_BIT_VS_INTR                                     0x20
#define HTX_BIT_AUDIOFIFO_FULL_INTR                         0x10
#define HTX_BIT_ITU656_ERROR_INTR                           0x08
#define HTX_BIT_EDID_RDY_INTR                               0x04
#define HTX_BIT_RI_RDY_INTR                                 0x02
#define HTX_BIT_PJ_RDY_INTR                                 0x01

#define HTX_REG_X_115                                       0x97
#define HTX_BIT_HDCP_ERROR_INTR                             0x80
#define HTX_BIT_BKSV_FLAG                                   0x40
#define HTX_BIT_TX_READY_INTR                               0x20
#define HTX_BIT_TX_ARBITRATION_LOST_INTR                    0x10
#define HTX_BIT_TX_RETRY_TIMEOUT_INTR                       0x08

#define HTX_REG_X_117                                       0x9A
#define HTX_BIT_LOCK_FILT_EN                                0x80

#define HTX_REG_X_120                                       0x9D

#define HTX_REG_X_121                                       0x9E
#define HTX_BIT_PLLLOCKED                                   0x10

#define HTX_REG_X_124                                       0xA1
#define HTX_BIT_TERMPWRDWNI2C                               0x40
#define HTX_BIT_CH0PWRDWNI2C                                0x20
#define HTX_BIT_CH1PWRDWNI2C                                0x10
#define HTX_BIT_CH2PWRDWNI2C                                0x08
#define HTX_BIT_CLKDRVPWRDWNI2C                             0x04

#define HTX_REG_X_125                                       0xA2

#define HTX_REG_X_127                                       0xA4
#define HTX_BIT_LBKLOGICRESETI2C                            0x10

#define HTX_REG_X_138                                       0xAF
#define HTX_BIT_HDCP_DESIRED                                0x80
#define HTX_BIT_FRAME_ENC                                   0x10
#define HTX_BIT_EXT_HDMI_MODE                               0x02

#define HTX_REG_X_139                                       0xB0

#define HTX_REG_X_140                                       0xB1

#define HTX_REG_X_141                                       0xB2

#define HTX_REG_X_142                                       0xB3

#define HTX_REG_X_143                                       0xB4

#define HTX_REG_X_144                                       0xB5

#define HTX_REG_X_145                                       0xB6

#define HTX_REG_X_146                                       0xB7

#define HTX_REG_X_147                                       0xB8
#define HTX_BIT_ENC_ON                                      0x40
#define HTX_BIT_KEYS_READ_ERROR                             0x10

#define HTX_REG_X_149                                       0xBA
#define HTX_BIT_INT_EPP_ON                                  0x10
#define HTX_BIT_EPP_CONFIG                                  0x08

#define HTX_REG_X_153                                       0xBE

#define HTX_REG_X_154                                       0xBF

#define HTX_REG_X_155                                       0xC0

#define HTX_REG_X_156                                       0xC1

#define HTX_REG_X_157                                       0xC2

#define HTX_REG_X_158                                       0xC3

#define HTX_REG_X_159                                       0xC4

#define HTX_REG_X_162                                       0xC7

#define HTX_REG_X_163                                       0xC8

#define HTX_REG_X_164                                       0xC9
#define HTX_BIT_EDID_READ_EN                                0x10

#define HTX_REG_X_165                                       0xCA

#define HTX_REG_X_166                                       0xCB

#define HTX_REG_X_168                                       0xCD
#define HTX_BIT_GEN444_CLK_EN                               0x80
#define HTX_BIT_CSC_CLK_EN                                  0x40
#define HTX_BIT_ISLAND_CLK_EN                               0x20
#define HTX_BIT_TERC_CLK_EN                                 0x10

#define HTX_REG_X_169                                       0xCE

#define HTX_REG_X_170                                       0xCF

#define HTX_REG_X_171                                       0xD0
#define HTX_BIT_DDR_CLK_SEL                                 0x80
#define HTX_BIT_TIMING_GEN_SEQ                              0x02

#define HTX_REG_X_176                                       0xD5
#define HTX_BIT_STEP_TURNONI2C                              0x10

#define HTX_REG_X_177                                       0xD6

#define HTX_REG_X_178                                       0xD8

#define HTX_REG_X_179                                       0xD9

#define HTX_REG_X_180                                       0xDA

#define HTX_REG_X_181                                       0xDB

#define HTX_REG_X_182                                       0xDC

#define HTX_REG_X_183                                       0xDD

#define HTX_REG_X_184                                       0xDE

#define HTX_REG_X_185                                       0xE0

#define HTX_REG_X_186                                       0xE1

#define HTX_REG_X_187                                       0xE2
#define HTX_BIT_CEC_PD                                      0x01

#define HTX_BIT_VFE_HSYNCDELAYIN_MSB                        0x80
#define HTX_BIT_VFE_WIDTH_MSB                               0x10
#define HTX_BIT_VFE_HEIGHT_MSB                              0x08


#endif
