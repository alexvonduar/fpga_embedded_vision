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

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0

Rectangle{
    property alias listModel: repeateListCodec
    property int selecteItem: 0
    property var delgate: this

    height: repeateListCodec.count
    anchors.topMargin: 0
    anchors.leftMargin: 0
    id: codecListVu

    Behavior on height{
        NumberAnimation {
            duration: 0
            easing.type: Easing.Linear
        }
    }
    ColumnLayout{
        spacing: 0
        Repeater{
            id: repeateListCodec
            Rectangle{
                Text {
                    text: modelData.shortName
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
                width: codecListVu.width
                height: 20
                color: selecteItem === index ? root.cellHighlightColor : root.cellColor

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked:{

                        for(var i = 0; i< repeateListCodec.count; i++){
                            repeateListCodec.itemAt(i).color = root.cellColor
                        }
                        parent.color = root.cellHighlightColor
                        delgate.clicked(index)
                    }
                }
            }
        }
    }
    function resetSource(index){
        for(var i = 0; i< repeateListCodec.count; i++){
            if(i === index){
                repeateListCodec.itemAt(i).color = root.cellHighlightColor
            }
            else{
                repeateListCodec.itemAt(i).color = root.cellColor
            }
        }
    }
}
