/******************************************************************************
 * (c) Copyright 2017-2019 Xilinx, Inc. All rights reserved.
 *
 * This file contains confidential and proprietary information of Xilinx, Inc.
 * and is protected under U.S. and international copyright and other
 * intellectual property laws.
 *
 * DISCLAIMER
 * This disclaimer is not a license and does not grant any rights to the
 * materials distributed herewith. Except as otherwise provided in a valid
 * license issued to you by Xilinx, and to the maximum extent permitted by
 * applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
 * FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
 * IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
 * MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
 * and (2) Xilinx shall not be liable (whether in contract or tort, including
 * negligence, or under any other theory of liability) for any loss or damage
 * of any kind or nature related to, arising under or in connection with these
 * materials, including for any direct, or any indirect, special, incidental,
 * or consequential loss or damage (including loss of data, profits, goodwill,
 * or any type of loss or damage suffered as a result of any action brought by
 * a third party) even if such damage or loss was reasonably foreseeable or
 * Xilinx had been advised of the possibility of the same.
 *
 * CRITICAL APPLICATIONS
 * Xilinx products are not designed or intended to be fail-safe, or for use in
 * any application requiring fail-safe performance, such as life-support or
 * safety devices or systems, Class III medical devices, nuclear facilities,
 * applications related to the deployment of airbags, or any other applications
 * that could lead to death, personal injury, or severe property or
 * environmental damage (individually and collectively, "Critical
 * Applications"). Customer assumes the sole risk and liability of any use of
 * Xilinx products in Critical Applications, subject only to applicable laws
 * and regulations governing limitations on product liability.
 *
 * THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
 * AT ALL TIMES.
 *******************************************************************************/

import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle{
    height: (((root.outputSelect == 3) ? (root.numSrc * 2) : root.numSrc) * 23)
    width: 615
    color: "lightGray"

    Column{
        anchors{
            left: parent.left
            leftMargin: 10
            top: parent.top
        }
        spacing: 3
        Repeater{
            model: ((root.outputSelect == 3) ? (root.numSrc * 2) : root.numSrc)
            Rectangle{
                width: 625
                height: 20
                color: "transparent"
                Row{
                    id: stausRow
                    spacing: 10

                    Label{
                        text: "<b>Source: </b>" + "Src " + index
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text: "<b>Resolution: </b>" + root.videoResolution
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text: "<b>Format: </b>" + root.format
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text: "<b>FPS: </b>" + root.fpsValue
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text: "<b>Encoder: </b>" + (((settingsArray[index] && (settingsArray[index].src === "uridecodebin")) || root.raw) ? "NA" : ((settingsArray[index] && (1 === settingsArray[index].enc_enum)) ? "AVC" : "HEVC"))
                    }
                    Rectangle{
                        width: 2
                        height: 20
                        color: "darkGray"
                    }
                    Label{
                        text:  "<b>Bitrate: </b>" + ((root.raw || ((root.src === "uridecodebin") && !root.play))? "NA" : (((root.src === "uridecodebin") && root.play) ? root.fileBitrate : ((root.bitrate.length === 0) ? "0": root.bitrate) + ((root.src === "uridecodebin") ? "" : ((root.bitrateUnit === "1") ? "Mbps" : "Kbps"))))
                    }
                }

            }
        }
    }

}
