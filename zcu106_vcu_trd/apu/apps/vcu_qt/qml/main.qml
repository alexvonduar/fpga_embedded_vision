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
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtCharts 2.0
import Qt.labs.folderlistmodel 2.1
import Qt.labs.folderlistmodel 1.0
import QtQuick 2.2
import QtQuick.Layouts 1.2
import "./"

import QtQuick 2.0

ApplicationWindow {
    visible: true
    title: qsTr("VCU TRD 2018.1")
    color: "transparent"
    id: root

    ConfigProperty{
        id: configuration
    }

    property alias fileinfoListModel: fileList.fileListModel
    property bool play: configuration.play
    property bool errorFound: configuration.errorFound
    property var errorMessageText: configuration.errorMessageText
    property var errorNameText: configuration.errorNameText
    property var barColors: configuration.barColors
    property var barTitleColorsPut: configuration.barTitleColorsPut
    property var cellColor: configuration.cellColor
    property var cellHighlightColor: configuration.cellHighlightColor
    property var borderColors: configuration.borderColors
    property int boarderWidths: configuration.boarderWidths

    property var videoResolution: configuration.videoResolution
    property var fpsValue:configuration.fpsValue

    property var videoInput: configuration.videoInput
    property var presetSelect: configuration.presetSelect
    property var outputSelect: configuration.outputSelect
    property var codecSelect: configuration.codecSelect
    property var plotDisplay: configuration.plotDisplay

    property var bitrate: configuration.bitrate
    property var fileBitrate: configuration.fileBitrate
    property var bitrateUnit: configuration.bitrateUnit
    property var bFrame: configuration.bFrame
    property var gopLength: configuration.gopLength
    property int encoderType: configuration.encoderType
    property var profile: configuration.profile
    property var qpMode: configuration.qpMode
    property var rateControl: configuration.rateControl
    property var l2Cache: configuration.l2Cache
    property var latencyMode: configuration.latencyMode
    property var lowBandwidth: configuration.lowBandwidth
    property var fillerData: configuration.fillerData
    property var gopMode: configuration.gopMode
    property var sliceCount: configuration.sliceCount
    property var ipAddress: configuration.ipAddress
    property bool isStreamUp: configuration.isStreamUp
    property var hostIP: configuration.hostIP
    property var port: configuration.port
    property var fileDuration: configuration.fileDuration

    property var format : configuration.format
    property int numSrc : configuration.numSrc
    property var raw : configuration.raw
    property var  src : configuration.src
    property var deviceType : configuration.deviceType
    property var uri : configuration.uri
    property var sinkType: configuration.sinkType
    property var outputFileName: configuration.outputFileName
    property var selectedMedia: configuration.selectedMedia
    property var outputDirName: configuration.outputDirName
    property bool invertColor: false

    property alias presetStructure: presetValues.presetStruct
    property bool  presetChangeStatus: false

    property var audioFormat: configuration.audioFormat
    property var audioEnable: configuration.audioEnable
    property var samplingRate: configuration.samplingRate
    property var volumeLevel: configuration.volumeLevel
    property var audioChannel: configuration.audioChannel
    property var sourceSelect: configuration.sourceSelect
    property var renderSelect: configuration.renderSelect
    property var scd: configuration.scd


    property bool  demoModeStatus: false
    property var  demoSourceName: ""
    property var  demoBitrate: ""
    property var  demoEncType: ""
    property bool fullScreenMode: false
    property var  recordPositionTime: ""
    property var  currentPosition: 0
    property var  seekBarValue: 0
    property var recordPositionSeconds: ""
    property var playbackDuration: ""
    property var playbackDurationSeconds: ""
    property var  videoEncoderType: 0


    property var inputObj: {
        "format": configuration.format,
        "videoInput": configuration.videoInput,
        "raw": configuration.raw,
        "src": configuration.src,
        "deviceType": configuration.deviceType,
        "bitrate": configuration.bitrate,
        "fileBitrate": configuration.fileBitrate,
        "bitrateUnit": configuration.bitrateUnit,
        "bFrame": configuration.bFrame,
        "gopLength": configuration.gopLength,
        "encoderType": configuration.encoderType,
        "profile": configuration.profile,
        "qpMode": configuration.qpMode,
        "rateControl": configuration.rateControl,
        "l2Cache": configuration.l2Cache,
        "latencyMode": configuration.latencyMode,
        "lowBandwidth":configuration.lowBandwidth,
        "fillerData":configuration.fillerData,
        "gopMode":configuration.gopMode,
        "sliceCount": configuration.sliceCount,
        "ipAddress": configuration.ipAddress,
        "hostIP": configuration.hostIP,
        "port": configuration.port,
        "uri": configuration.uri,
        "fileDuration": configuration.fileDuration,
        "presetSelect": configuration.presetSelect,
        "codecSelect": configuration.codecSelect,
        "selectedMedia":configuration.selectedMedia,
        "outputFileName": configuration.outputFileName,
        "audioFormat": configuration.audioFormat,
        "audioEnable": configuration.audioEnable,
        "samplingRate": configuration.samplingRate,
        "volumeLevel": configuration.volumeLevel,
        "audioChannel": configuration.audioChannel,
        "sourceSelect": configuration.sourceSelect,
        "renderSelect": configuration.renderSelect,
        "scd":configuration.scd

    }
    property var settingsArray: [inputObj]
    property int settingsIndex: 0
    property var eventArray: []
    property var fpsArray: []
    property var bitrateArray: []

    PresetProperties{
        id: presetValues
    }

    FontLoader { id: fontFamily; source: "/font/luxisr.ttf" }
    onPlayChanged: {
        splitScreenGrid.numberInstance = 0
        splitScreenGrid.numberInstance = (root.outputselect == 3) ? (2 * root.numSrc) : root.numSrc
    }

    Rectangle {
        visible: true
        width: parent.width
        height: parent.height
        color: (root.play || demoModeStatus ) ? "transparent": "black"
        onColorChanged:{
            splitScreenGrid.numberInstance = 0
            splitScreenGrid.numberInstance = (root.outputselect == 3) ? (2 * root.numSrc) : root.numSrc
        }

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            id:transparentRect
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    numSrcRectangle.visible = false
                    numSrcLst.showList = false
                    outputRectangle.visible = false
                    outputLst.showList = false
                    statusVu.visible = false
                    matrixVu.visible = false
                    titleBar.y = 0
                    graphPlot.visible = true
                    fullScreenMode = false
                    splitScreenGrid.numberInstance = 0
                    splitScreenGrid.numberInstance = (root.outputselect == 3) ? (2 * root.numSrc) : root.numSrc
                }
            }
            Grid {
                id: splitScreenGrid
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom

                columns: 2
                spacing: 1
                visible: !fullScreenMode && (root.play || demoModeStatus )
                property var numberInstance: 0
                onVisibleChanged: {
                    numberInstance = 0
                    numberInstance = (root.outputselect == 3) ? (2 * root.numSrc) : root.numSrc
                }

                Repeater{
                    id: splitGridRepeater
                    model: splitScreenGrid.numberInstance
                    Rectangle {
                        id: myrect
                        property bool showStatus: true
                        color: "transparent"

                        width: (root.outputselect == 3) ?
                                   ((root.numSrc > 2) ? root.width/3 : root.width/2) :
                                   ((root.numSrc > 2) ? root.width/3 : root.width/root.numSrc)
                        height: (root.outputselect == 3) ?
                                    ((root.numSrc > 1) ? root.height/root.numSrc : root.height) :
                                    ((root.numSrc > 2) ? root.height/root.numSrc : root.height)

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                titleBar.y = 0
                                graphPlot.visible = true
                                splitGridRepeater.itemAt(index).showStatus = !splitGridRepeater.itemAt(index).showStatus
                            }
                        }

                        Rectangle{
                            Behavior on opacity {
                                OpacityAnimator { duration: 100;}
                            }
                            opacity : myrect.showStatus
                            anchors.right: ((index % 2) == 1) ? parent.left : parent.right
                            anchors.rightMargin: ((index % 2) == 1) ? -(stausRow.width+2) : 2
                            anchors.top: (root.outputselect == 3) ?
                                             ((root.numSrc > 1) ? ((index > 1) ? parent.top : parent.bottom) : (parent.top)) :
                                             (parent.top)
                            anchors.topMargin : (root.outputselect == 3) ?
                                                    ((root.numSrc > 1) ? ((index > 1) ? 0 : -22) : (titleBar.height + 2)) :
                                                    (titleBar.height + 2)
                            width: stausRow.width
                            height: 20
                            color: "lightGray"

                            Row{
                                id: stausRow
                                spacing: 10
                                Label{
                                    text: "<b>Source: </b>" + (demoModeStatus ? demoSourceName :(((root.outputselect == 3) ? ((index > 1) ? (videoSourceList[settingsArray[1].videoInput].shortName) : (videoSourceList[settingsArray[0].videoInput].shortName)) :
                                                                                          (settingsArray[index] ? videoSourceList[settingsArray[index].videoInput].shortName : "")) +
                                          ((root.outputselect == 3) ? ((index % 2) ? " Raw" : " Processed") : "")))
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
                                    text: "<b>Format: </b>" + (root.format == 0 ? "NV12" : "NV16")
                                }
                                Rectangle{
                                    width: 2
                                    height: 20
                                    color: "darkGray"
                                }
                                Label{
                                    text: "<b>FPS: </b>" + (demoModeStatus ? ((fpsArray.length && fpsArray[index])? fpsArray[index].fpsValue : "0") : (((root.outputSelect == 1) || (root.outputSelect == 3)) ?
                                                                "NA" : ((fpsArray.length && fpsArray[index])? fpsArray[index].fpsValue : "0")))
                                }
                                Rectangle{
                                    width: 2
                                    height: 20
                                    color: "darkGray"
                                }
                                Label{
                                    text: "<b>Encoder: </b>" + (demoModeStatus ? (demoEncType) : ((root.outputselect == 3) ?
                                                                    ((index % 2) ?  "NA" : ((index > 1) ? ((settingsArray[1].encoderType === "1") ? "AVC" : "HEVC") : ((settingsArray[0].encoderType === "1") ? "AVC" : "HEVC"))):
                                                                      (settingsArray[index] ? (((settingsArray[index].raw) ? "NA" : ((settingsArray[index].src === 1) ? videoEncoderType :  ((settingsArray[index].encoderType === "1") ? "AVC" : (settingsArray[index].src === 2)?"NA":"HEVC")))) : "")))
                                }
                                Rectangle{
                                    width: 2
                                    height: 20
                                    color: "darkGray"
                                }
                                Label{
                                    text:  "<b>Bitrate: </b>" + (demoModeStatus ? demoBitrate : ((root.outputselect == 3) ?
                                                                     ((index % 2) ? "NA" : ((index > 1) ?
                                                                                                (settingsArray[1].bitrate +  ((settingsArray[1].bitrateUnit === "1") ? "Mbps" : "Kbps")):
                                                                                                (settingsArray[0].bitrate +  ((settingsArray[0].bitrateUnit === "1") ? "Mbps" : "Kbps")))) :
                                                                     (settingsArray[index] ? (((settingsArray[index].raw)) ? "NA" : (((settingsArray[index].src === 1 || settingsArray[index].src === 2) && bitrateArray.length) ? bitrateArray[index].fileBitrate : (settingsArray[index].bitrate + ((settingsArray[index].bitrateUnit === "1") ? "Mbps" : "Kbps")))) : "")))
                                }
                            }
                        }
                    }
                }
            }

            Rectangle{
                id: titleBar
                y: 0
                anchors{
                    left: parent.left
                    right: parent.right
                }

                height: 90
                color: "lightGray"
                Rectangle{
                    id: logoImg
                    anchors{
                        left: parent.left
                        leftMargin: 0
                        top: parent.top
                        topMargin: 0
                    }
                    width: 160
                    height: 55
                    color: "white"
                    Image{
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:///images/xilinxLogo.png"
                    }
                }
                Label{
                    id: prjTitle
                    anchors{
                        left: logoImg.right
                        leftMargin: 10
                        right: logo1Img.left
                        rightMargin: 10
                        top: parent.top
                        topMargin: 5
                    }
                    height: 40
                    font.pointSize: 20
                    color: "black"
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Zynq UltraScale+ MPSoC VCU Targeted Reference design"
                }
                Image{
                    id: logo1Img
                    anchors{
                        right: parent.right
                        rightMargin: 0
                        top: parent.top
                        topMargin: 0
                    }
                    width: 160
                    height: 55
                    source: "qrc:///images/zynqLogo.png"
                }
                StatusView{
                    id: statusVu
                    anchors.right: parent.right
                    anchors.top: topBar.bottom
                    visible: false
                }
                QuadrantView{
                    id: matrixVu
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.top: topBar.bottom
                    anchors.topMargin: 0
                    visible: false
                }

                Rectangle{
                    id: topBar
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.top: prjTitle.bottom
                    anchors.topMargin: 10
                    anchors.bottom: parent.bottom

                    border.color: "gray"
                    color: "transparent"
                    radius: 2

                    Button{
                        id: playBtn
                        anchors{
                            left: parent.left
                            leftMargin: 10
                            top: parent.top
                            topMargin: 5
                            bottom: parent.bottom
                            bottomMargin: 5
                        }
                        enabled: !demoModeStatus
                        width: parent.height
                        height: parent.height-10
                        Image{
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            height: parent.height
                            width: parent.height
                            anchors.fill: parent
                            source: root.play? "qrc:///images/pause.png" :"qrc:///images/play_arrow.png"

                        }
                        style: ButtonStyle{
                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 25
                                border.width: control.activeFocus ? 2 : 1
                                border.color: "#888"
                                radius: 4
                                gradient: Gradient {
                                    GradientStop { position: 0 ; color: (root.play && root.invertColor && (root.sinkType === 1 || root.sinkType === 0)) ? "red" : (control.pressed ? "#ccc" : "#eee") }
                                    GradientStop { position: 1 ; color: (root.play && !root.invertColor && (root.sinkType === 1 || root.sinkType === 0)) ? "red" : (control.pressed ? "#aaa" : "#ccc") }
                                }
                            }
                        }
                        onClicked: {
                            numSrcRectangle.visible = false
                            numSrcLst.showList = false
                            outputRectangle.visible = false
                            outputLst.showList = false
                            fileList.visible = false
                            encoderDecoderPanel.visible = false

                            if(!root.play){
                                if(!root.isStreamUp && (root.sinkType === 0)){
                                    errorMessageText = "No ethernet connection"
                                    errorNameText = "Error"
                                }else{
                                    for(var i = 0; i < root.numSrc; i++){
                                        if(outputLbl.text == "Display Port"){
                                            positionBarStartTime.text = "00:00"
                                        }
                                        if(outputLbl.text == "Record"){
                                            positionBarStartTime.text  = "00:00"
                                            positionBar.value = 0
                                            if(settingsArray[i].encoderType === "2"){
                                                settingsArray[i].outputFileName = "/media/" + settingsArray[i].selectedMedia + "/" + outputDirName + "/" +  videoSourceList[settingsArray[i].videoInput].shortName + "_H265" + "_rec_" + Qt.formatDateTime(new Date(), "yyyyMMddHHmmss") + ".ts"
                                            }else{
                                                settingsArray[i].outputFileName = "/media/" + settingsArray[i].selectedMedia + "/" + outputDirName + "/" + videoSourceList[settingsArray[i].videoInput].shortName + "_H264" + "_rec_" + Qt.formatDateTime(new Date(), "yyyyMMddHHmmss") + ".ts"
                                            }
                                        }
                                        else{
                                            settingsArray[i].outputFileName = ""
                                        }
                                    }
                                    controller.getCommonParam(root.numSrc, root.sinkType, monitorRect.rate)
                                    controller.getSourceData(root.numSrc, settingsArray,rootWidth,rootHeight)
                                    controller.start_pipeline();
                                }
                                splitScreenGrid.numberInstance = 0
                                splitScreenGrid.numberInstance = (root.outputselect == 3) ? (2 * root.numSrc) : root.numSrc
                            }else{
                                controller.stop_pipeline();
                                root.errorFound = false;
                            }
                        }
                    }

                    Row{
                        anchors.left: playBtn.right
                        anchors.leftMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        spacing: 20

                        Rectangle{
                            width: 160
                            height: parent.height
                            color: "transparent"
                            Label{
                                anchors.left: parent.left
                                width: 110
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                text: "<b>Num. of input:</b>"
                            }
                            Rectangle{
                                id: numSrcLst
                                anchors.right: parent.right
                                width: 50
                                height: parent.height
                                color: (root.play || demoModeStatus) ? "lightGray" : "gray"
                                property var showList: false
                                property var browseSrc: false
                                enabled: !root.play && !demoModeStatus
                                border.color: "black"
                                border.width: 1
                                radius: 2
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        fileList.visible = false
                                        outputRectangle.visible = false
                                        outputLst.showList = false
                                    }
                                }
                                Label{
                                    id: numSrcLbl
                                    anchors.left: parent.left
                                    anchors.leftMargin: 10
                                    height: parent.height
                                    color: root.play || demoModeStatus ? "white" : "lightGray"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    text: "1"
                                }
                                Image{
                                    anchors.right: parent.right
                                    anchors.rightMargin: 5
                                    width: parent.height
                                    height: parent.height
                                }

                                Rectangle{
                                    id: numSrcRectangle
                                    width: numSrcLst.width
                                    anchors.left: numSrcLst.left
                                    height: (numSourceList.length * 20)
                                    visible: false
                                    border.color: root.borderColors
                                    border.width: root.boarderWidths

                                    clip: true
                                    color: root.barColors
                                    anchors.top: numSrcLst.bottom
                                    anchors.bottomMargin: 0
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onExited: {

                                        }
                                    }

                                    NumSrcVu{
                                        id: numSrcOptionsV
                                        anchors.fill: parent
                                        listModel.model: numSourceList
                                        selecteItem: 0
                                        delgate: this
                                        width: parent.width
                                        function clicked(indexval){
                                            root.numSrc = numSourceList[indexval].shortName
                                            numSrcRectangle.visible = false
                                            numSrcLst.showList = false
                                            numSrcLbl.text = numSourceList[indexval].shortName
                                            updateSettingsArr()
                                            if(root.numSrc > 1){
                                                for(var i = 0; i < root.numSrc; i++){
                                                    if(settingsArray[i].videoInput === 3){
                                                        settingsArray[i].videoInput = configuration.videoInput
                                                        settingsArray[i].src = configuration.src
                                                        settingsArray[i].deviceType = configuration.deviceType
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle{
                            width: 215
                            height: parent.height
                            color: "transparent"
                            Label{
                                anchors.left: parent.left
                                width: 65
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                text: "<b>Output: </b>"
                            }
                            Rectangle{
                                id: outputLst
                                anchors.right: parent.right
                                width: 150
                                height: parent.height
                                color: (root.play || demoModeStatus) ? "lightGray" : "gray"
                                enabled: !root.play && !demoModeStatus
                                property var showList: false
                                border.color: "black"
                                border.width: 1
                                radius: 2

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        fileList.visible = false
                                        encoderDecoderPanel.visible = false
                                        numSrcRectangle.visible = false
                                        numSrcLst.showList = false
                                        outputLst.showList = !outputLst.showList
                                        outputRectangle.visible = !outputRectangle.visible
                                    }
                                }
                                Label{
                                    id: outputLbl
                                    anchors.left: parent.left
                                    anchors.leftMargin: 10
                                    height: parent.height
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    text: outputSinkList[root.outputSelect].shortName
                                }
                                Image{
                                    anchors.right: parent.right
                                    anchors.rightMargin: 5
                                    width: parent.height
                                    height: parent.height
                                    source: outputLst.showList ? "qrc:///images/upArrow.png" : "qrc:///images/downArrow.png"
                                }

                                Rectangle{
                                    id: outputRectangle
                                    width: parent.width
                                    height: 60
                                    visible: false
                                    anchors.left: parent.left
                                    border.color: root.borderColors
                                    border.width: root.boarderWidths
                                    clip: true
                                    color: root.barColors
                                    anchors.top: parent.bottom

                                    OutputDropDown{
                                        id: outputList
                                        anchors.fill: parent
                                        listModel.model: outputSinkList
                                        selecteItem: root.outputSelect
                                        delgate: this
                                        width: parent.width
                                        function clicked(indexval){
                                            outputRectangle.visible = false
                                            outputLst.showList = false
                                            root.outputSelect = indexval
                                            outputLbl.text = outputSinkList[indexval].shortName
                                            switch (indexval){
                                            case 0:
                                                root.sinkType = 2
                                                for(var i = 0; i < root.numSrc; i++){
                                                    settingsArray[i].volumeLevel = configuration.volumeLevel
                                                }
                                                break
                                            case 1:
                                                root.sinkType = 1
                                                for(var i = 0; i < root.numSrc; i++){
                                                    if(settingsArray[i].videoInput === 3 || settingsArray[i].videoInput === 4){
                                                        settingsArray[i].videoInput = configuration.videoInput
                                                        settingsArray[i].src = configuration.src
                                                        settingsArray[i].deviceType = configuration.deviceType
                                                    }
                                                }

                                                break
                                            case 3:
                                                root.sinkType = 3
                                                for(var i = 0; i < root.numSrc; i++){
                                                    if(settingsArray[i].videoInput === 3 || settingsArray[i].videoInput === 4){
                                                        settingsArray[i].videoInput = configuration.videoInput
                                                        settingsArray[i].src = configuration.src
                                                        settingsArray[i].deviceType = configuration.deviceType
                                                    }
                                                }
                                                break
                                            case 2:
                                                root.sinkType = 0
                                                for(var i = 0; i < root.numSrc; i++){
                                                    if(settingsArray[i].videoInput === 3 || settingsArray[i].videoInput === 4){
                                                        settingsArray[i].videoInput = configuration.videoInput
                                                        settingsArray[i].src = configuration.src
                                                        settingsArray[i].deviceType = configuration.deviceType
                                                    }
                                                }
                                                break
                                            default:
                                                root.sinkType = 2
                                                break
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Button{
                            width: 140
                            height: parent.height
                            text: "Input Settings"
                            enabled: !root.play && !demoModeStatus
                            style: ButtonStyle{
                                background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 25
                                    border.width: control.activeFocus ? 2 : 1
                                    border.color: "#888"
                                    radius: 4
                                    gradient: Gradient {
                                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                                    }
                                }
                            }
                            onClicked: {
                                numSrcRectangle.visible = false
                                numSrcLst.showList = false
                                outputLst.showList = false
                                outputRectangle.visible = false
                                ipSetingsPopup.visible = true
                            }
                        }

                        /*demo mode*/
                        Button{
                            width: 130
                            height: parent.height
                            text: demoModeStatus ? "Stop" : "Demo Mode"
                            enabled: !root.play && root.sinkType != 1 && root.sinkType != 0
                            style: ButtonStyle{
                                background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 25
                                    border.width: control.activeFocus ? 2 : 1
                                    border.color: "#888"
                                    radius: 4
                                    gradient: Gradient {
                                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                                    }
                                }
                            }
                            onClicked: {
                                ipSetingsPopup.visible = false
                                numSrcRectangle.visible = false
                                numSrcLst.showList = false
                                outputRectangle.visible = false
                                outputLst.showList = false
                                fileList.visible = false
                                encoderDecoderPanel.visible = false
                                demoModeStatus=!demoModeStatus
                                if(demoModeStatus){
                                    controller.getCommonParam(root.numSrc, root.sinkType, monitorRect.rate)
                                    controller.getSourceData(root.numSrc, settingsArray,rootWidth,rootHeight)
                                }
                                controller.demoModeCall(demoModeStatus,settingsArray[0].audioEnable)
                                splitScreenGrid.numberInstance = 0
                                splitScreenGrid.numberInstance = (root.outputselect == 3) ? (2 * root.numSrc) : root.numSrc
                            }
                        }

                        Rectangle{
                            id: monitorRect
                            width: 270
                            height: 20
                            color: "transparent"
                            property var rate: (refreshRate ? 60 : 30)
                            Label {
                                anchors{
                                    left: parent.left
                                    leftMargin: 10
                                    top: parent.top
                                }
                                width: 140
                                height: 25
                                visible: false
                                verticalAlignment: Text.AlignVCenter
                                text: "<b>Monitor Refresh Rate: </b>"
                            }

                            Row{
                                anchors{
                                    right: parent.right
                                    top: parent.top
                                }
                                height: 25
                                spacing: 5
                                ExclusiveGroup{
                                    id: refreshRateGroup
                                }

                                RadioButton{
                                    id: thirtyRadio
                                    text: "30"
                                    exclusiveGroup: refreshRateGroup
                                    width: 40
                                    visible: false
                                    checked: !refreshRate
                                    onCheckedChanged: {
                                        if(checked){
                                            monitorRect.rate = 30
                                        }
                                    }
                                }

                                RadioButton{
                                    id: sixtyRadio
                                    width: 40
                                    text: "60"
                                    checked: refreshRate
                                    enabled: refreshRate
                                    visible: false
                                    exclusiveGroup: refreshRateGroup
                                    onCheckedChanged: {
                                        if(checked){
                                            monitorRect.rate = 60
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Button{
                        id: stopButton
                        anchors{
                            right: parent.right
                            rightMargin: 10
                            top: parent.top
                            topMargin: 5
                            bottom: parent.bottom
                            bottomMargin: 5
                        }

                        width: parent.height
                        height: parent.height-10

                        Image{
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            height: parent.height
                            width: parent.height
                            anchors.fill: parent
                            source: "qrc:///images/close.png"

                        }
                        style: ButtonStyle{
                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 25
                                border.width: control.activeFocus ? 2 : 1
                                border.color: "#888"
                                radius: 4
                                gradient: Gradient {
                                    GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                                    GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                                }
                            }
                        }
                        onClicked: {
                            controller.stop_pipeline();
                            refreshTimer.stop()
                            controller.uninitAll()
                            controller.freeMemory()
                            Qt.quit()
                        }
                    }

                    Button{
                        id: fullScrnButton
                        anchors{
                            right: stopButton.left
                            rightMargin: 10
                            top: parent.top
                            topMargin: 5
                            bottom: parent.bottom
                            bottomMargin: 5
                        }

                        width: parent.height
                        height: parent.height-10
                        Image{
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            height: parent.height-5
                            width: parent.height-5
                            source: "qrc:///images/fullScreen.png"

                        }
                        style: ButtonStyle{
                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 25
                                border.width: control.activeFocus ? 2 : 1
                                border.color: "#888"
                                radius: 4
                                gradient: Gradient {
                                    GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                                    GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                                }
                            }
                        }
                        onClicked: {
                            encoderDecoderPanel.visible = false
                            numSrcRectangle.visible = false
                            numSrcLst.showList = false
                            outputRectangle.visible = false
                            outputLst.showList = false
                            statusVu.visible = false
                            matrixVu.visible = false
                            fullScreenMode = true
                            if(root.play || demoModeStatus){
                                fileList.visible = false
                                titleBar.y = -100
                                graphPlot.visible = false
                            }
                        }
                    }
                }
            }

            //position bar//
            Rectangle{
                visible: ((root.play  &&  !fullScreenMode && (root.sinkType === 1 || settingsArray[settingsIndex].src === 1)) ? true : false)
                anchors.left: parent.left
                anchors.bottom: graphPlot.top
                color: "transparent"
                id: recordPositionRect
                width: parent.width
                height: 50
                Label{
                    id:positionBarStartTime
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.bottom: parent.top
                    font.pointSize: 8
                    text:"00:00"
                    color: "white"
                }
                Label{
                    id:positionBarEndtime
                    anchors.bottom: parent.top
                    anchors.right:parent.right
                    anchors.rightMargin: 10
                    font.pointSize: 8
                    color: "white"
                }
                Slider {
                    id: positionBar
                    anchors.left: positionBarStartTime.right
                    anchors.right: positionBarEndtime.left
                    width: parent.width-40
                    anchors.leftMargin: 15
                    anchors.rightMargin:15
                    anchors.bottom: parent.top
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            mouse.accepted = false
                        }
                    }
                    style: SliderStyle {
                        handle: Rectangle {
                            implicitWidth: 15
                            implicitHeight: 15
                            radius: width / 2
                            border.color: "#353637"
                        }
                    }
                }
            }

            Rectangle {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                color: "transparent"
                id: graphPlot
                width: parent.width
                height: 200

                Rectangle {
                    id: cpuUtilizationPlot
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    width: (parent.width-80)/3
                    height: 200 * 1
                    visible: root.plotDisplay
                    border.color: root.borderColors
                    border.width: root.boarderWidths
                    color: "#E9E9E9"
                    ChartView{
                        id: chart_line_CPU
                        anchors.fill: parent
                        theme: ChartView.ChartThemeBlueCerulean
                        antialiasing: true

                        ValueAxis {
                            id: axisYcpu
                            min: 0
                            max: 100
                            labelFormat: "%d"
                            labelsFont.pointSize: 10
                            labelsColor: "white"
                            gridLineColor: "white"
                            lineVisible: false
                        }
                        ValueAxis {
                            id: axisXcpu
                            min: 0
                            max: 60
                            labelsVisible: false
                            gridLineColor: "white"
                            lineVisible: false
                            labelsFont.pointSize: 1
                        }

                        LineSeries {
                            name: "CPU Utilization(0.00%)"
                            axisX: axisXcpu
                            axisY: axisYcpu
                        }
                    }
                }

                Rectangle {
                    id: hpPortUtilizationPlot
                    anchors.left: cpuUtilizationPlot.right
                    anchors.leftMargin: 20
                    width: (parent.width-80)/3
                    height: 200 * 1
                    visible: root.plotDisplay
                    border.color: root.borderColors
                    border.width: root.boarderWidths
                    color: "#E9E9E9"
                    ChartView{
                        anchors.fill: parent
                        theme: ChartView.ChartThemeBlueCerulean
                        antialiasing: true
                        id: encoderBandWidthPlot
                        ValueAxis {
                            id: axisYEncBW
                            min: 0
                            max: 40
                            labelFormat: "%d"
                            labelsFont.pointSize: 10
                            labelsColor: "white"
                            gridLineColor: "white"
                            lineVisible: false
                        }
                        ValueAxis {
                            id: axisXEncBW
                            min: 0
                            max: 60
                            labelsVisible: false
                            gridLineColor: "white"
                            lineVisible: false
                            labelsFont.pointSize: 1
                        }
                        LineSeries {
                            axisX: axisXEncBW
                            axisY: axisYEncBW
                            name: "Encoder Memory Bandwidth(0.00 Gbps)"
                        }
                    }
                }
                Rectangle {
                    id: latencyPlot
                    anchors.left: hpPortUtilizationPlot.right
                    anchors.leftMargin: 20
                    width: (parent.width-80)/3
                    height: 200 * 1
                    visible: root.plotDisplay
                    border.color: root.borderColors
                    border.width: root.boarderWidths
                    color: "#E9E9E9"
                    ChartView{
                        anchors.fill: parent
                        theme: ChartView.ChartThemeBlueCerulean
                        antialiasing: true
                        id: decoderBandWidthPlot
                        ValueAxis {
                            id: axisYDecBW
                            min: 0
                            max: 40
                            labelFormat: "%d"
                            labelsFont.pointSize: 10
                            labelsColor: "white"
                            gridLineColor: "white"
                            lineVisible: false
                        }
                        ValueAxis {
                            id: axisXDecBW
                            min: 0
                            max: 60
                            labelsVisible: false
                            gridLineColor: "white"
                            lineVisible: false
                            labelsFont.pointSize: 1
                        }

                        LineSeries {
                            axisX: axisXDecBW
                            axisY: axisYDecBW
                            name: "Decoder Memory Bandwidth (0.00 Gbps)"
                        }
                    }
                }

                Behavior on x{
                    NumberAnimation {
                        duration: 500
                        easing.type: Easing.OutSine
                    }
                }
            }
        }

        Timer {
            id: refreshTimer
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                controller.getLocalIpAddress()
                controller.updatecpu(chart_line_CPU.series(0))
                controller.updateThroughput(encoderBandWidthPlot.series(0),decoderBandWidthPlot.series(0))
                if(root.play && (root.sinkType === 1 || root.sinkType === 0)){
                    root.invertColor = !root.invertColor
                }else{
                    root.invertColor = false
                }
                if(demoModeStatus){
                    controller.updateFPS()
                    controller.demoPollEvent()
                }
                if(root.play && !root.errorFound){
                    controller.updateFPS()
                    controller.updateFileBitrate()
                    controller.pollEvent()
                    if(root.play){
                        controller.getPosition()
                        controller.getDuration()
                        controller.getVideoType()
                    }
                    if(root.play && root.sinkType === 1){ //1 for record
                        positionBarEndtime.text="0"+settingsArray[settingsIndex].fileDuration+":00"
                        recordPositionSeconds = Math.floor((recordPositionTime/1e+9)) // nanoSeconds to Seconds
                        positionBarStartTime.text = positionBarCurrentTime(Math.floor((recordPositionSeconds)/60),Math.floor((recordPositionSeconds)%60))
                        currentPosition = (settingsArray[settingsIndex].fileDuration *(6e+10)) - (recordPositionTime) //nanoseconds
                        seekBarValue = ((settingsArray[settingsIndex].fileDuration *(6e+10)) -  currentPosition ) / ((settingsArray[settingsIndex].fileDuration *(6e+10)))
                        positionBar.value =  seekBarValue
                    }
                    if(root.play && settingsArray[settingsIndex].src === 1){
                        playbackDurationSeconds = Math.floor((playbackDuration/1e+9)) //nanoSeconds to Seconds
                        positionBarEndtime.text =positionBarCurrentTime(Math.floor((playbackDurationSeconds)/60),Math.floor((playbackDurationSeconds)%60))
                        positionBarStartTime.text = positionBarCurrentTime(Math.floor(((recordPositionTime)/1e+9)/60),Math.floor(((recordPositionTime)/1e+9)%60))
                        currentPosition = ((playbackDuration) - (recordPositionTime))
                        seekBarValue = (playbackDuration -  currentPosition ) / (playbackDuration)
                        positionBar.value =seekBarValue
                    }

                }else{
                    root.fpsValue = 0
                }
            }
        }
    }

    InputSettingsPopup{
        id: ipSetingsPopup
        visible: false
    }

    FileListVu{
        id: fileList
        visible: false
    }

    StreaminPopup{
        id: streaminPopupdlg
        visible: false
    }

    EncDecPanel{
        id: encoderDecoderPanel
        visible: false
        Component.onCompleted: {
        }
    }

    KeypadPopup{
        id: quertyKeyPad
        visible: false
    }
    /*Error message*/
    ErrorMessage{
        width: parent.width
        height: parent.height
        id: errorMessage
        messageText: errorMessageText
        errorName: errorNameText
        message.onClicked:{
            errorMessageText = ""
            errorNameText = ""
        }
    }
    function setPresets(index){
        settingsArray[settingsIndex].bFrame =  presetStructure[index].bFrame
        settingsArray[settingsIndex].gopLength = presetStructure[index].gopLength
        settingsArray[settingsIndex].bitrate = presetStructure[index].bitrate
        settingsArray[settingsIndex].encoderType = presetStructure[index].encoderType
        settingsArray[settingsIndex].bitrateUnit = presetStructure[index].bitrateUnit
        settingsArray[settingsIndex].profile = presetStructure[index].profile
        settingsArray[settingsIndex].qpMode = presetStructure[index].qpMode
        settingsArray[settingsIndex].rateControl = presetStructure[index].rateControl
        settingsArray[settingsIndex].l2Cache = presetStructure[index].l2Cache
        settingsArray[settingsIndex].latencyMode = presetStructure[index].latencyMode
        settingsArray[settingsIndex].lowBandwidth = presetStructure[index].lowBandwidth
        settingsArray[settingsIndex].fillerData = presetStructure[index].fillerData
        settingsArray[settingsIndex].gopMode = presetStructure[index].gopMode
        settingsArray[settingsIndex].sliceCount = presetStructure[index].sliceCount
    }
    function updateSettingsArr(){
        if(root.numSrc > settingsArray.length){
            for(var i = settingsArray.length; i < root.numSrc; i++){
                settingsArray.push({
                                       "videoInput": configuration.videoInput,
                                       "raw" : configuration.raw,
                                       "src" : configuration.src,
                                       "deviceType" : configuration.deviceType,
                                       "format" : configuration.format,
                                       "bitrate": configuration.bitrate,
                                       "fileBitrate": configuration.fileBitrate,
                                       "bitrateUnit": configuration.bitrateUnit,
                                       "bFrame": configuration.bFrame,
                                       "gopLength": configuration.gopLength,
                                       "encoderType": configuration.encoderType,
                                       "profile": configuration.profile,
                                       "qpMode": configuration.qpMode,
                                       "rateControl": configuration.rateControl,
                                       "l2Cache": configuration.l2Cache,
                                       "latencyMode": configuration.latencyMode,
                                       "lowBandwidth":configuration.lowBandwidth,
                                       "fillerData":configuration.fillerData,
                                       "gopMode":configuration.gopMode,
                                       "sliceCount": configuration.sliceCount,
                                       "ipAddress": configuration.ipAddress,
                                       "hostIP": configuration.hostIP,
                                       "uri": configuration.uri,
                                       "port": configuration.port,
                                       "fileDuration": configuration.fileDuration,
                                       "selectedMedia": configuration.selectedMedia,
                                       "presetSelect": configuration.presetSelect,
                                       "codecSelect": configuration.codecSelect,
                                       "outputFileName": configuration.outputFileName,
                                       "audioEnable": configuration.audioEnable,
                                       "audioFormat": configuration.audioFormat,
                                       "samplingRate": configuration.samplingRate,
                                       "volumeLevel": configuration.volumeLevel,
                                       "audioChannel":configuration.audioChannel,
                                       "sourceSelect":configuration.sourceSelect,
                                       "renderSelect":configuration.renderSelect,
                                       "scd":configuration.scd,
                                   })
            }
        }else if(root.numSrc < settingsArray.length){
            for(var i = settingsArray.length; i > root.numSrc; i--){
                settingsArray.pop(inputObj)
            }
        }
    }
    function demoNoSource(){
        errorNameText = "Error"
        errorMessageText = "No source found"
    }
    function positionBarCurrentTime(minutes,seconds){
        if(minutes.toString().length===1){
            if(seconds.toString().length===1){
                return "0"+ minutes+ ":0"+ seconds
            }else{
                return "0"+ minutes+":"+ seconds
            }
        }else{
            if(seconds.toString().length===1){
                return minutes+ ":0"+ seconds
            }else{
                return minutes+ ":"+ seconds
            }
        }
    }

}
