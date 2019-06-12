/******************************************************************************
 * (c) Copyright 2017-2018 Xilinx, Inc. All rights reserved.
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
 * This file defines GUI helper functions.
 */

#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H

#include <QObject>
#include <QQuickItem>
#include <pthread.h>
#include "CPUStat.h"
#include <QtCharts/QAbstractSeries>
#include <QtCharts/QXYSeries>
#include <QTimer>
#include "vgst_lib.h"
#include "perfapm.h"
#include "video_cfg.h"

#include "video.h"
QT_CHARTS_USE_NAMESPACE

#define ROOT_FILE_PATH "/media/card"
#define BYTE_TO_GBIT (8 / 1000000000.0)
#define RECORD_DIR "vcu_records"
#define BIT_TO_MBIT(value) (value/1000000.0)
#define BIT_TO_KBIT(value) (value/1000.0)
#define IPV4_MIN_LENGTH 7
#define IPV4_MAX_LENGTH 15
#define NUMBER_OF_SOURCE 1
#define MBPS_MULTIPLIER 1000
#define KBPS_MULTIPLIER 1
#define DEMO_BITRATE_LENGTH  2
#define DEMO_ENCTYPE_LENGTH  2
#define DEMO_INPUTSRC_LENGTH 2
#define DEMO_BITRATE_MAX_LENGTH  3
#define DEMO_ENCTYPE_MAX_LENGTH  2
#define DEMO_INPUTSRC_MAX_LENGTH 3
#define DEMO_TIME_INTERVAL  10000
#define DEVICE_TYPE  3

class maincontroller : public QObject
{
    Q_OBJECT
    enum CpuData{
        Cpu,
        NCpuData
    };
    CPUStat *cpuStat;

    QVector<qreal> cpuList;

    enum MemData{
        videoSrc,
        filter,
        NMemData
    };
    QVector<qreal> videoSrcList;
    QVector<qreal> filterList;

    QObject * rootobject;

    int isRaw = 1;
    int demoBitRateAry[3];
    int demoEncTypeAry[2];
    int demoBitrate = 0;
    int demoEncoderType = 0;
    int demoIpSource = 0;
    bool demoModeRunning = false;
    int demoAudioEnable = 0;
    QTimer* demoTimer;
    QString demoVsrcTbl[3];
    QString demoBitrateString;


    vgst_enc_params encoderParam[NUMBER_OF_SOURCE];
    vgst_ip_params inputParam[NUMBER_OF_SOURCE];
    vgst_op_params outputParam[NUMBER_OF_SOURCE];
    vgst_aud_params audioParam[NUMBER_OF_SOURCE];
    QVariantList fpsArray;
    QVariantList bitrateArray;

public:
    void rootUIObj(QObject * item);
    bool  validDigit(char *);
    bool isValidIp(char *);
    bool updateBitrate[NUMBER_OF_SOURCE] = {false};
    vgst_cmn_params commonParam;


public slots:
    void inits();
    void closeall();
    bool errorPopup(int);
    void updatecpu(QAbstractSeries *cpu);
    void updateThroughput(QAbstractSeries *videoSrc, QAbstractSeries *accelerator);
    void start_pipeline();
    void stop_pipeline();
    void updateFileBitrate();
    void updateFPS();
    void pollEvent();
    void getLocalIpAddress();
    void uninitAll();
    void freeMemory();
    bool validateHostIp(QString);
    void createStorageDir(QString);
    void getSourceData(int, QVariantList,int, int);
    void getCommonParam(int, int, int);
    void demoModeCall(int,int);
    void videoSrcLoop();
    void stopDemoMode();
    void runDemoMode();
    void demoPollEvent();
    void getVideoType();
    void getPosition();
    void getDuration();
};

#endif // MAINCONTROLLER_H
