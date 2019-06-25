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

Item {

    property int lowBitRate: 10
    property int mediumBitRate: 30
    property int highBitRate: 60

    property var presetStruct: [
        {"name":"AVC Low", "bitrate":lowBitRate, "bFrame":0, "encoderType":"1", "gopLength":60,
            "bitrateUnit":"1", "profile":"2", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1", "gopMode": "0", "latencyMode": "0"},
        {"name":"AVC Medium", "bitrate":mediumBitRate, "bFrame":0, "encoderType":"1", "gopLength":60,
            "bitrateUnit":"1", "profile":"2", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1", "gopMode": "0", "latencyMode": "0"},
        {"name":"AVC High", "bitrate":highBitRate, "bFrame":0, "encoderType":"1", "gopLength":60,
            "bitrateUnit":"1", "profile":"2", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1","gopMode": "0", "latencyMode": "0"},
        {"name":"HEVC Low", "bitrate":lowBitRate, "bFrame":0, "encoderType":"2", "gopLength":60,
            "bitrateUnit":"1", "profile":"1", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1","gopMode": "0", "latencyMode": "0"},
        {"name":"HEVC Medium", "bitrate":mediumBitRate, "bFrame":0, "encoderType":"2", "gopLength":60,
            "bitrateUnit":"1", "profile":"1", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1", "gopMode": "0", "latencyMode": "0"},
        {"name":"HEVC High", "bitrate":highBitRate, "bFrame":0, "encoderType":"2","gopLength":60,
            "bitrateUnit":"1", "profile":"1", "qpMode":"2", "rateControl":"2", "l2Cache":"1", "sliceCount":8, "lowBandwidth":"0", "fillerData": "1", "gopMode": "0", "latencyMode": "0"},
        {"name":"Custom", "bitrate":settingsArray[settingsIndex].bitrate, "bFrame":settingsArray[settingsIndex].bFrame, "encoderType":settingsArray[settingsIndex].encoderType, "gopLength":settingsArray[settingsIndex].gopLength,
            "bitrateUnit":settingsArray[settingsIndex].bitrateUnit, "profile":settingsArray[settingsIndex].profile, "qpMode":settingsArray[settingsIndex].qpMode, "rateControl":settingsArray[settingsIndex].rateControl, "l2Cache":settingsArray[settingsIndex].l2Cache, "sliceCount":settingsArray[settingsIndex].sliceCount, "lowBandwidth":settingsArray[settingsIndex].lowBandwidth,  "fillerData":settingsArray[settingsIndex].fillerData, "gopMode":settingsArray[settingsIndex].gopMode, "latencyMode":settingsArray[settingsIndex].latencyMode}
    ]
}
