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
    id: encParamTempRec
    width: parent.width-6
    height: parent.height-110
    color: "transparent"

    property alias tmpBitrate: bitRatetext.text
    property alias tmpBframe: framesCount.value
    property alias tmpGopLength: gopLengthCount.value
    property alias tmpsliceCount: sliceCount.value
    property alias encGrp: encTypeGroup
    property alias profileGrp: profileGroup
    property alias qpGrp: qpModeGroup
    property alias ratecontrolGrp: ratecontrolGroup
    property alias l2cacheGrp: l2cacheGroup
    property alias latencyModeGrp: latencyModeGroup
    property alias lowbandwidthGrp: lowBandwidthGroup
    property alias fillerDataGrp: fillerDataGroup
    property alias gopmodeGrp: gopmodecontrolGroup
    property alias bitrateUnitGrp: bitrateUnitGroup

    MouseArea{
        anchors.fill: parent
        onClicked: keyPad.visible = false
    }

    Column{
        anchors.top: parent.top
        anchors.topMargin: 10
        spacing: 10
        width: parent.width

        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label {
                id: encoderLbl
                anchors{
                    left: parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Encoder: ")
            }

            Row{
                anchors{
                    left: encoderLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                height: 25
                spacing: 20
                ExclusiveGroup{
                    id: encTypeGroup
                }

                RadioButton{
                    id: h264Radio
                    text: "H264"
                    exclusiveGroup: encTypeGroup
                    width: 80
                    objectName: "1"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            sliceCount.value = 8
                            profileHigh.checked = true
                            presetChangeStatus = true
                        }
                    }
                }

                RadioButton{
                    id: h265Radio
                    width: 80
                    text: "H265"
                    checked: true
                    exclusiveGroup: encTypeGroup
                    objectName: "2"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            sliceCount.value = 8
                            profileMain.checked = true
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }

        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label{
                id: profileLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Profile: "
            }
            Row{
                anchors{
                    left:  profileLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                height: 25
                spacing: 20
                ExclusiveGroup{
                    id: profileGroup
                }
                RadioButton{
                    id: profileBaseline
                    width: 80
                    text: "Baseline"
                    exclusiveGroup: profileGroup
                    visible: !h265Radio.checked
                    objectName: "0"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            framesCount.value = 0
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: profileMain
                    width: 80
                    text: "Main"
                    checked: true
                    exclusiveGroup: profileGroup
                    objectName: "1"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: profileHigh
                    width: 80
                    text: "High"
                    exclusiveGroup: profileGroup
                    visible: !h265Radio.checked
                    objectName: "2"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }

        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"
            Label{
                id: ratecontrolLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Rate Control:"
            }
            Row{
                anchors{
                    left:  ratecontrolLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                height: 25
                spacing: 20
                ExclusiveGroup{
                    id: ratecontrolGroup
                }
                RadioButton{
                    id: cbrRadio
                    width: 80
                    text: "CBR"
                    checked: true
                    exclusiveGroup: ratecontrolGroup
                    objectName: "2"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: vbrRadio
                    width: 80
                    text: "VBR"
                    enabled: true
                    exclusiveGroup: ratecontrolGroup
                    objectName: "1"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: latencyRadio
                    width: 80
                    text: "Low_Latency"
                    enabled: true
                    exclusiveGroup: ratecontrolGroup
                    objectName: "2130706433" /*"sending decimal number of this value "x7F000001"*/
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            framesCount.value = 0
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }
        /*filler data*/
        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label{
                id: fillerdataLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Filler Data: "
            }
            Row{
                anchors{
                    left:  fillerdataLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                height: 25
                spacing: 20
                ExclusiveGroup{
                    id: fillerDataGroup
                }
                RadioButton{
                    id: fillerDataEnable
                    width: 80
                    text: "True"
                    checked: cbrRadio.checked ? true : false
                    enabled: cbrRadio.checked
                    exclusiveGroup: fillerDataGroup
                    objectName: "1"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: fillerDataDisable
                    width: 80
                    text: "False"
                    enabled: cbrRadio.checked
                    exclusiveGroup: fillerDataGroup
                    objectName: "0"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }
        /*filler data end*/
        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"
            Label{
                id: qpModeLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "QP: "
            }


            Row{
                anchors{
                    left:  qpModeLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                height: 25
                spacing: 20
                ExclusiveGroup{
                    id: qpModeGroup
                }
                RadioButton{
                    id: qpModeAuto
                    width: 80
                    text: "Auto"
                    exclusiveGroup: qpModeGroup
                    checked: true
                    objectName: "2"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: qpModeUniform
                    width: 80
                    text: "Uniform"
                    exclusiveGroup: qpModeGroup
                    objectName: "0"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }

        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label {
                id: l2cacheLbl
                anchors{
                    left: parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: qsTr("L2 Cache: ")
            }

            Row{
                anchors{
                    left: l2cacheLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                height: 25
                spacing: 20
                ExclusiveGroup{
                    id: l2cacheGroup
                }

                RadioButton{
                    id: enableL2Cache
                    text: "True"
                    exclusiveGroup: l2cacheGroup
                    checked: true
                    width: 80
                    objectName: "1"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: disableL2Cache
                    text: "False"
                    exclusiveGroup: l2cacheGroup
                    width: 80
                    objectName: "0"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }
        /*latency mode*/
        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label {
                id: latencyModeLbl
                anchors{
                    left: parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Latency Mode: ")
            }

            Row{
                anchors{
                    left: latencyModeLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                height: 25
                spacing: 20
                ExclusiveGroup{
                    id: latencyModeGroup
                }

                RadioButton{
                    id: normalLatency
                    text: "Normal"
                    exclusiveGroup: latencyModeGroup
                    checked: true
                    width: 80
                    objectName: "0"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: subFrameLatency
                    text: "Sub_Frame"
                    exclusiveGroup: latencyModeGroup
                    enabled: ratecontrolGroup.current.objectName != 1 && ratecontrolGroup.current.objectName != 2
                    width: 80
                    objectName: "1"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            framesCount.value = 0
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }
        /*latency mode end*/

        /*low bandwidth*/
        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label{
                id: lowBandwidthLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Low Bandwidth: "
            }
            Row{
                anchors{
                    left:  lowBandwidthLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                height: 25
                spacing: 20
                ExclusiveGroup{
                    id: lowBandwidthGroup
                }
                RadioButton{
                    id: lowbandwidthEnable
                    width: 80
                    text: "True"
                    exclusiveGroup: lowBandwidthGroup
                    objectName: "1"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: lowbandwidthDisable
                    width: 80
                    text: "False"
                    exclusiveGroup: lowBandwidthGroup
                    checked: true
                    objectName: "0"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }
        /*low bandwidth end*/

        /*gop mode*/
        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"
            Label{
                id: gopmodecontrolLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Gop Mode:"
            }
            Row{
                anchors{
                    left:  gopmodecontrolLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                height: 25
                spacing: 20
                ExclusiveGroup{
                    id: gopmodecontrolGroup
                }
                RadioButton{
                    id: gopdefault
                    width: 80
                    text: "Basic"
                    exclusiveGroup: gopmodecontrolGroup
                    checked: true
                    objectName: "0"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: lowdealyplabel
                    width: 120
                    text: "Low_Delay_p"
                    exclusiveGroup: gopmodecontrolGroup
                    objectName: "3"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: lowdealyblabel
                    width: 80
                    text: "Low_Delay_b"
                    exclusiveGroup: gopmodecontrolGroup
                    objectName: "4"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }
        /*gop-mode end*/
        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"
            Label{
                id: bitRateLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 140
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Bitrate: "
            }

            TextField{
                id: bitRatetext
                anchors{
                    left: bitRateLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                width: 150
                height: 25
                verticalAlignment: Text.AlignVCenter
                enabled: !settingsArray[settingsIndex].raw
                onTextChanged: {
                    if(bitRatetext.text.length > 4){
                        bitRatetext.text = bitRatetext.text.substring(0, bitRatetext.text.length-1)
                    }
                    tmpPresetSel = 6
                    presetChangeStatus = true
                    if(bitRatetext.text.length === 0){
                        validation = false
                        errorLbl.text = "Invalid bitrate"
                    }else{
                        validation = true
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        keyPad.requireDot = false
                        keyPad.visible =  !keyPad.visible
                        keyPad.textToEdit = bitRatetext
                        keyPad.anchors.topMargin = 409
                    }
                }
            }

            Row{
                anchors{
                    left: bitRatetext.right
                    leftMargin: 2
                    top: parent.top
                }
                height: 25
                spacing: 5
                ExclusiveGroup{
                    id: bitrateUnitGroup
                }

                RadioButton{
                    id: mbps
                    text: "Mbps"
                    exclusiveGroup: bitrateUnitGroup
                    checked: true
                    objectName: "1"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
                RadioButton{
                    id: kbps
                    text: "Kbps"
                    exclusiveGroup: bitrateUnitGroup
                    objectName: "0"
                    onCheckedChanged: {
                        if(checked){
                            tmpPresetSel = 6
                            presetChangeStatus = true
                        }
                    }
                }
            }
        }

        Rectangle{
            color: "transparent"
            width: parent.width
            height: 25
            Label {
                id: bFrame
                anchors{
                    left: parent.left
                    leftMargin: 10
                    top: parent.top
                }
                height: 25
                width: 140
                text: qsTr("B Frames: ")
            }
            Rectangle{
                id: framesCountLblContainer
                anchors{
                    left: framesCount.right
                    leftMargin: 10
                    top: parent.top
                }
                width: 50
                height: 25
                Label{
                    id: framesCountLbl
                    anchors.fill: parent
                    enabled: !settingsArray[settingsIndex].raw
                    text: qsTr(framesCount.value.toString())
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    onTextChanged: {
                        tmpPresetSel = 6
                        presetChangeStatus = true
                    }
                }
            }

            Slider {
                id: framesCount
                anchors{
                    left: bFrame.right
                    leftMargin: 5
                    top: parent.top
                }
                enabled: (!settingsArray[settingsIndex].raw && profileGrp.current.objectName != "0" && ratecontrolGroup.current.objectName != "2130706433" && latencyModeGroup.current.objectName != "1")
                maximumValue: 4.0
                minimumValue: 0
                style: sliderstyle
                stepSize: 1.0
                updateValueWhileDragging: true
            }

        }

        Rectangle{
            color: "transparent"
            width: parent.width
            height: 25
            Label {
                id: sliceLbl
                anchors{
                    left: parent.left
                    leftMargin: 10
                    top: parent.top
                }
                height: 25
                width: 140
                text: qsTr("Slice: ")
            }
            Rectangle{
                anchors{
                    left: sliceCount.right
                    leftMargin: 10
                    top: parent.top
                }
                width: 50
                height: 25
                Label{
                    anchors.fill: parent
                    enabled: !settingsArray[settingsIndex].raw
                    text: qsTr(sliceCount.value.toString())
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    onTextChanged: {
                        tmpPresetSel = 6
                        presetChangeStatus = true
                    }
                }
            }

            Slider {
                id: sliceCount
                anchors{
                    left: sliceLbl.right
                    leftMargin: 6
                    top: parent.top
                }
                enabled: !settingsArray[settingsIndex].raw
                maximumValue: resolutionFactor === 2 ? (h264Radio.checked ? 32 : 22) : 32
                minimumValue: 4
                style: sliderstyle
                stepSize: 1.0
                updateValueWhileDragging: true
            }
        }

        Rectangle{
            color: "transparent"
            width: parent.width
            height: 25

            Label {
                id: gopLenLbl
                width: 140
                height: 25
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                text: qsTr("GoP Length: ")
                verticalAlignment: Text.AlignVCenter
            }
            Rectangle{
                width: 50
                height: 25
                id: goPLenTxtRect
                anchors{
                    left:  gopLengthCount.right
                    leftMargin: 10
                    top: gopLenLbl.top
                }
                enabled: !settingsArray[settingsIndex].raw
                Label{
                    width: parent.width-4
                    height: parent.height-4
                    id: goPLenTxt
                    anchors{
                        left:  parent.left
                        leftMargin: 2
                        top: parent.top
                        topMargin: 2
                    }
                    text: qsTr(gopLengthCount.value.toString())
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    onTextChanged: {
                        tmpPresetSel = 6
                        presetChangeStatus = true
                    }
                }
            }

            Slider {
                id: gopLengthCount
                anchors{
                    left: gopLenLbl.right
                    leftMargin: 6
                    top: parent.top
                }
                enabled: !settingsArray[settingsIndex].raw
                maximumValue: 1000
                minimumValue: 1
                style: sliderstyle
                stepSize: 1.0
                updateValueWhileDragging: true
            }
        }
    }
    Component {
        id: sliderstyle
        SliderStyle {
            handle: Rectangle {
                anchors.centerIn: parent
                color: "white"
                border.color: "gray"
                antialiasing: true
                border.width: 1
                implicitWidth: 10
                implicitHeight: 24
                radius: 5
            }
            groove: Item {
                implicitHeight: 5
                implicitWidth: 150
                Rectangle {
                    height: 5
                    width: parent.width
                    color: "gray"
                    radius: 5
                }
            }
        }
    }
    function setPresetValues(){
        if(settingsArray[settingsIndex].bitrateUnit === "1"){
            mbps.checked = true
        }else{
            kbps.checked = true
        }
        if("1" === settingsArray[settingsIndex].encoderType){
            h264Radio.checked = true
        }else{
            h265Radio.checked = true
        }
        switch (settingsArray[settingsIndex].profile) {
        case "0":
            profileBaseline.checked = true
            break;
        case "1":
            profileMain.checked = true
            break
        case "2":
            profileHigh.checked = true
            break
        default:
            profileMain.checked = true
            break
        }
        if("2" === settingsArray[settingsIndex].qpMode){
            qpModeAuto.checked = true
        }else{
            qpModeUniform.checked = true
        }
        switch (settingsArray[settingsIndex].rateControl){
        case "1":
            vbrRadio.checked = true
            break;
        case "2":
            cbrRadio.checked = true
            break;
        case "2130706433":
            latencyRadio.checked = true
        default:
            vbrRadio.checked = false
            break;
        }
        switch (settingsArray[settingsIndex].gopMode){
        case "0":
            gopdefault.checked = true
            break;
        case "3":
            lowdealyplabel.checked = true
            break;
        case "4":
            lowdealyblabel.checked = true
        default:
            lowdealyplabel.checked = false
            break;
        }
        if("1" === settingsArray[settingsIndex].l2Cache){
            enableL2Cache.checked = true
        }else{
            disableL2Cache.checked = true
        }
        if("1" === settingsArray[settingsIndex].lowBandwidth){
            lowbandwidthEnable.checked = true
        }else{
            lowbandwidthDisable.checked = true
        }
        if("1" === settingsArray[settingsIndex].latencyMode){
            subFrameLatency.checked = true
        }else{
            normalLatency.checked = true
        }
        if("1" === settingsArray[settingsIndex].fillerData){
            fillerDataEnable.checked = true
        }else{
            fillerDataDisable.checked = true
        }
    }
}
