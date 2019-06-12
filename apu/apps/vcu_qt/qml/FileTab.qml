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
    width: parent.width-6
    height: parent.height-110
    color: "transparent"
    property bool sataV: false
    property bool usbV: false
    property bool cardV: false
    property var availableMounts : ""
    property alias tmpFileDuration: durationSlider.value
    property alias currentMedia: storageTxt.text
    property alias opFileName: fileNameLbl.text

    MouseArea{
        anchors.fill: parent
        onClicked: {
            mountListRectangle.visible = false
        }
    }

    onVisibleChanged: {
        if(visible){
            refreshMountPointList()
        }else{
            mountListRectangle.visible = false
        }
    }

    Column{
        id: elementsCol
        anchors.top: parent.top
        anchors.topMargin: 10
        spacing: 10
        height: 150
        width: parent.width
        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"
            Label{
                id: storageLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 150
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Storage: "
            }
            TextField{
                id: storageTxt
                anchors{
                    left:  storageLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                width: 125
                height: 25
                enabled: !root.raw
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        presetChangeStatus = true
                        mountListRectangle.visible = !mountListRectangle.visible
                        refreshMountPointList()
                    }
                }
            }

            Button {
                anchors{
                    left: storageTxt.right
                    leftMargin: -2
                    top: parent.top
                }
                width: storageTxt.height
                height: storageTxt.height
                Image{
                    anchors.fill: parent
                    source: "qrc:///images/downArrow.png"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        presetChangeStatus = true
                        mountListRectangle.visible = !mountListRectangle.visible
                        refreshMountPointList()
                    }
                }
            }
        }

        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"
            Label{
                id: fileNameHeaderLbl
                anchors{
                    left:  parent.left
                    leftMargin: 10
                    top: parent.top
                }
                width: 150
                height: 25
                verticalAlignment: Text.AlignVCenter
                text: "Output File Name: "
            }
            Label{
                id: fileNameLbl
                anchors{
                    left:  fileNameHeaderLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                width: 125
                height: 25
                text:  videoSourceList[settingsArray[settingsIndex].videoInput].shortName + (((encParamTabV.encGrp.current.objectName === "2") ? "_H265" : "_H264") + "_rec_TimeStamp.ts")
                enabled: !root.raw
            }
        }

        Rectangle{
            width: parent.width
            height: 25
            color: "transparent"

            Label {
                id: durationLbl
                anchors{
                    left: parent.left
                    leftMargin: 10
                    top: parent.top
                }
                height: 25
                width: 150
                text: qsTr("Duration: ")
                verticalAlignment: Text.AlignVCenter
            }
            Slider {
                id: durationSlider
                anchors{
                    left: durationLbl.right
                    leftMargin: 5
                    top: parent.top
                }
                enabled: !root.raw
                minimumValue: 1
                maximumValue: 3
                stepSize: 1.0
                style: SliderStyle {
                    groove: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 5
                        color: "gray"
                        radius: 5
                    }
                }
            }

            Rectangle{
                color: "transparent"
                anchors{
                    left: durationSlider.right
                    leftMargin: 10
                    top: parent.top
                }
                width: 25
                height: 25
                Label{
                    id: duration
                    anchors.fill: parent
                    enabled: !root.raw
                    text: qsTr(durationSlider.value.toString())
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    onTextChanged: {
                        presetChangeStatus = true
                    }
                }
            }

            Label {
                anchors{
                    left: durationSlider.right
                    leftMargin: 10+35
                    top: parent.top
                }
                height: 25
                width: 110
                text: qsTr("minutes")
                verticalAlignment: Text.AlignVCenter
            }

        }
    }
    Label{
        anchors.top: elementsCol.bottom
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 10
        text: "NOTE:\n• Max bitrate for SD Class-10 card is 80 Mbps\n• Max bitrate for USB 3.0 is 5 Gbps\n• Max bitrate for SATA 3.0 is 6 Gbps\n• Actual bitrate may be lower due to device characteristics"
    }

    Rectangle{
        id: mountListRectangle
        anchors{
            left: parent.left
            leftMargin: 165
            top: parent.top
            topMargin: 35
        }
        width: 150
        height: 60
        visible: false
        clip: true
        color: "transparent"
        MouseArea{
            anchors.fill: parent
        }

        Column{
            anchors.top: parent.top
            anchors.left: parent.left
            width: 150
            height: 60
            anchors.fill: parent
            Rectangle{
                id: card
                Label{
                    id: cardLbl
                    anchors.fill: parent
                    text: "card"
                }
                height: 20
                width: 150
                visible: cardV
                color: "lightGray"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        presetChangeStatus = true
                        currentMedia = cardLbl.text
                        updateOpPath()
                    }
                }
            }
            Rectangle{
                id: sata
                Label{
                    id: sataLbl
                    anchors.fill: parent
                    text: "sata"
                }
                height: 20
                width: 150
                visible: sataV
                color: "lightGray"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        presetChangeStatus = true
                        currentMedia = sataLbl.text
                        updateOpPath()
                    }
                }
            }
            Rectangle{
                id: usb
                Label{
                    id: usbLbl
                    anchors.fill: parent
                    text: "usb"
                }
                height: 20
                width: 150
                visible: usbV
                color: "lightGray"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        presetChangeStatus = true
                        currentMedia = usbLbl.text
                        updateOpPath()
                    }
                }
            }
        }
    }
    function updateOpPath(){
        controller.createStorageDir("/media/" + currentMedia + "/" + root.outputDirName)
        mountListRectangle.visible = false
    }
    function refreshMountPointList(){
        availableMounts = dirOPS.changeFolder("/media/")
        if(mountListRectangle.visible){
            sataV = false
            usbV = false
            cardV = false
            for(var i = 0; i<availableMounts.length; i++){
                if(availableMounts[i].itemName === "card"){
                    cardV = true
                }
                if(availableMounts[i].itemName === "usb"){
                    usbV = true
                }
                if(availableMounts[i].itemName === "sata"){
                    sataV = true
                }
            }
        }
        updateStorageTxt()
    }
    function updateStorageTxt(){
        var currMediaAvailable = false
        for(var i = 0; i < availableMounts.length; i++){
            if(availableMounts[i].itemName === currentMedia){
                currMediaAvailable = true
            }
        }
        if(!currMediaAvailable){
            currentMedia = "card"
            settingsArray[settingsIndex].selectedMedia = currentMedia
        }
    }
}
