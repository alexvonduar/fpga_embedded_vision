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

/*
 * This file defines video QT application Error message custom component.
 */

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0

Rectangle{
    property var messageText: ""
    property var errorName: ""
    property alias message: okMouseArea

    color: "#09ffffff"
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
    }
    visible: messageText.length
    Rectangle{
        anchors.centerIn: parent
        id: errorHolderPopup
        color: root.barColors
        width: 500
        height: 150
        border.color: root.borderColors
        border.width: root.boarderWidths
        Rectangle{
            anchors.top: parent.top
            width: parent.width
            height: 30
            color: root.barTitleColorsPut
            id: baseErrorPopupHeader
            Label{
                text: errorName
                anchors.leftMargin: 16
                anchors.left: parent.left
                font.pixelSize: 16
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle{
            anchors.top: baseErrorPopupHeader.bottom
            width: parent.width
            height: parent.height - baseErrorPopupHeader.height
            color: "#ffffff"
            Rectangle{
                anchors.left: parent.left
                anchors.leftMargin: 20 * 1
                width: parent.width - 40
                anchors.top: parent.top
                anchors.topMargin: 20 * 1
                color: "transparent"
                height: parent.height - (40 * 1)
                Text {
                    anchors.left: parent.left
                    id: errorMessageLbl
                    text: messageText
                    font.pointSize: 13 * 1
                    width: parent.width - 20
                    height: parent.height - 20
                    anchors.top: parent.top
                    wrapMode: Text.WordWrap

                }

                Rectangle{
                    width: 60
                    height: 20
                    anchors.top: parent.top
                    anchors.topMargin: 60 * 1
                    anchors.right: parent.right
                    anchors.rightMargin: 20 * 1
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#f0f0f0"
                        }

                        GradientStop {
                            position: 1
                            color: "#505050"
                        }
                    }

                    MouseArea{
                        id: okMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }
                    Text {
                        color: "black"
                        anchors.centerIn: parent
                        anchors.leftMargin: 5
                        text:"OK"
                        font.pixelSize: 13 * 1

                    }
                }
            }
        }
    }
}
