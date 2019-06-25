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
 * This file implements GUI helper functions.
 */

#include "maincontroller.h"
#include <unistd.h>
#include <gst/gst.h>
#include "perfapm.h"
#include <QHostAddress>
#include <QNetworkInterface>
#include <QNetworkAddressEntry>
#include <dirop.h>
#include <math.h>
#include<QDebug>
void maincontroller :: inits(){
    demoTimer = new QTimer(this);
    connect(demoTimer, SIGNAL(timeout()), this, SLOT(videoSrcLoop()));
    vgst_init();
    memset(&inputParam, 0, sizeof(inputParam));
    memset(&encoderParam, 0, sizeof(encoderParam));
    memset(&outputParam, 0, sizeof(outputParam));
    memset(&audioParam, 0, sizeof(audioParam));
    cpuStat = new CPUStat("cpu");
    perf_monitor_init();

    demoBitRateAry[0] = 60;
    demoBitRateAry[1] = 30;
    demoBitRateAry[2] = 10;

    demoVsrcTbl[0] = QString("TPG");
    demoVsrcTbl[1] = QString("MIPI");
    demoVsrcTbl[2] = QString("HDMI-Rx");
}
void maincontroller :: rootUIObj(QObject * item){
    rootobject = item;
}
bool maincontroller:: errorPopup(int errorno){
    if(errorno == VGST_SUCCESS){
        return false;
    }
    QVariant errorName = QString("Error");
    rootobject->setProperty("errorNameText",QVariant(errorName));
    for(unsigned int i = 0; i<commonParam.num_src;i++){
    QVariant errorMsg = QString::fromUtf8(vgst_error_to_string((VGST_ERROR_LOG)errorno,i));
    rootobject->setProperty("errorMessageText",QVariant(errorMsg));
    }
    return true;
}

void maincontroller::closeall() {
    perf_monitor_deinit();
}

void maincontroller :: updatecpu( QAbstractSeries *cpu) {

    double data[NCpuData];

    cpuStat->statistic(data[Cpu]);

    QString cpus;
    cpus.sprintf("CPU Utilization (%.2f%%)",data[Cpu]);

    QXYSeries *cpuSeries = static_cast<QXYSeries *>(cpu);

    cpuSeries->setName(cpus);

    if(cpuList.length()>60){
        cpuList.removeFirst();
    }

    cpuList.append(data[Cpu]);

    QVector<QPointF> cpupoints;


    for(int p = 0; p < cpuList.length(); p++){
        cpupoints.append(QPointF(p,cpuList.at(p)));
    }
    cpuSeries->replace(cpupoints);
}

void maincontroller :: updateThroughput(QAbstractSeries *videoSrcAS, QAbstractSeries *acceleratorAS){
    double data[NMemData];
    QXYSeries *videoSrcSeries = static_cast<QXYSeries *>(videoSrcAS);
    QXYSeries *acceleratorSeries = static_cast<QXYSeries *>(acceleratorAS);

    data[videoSrc] = (float)((perf_monitor_get_rd_wr_cnt(E_APM0) + perf_monitor_get_rd_wr_cnt(E_APM1))* BYTE_TO_GBIT);
    data[filter] = (float)((perf_monitor_get_rd_wr_cnt(E_APM2) + perf_monitor_get_rd_wr_cnt(E_APM3))* BYTE_TO_GBIT);
    if(videoSrcList.length() > 60){
        videoSrcList.removeFirst();
        filterList.removeFirst();
    }
    videoSrcList.append(data[videoSrc]);
    filterList.append(data[filter]);

    QString str1;
    str1.sprintf("Encoder Memory Bandwidth (%2.2f Gbps)", data[videoSrc]);
    QString str2;
    str2.sprintf("Decoder Memory Bandwidth (%2.2f Gbps)", data[filter]);

    videoSrcSeries->setName(str1);
    acceleratorSeries->setName(str2);

    QVector < QPointF > videoSrcpoints;
    QVector < QPointF > accelpoints;

    for(int p = 0; p < videoSrcList.length(); p++){
        videoSrcpoints.append(QPointF(p, videoSrcList.at(p)));
        accelpoints.append(QPointF(p, filterList.at(p)));
    }
    videoSrcSeries->replace(videoSrcpoints);
    acceleratorSeries->replace(accelpoints);
}

void maincontroller :: start_pipeline(){
#ifdef ENABLE_DEBUG_MODE
   unsigned int i;
   for(i=0;i<commonParam.num_src;i++){
       qDebug()<<"common param num_src:  "<<commonParam.num_src;
       qDebug()<<"common param sink_type:  "<<commonParam.sink_type;
       qDebug()<<"common param monitor_refresh_rate:  "<<commonParam.frame_rate;
       qDebug()<< "encode param bitrate:  "<<encoderParam[i].bitrate;
       qDebug()<<"common param driver_type:  "<<commonParam.driver_type;
       qDebug()<<"encode param b_frame:  "<<encoderParam[i].b_frame;
       qDebug()<<"encode param enc_type:  "<<encoderParam[i].enc_type;
       qDebug()<<"encode param gop_len:  "<<encoderParam[i].gop_len;
       qDebug()<<"encode param profile:  "<<encoderParam[i].profile;
       qDebug()<<"encode param qpMode:  "<<encoderParam[i].qp_mode;
       qDebug()<<"encode param rc_mode:  "<<encoderParam[i].rc_mode;
       qDebug()<<"encode param enable/disable_l2Cache:  "<<encoderParam[i].enable_l2Cache;
       qDebug()<<"encode param low_BandWidth:  "<<encoderParam[i].low_bandwidth;
       qDebug()<<"encode param filler_Data:  "<<encoderParam[i].filler_data;
       qDebug()<<"encode param gop_mode:  "<<encoderParam[i].gop_mode;
       qDebug()<<"encode param slice:  "<<encoderParam[i].slice;
       qDebug()<<"encode param latency_mode:  "<<encoderParam[i].latency_mode;
       qDebug()<<"input param format:  "<<inputParam[i].format;
       qDebug()<<"input param raw:  "<<inputParam[i].raw;
       qDebug()<<"input param src:  "<<inputParam[i].src_type;
       qDebug()<<"input param device_type:  "<<inputParam[i].device_type;
       qDebug()<<"input param enable scd: "<<inputParam[i].enable_scd;
       if(inputParam[i].device_type == DEVICE_TYPE){
           qDebug()<<"audio param audio format:  "<<audioParam[i].format;
           qDebug()<<"audio param audio enable/disable:  "<<audioParam[i].enable_audio;
           qDebug()<<"audio param  channel:  "<<audioParam[i].channel;
           qDebug()<<"audio param sampling rate:  "<<audioParam[i].sampling_rate;
           qDebug()<<"audio param  volume:  "<<audioParam[i].volume;
           qDebug()<<"audio param source:  "<<audioParam[i].audio_in;
           qDebug()<<"audio param render:  "<<audioParam[i].audio_out;

       }
       qDebug()<<"input param uri:  "<<inputParam[i].uri;
       qDebug()<<"input param height:  "<<inputParam[i].height;
       qDebug()<<"input param width:  "<<inputParam[i].width;
       qDebug()<<"output param file_out:  "<<outputParam[i].file_out;
       qDebug()<<"output param host_ip:  "<<outputParam[i].host_ip;
       qDebug()<<"output param duration:  "<<outputParam[i].duration;
       qDebug()<<"output param port_num:  "<<outputParam[i].port_num;
   }
#endif
    int err = vgst_config_options(encoderParam, inputParam, outputParam, &commonParam, audioParam);
    if(errorPopup(err)){
        rootobject->setProperty("play", false);
        return;
    }
    err = vgst_start_pipeline();
    if(errorPopup(err)){
        bitrateArray.clear();
        rootobject->setProperty("play", false);
        return;
    }else{
        rootobject->setProperty("play", true);
    }
}

void maincontroller :: stop_pipeline(){
    int err = vgst_stop_pipeline();
    if(errorPopup(err)){
        rootobject->setProperty("play", true);
        return;
    }else{

        rootobject->setProperty("play", false);
        for(int i = 0; i<NUMBER_OF_SOURCE; i++){
            updateBitrate[i] = false;
        }
    }
}
void maincontroller :: updateFPS(){
    int index = 0;
    QVariantMap mapFps;
    fpsArray.clear();
    unsigned int getFpsArr[2] = {0};
    for(index = 0; index < (int)commonParam.num_src; index++){
        vgst_get_fps(index, &getFpsArr[0]);
        mapFps.insert("fpsValue", getFpsArr[0]);
        fpsArray.append(mapFps);
        if(commonParam.sink_type == SPLIT_SCREEN){
            mapFps.insert("fpsValue", getFpsArr[1]);
            fpsArray.append(mapFps);
        }
    }
    rootobject->setProperty("fpsArray", fpsArray);
}
void maincontroller :: getVideoType(){
    int index = 0;
    int videoType = 0;
    for(index = 0; index < (int)commonParam.num_src; index++){
        if((commonParam.sink_type == DISPLAY)){
            if((inputParam[index].src_type== FILE_SRC)){
                videoType = vgst_get_video_type(index);
            }
        }
        QString videoTypeDisplayStr =  videoType == 2 ? "HEVC" : "AVC";
        rootobject->setProperty("videoEncoderType", QVariant(videoTypeDisplayStr));
    }
}
void maincontroller :: updateFileBitrate(){
    int index = 0;
    QVariantMap mapBitrate;
    int bitrate = 0;
    bool updateBitrateArr = true;
    for(index = 0; index < (int)commonParam.num_src; index++){
        if(!updateBitrate[index]){
            updateBitrateArr = false;
            bitrateArray.clear();
        }
    }
    for(index = 0; index < (int)commonParam.num_src; index++){
        if(!updateBitrateArr && (commonParam.sink_type == DISPLAY)){
            if((inputParam[index].src_type== FILE_SRC || inputParam[index].src_type== STREAMING_SRC)){
                bitrate = vgst_get_bitrate(index);
                if(bitrate){
                    mapBitrate.insert("updateBitrate", QString::number(1));
                    updateBitrate[index] = true;
                }else{
                    updateBitrate[index] = false;
                    mapBitrate.insert("updateBitrate", QString::number(0));
                }
                if(round(BIT_TO_MBIT(bitrate)) <= 0.0){
                    mapBitrate.insert("fileBitrate", QString::number(round(BIT_TO_KBIT(bitrate))).append("Kbps"));
                }else{
                    mapBitrate.insert("fileBitrate", QString::number(round(BIT_TO_MBIT(bitrate))).append("Mbps"));
                }

            }else{
                updateBitrate[index] = true;
                mapBitrate.insert("fileBitrate", QString::number(round(BIT_TO_MBIT(bitrate))).append("Mbps"));
                mapBitrate.insert("updateBitrate", QString::number(1));
            }
            bitrateArray.append(mapBitrate);
        }
        rootobject->setProperty("bitrateArray", bitrateArray);
    }
}

void maincontroller :: pollEvent(){
    int arg = 0;
    unsigned int i=0;
    for(i=0; i<commonParam.num_src; i++){
        switch (vgst_poll_event(&arg, i)) {
    case EVENT_ERROR:
        if(errorPopup(arg)){
            rootobject->setProperty("errorFound", true);
            return;
        }
        break;
    case EVENT_EOS:
        stop_pipeline();
        break;
    default:
        break;
    }
    }
}
void maincontroller :: getPosition(){
    gint64 position;
    for(unsigned int i=0; i<commonParam.num_src; i++){
        if (RECORD == commonParam.sink_type || DISPLAY == commonParam.sink_type) {
            vgst_get_position (i, &position);
            rootobject->setProperty("recordPositionTime",  (quint64(position)));
        }
    }
}
void maincontroller :: getDuration(){
    gint64 videoDuration;
    for(unsigned int i=0; i<commonParam.num_src; i++){
        if (DISPLAY == commonParam.sink_type){
            vgst_get_duration(i,&videoDuration);
            rootobject->setProperty("playbackDuration",(quint64(videoDuration)));
        }
    }
}

void maincontroller :: demoPollEvent(){
    int arg = 0;
    unsigned int i=0;
    for(i=0; i<commonParam.num_src; i++){
        switch (vgst_poll_event(&arg, i)) {
        case EVENT_ERROR:
            if(demoModeRunning){
                demoTimer->stop();
                demoBitrate = DEMO_BITRATE_LENGTH+1;
                demoEncoderType = DEMO_ENCTYPE_LENGTH+1;
                videoSrcLoop();
                demoTimer->start(DEMO_TIME_INTERVAL);
            }
            break;
        default:
            break;
        }
    }
}
void maincontroller :: getLocalIpAddress(){
    QList<QNetworkInterface> interface = QNetworkInterface::allInterfaces();
    for (int i = 0; i <interface.size(); i++){
        QNetworkInterface item = interface.at(i);
        QList<QNetworkAddressEntry> entryList = item.addressEntries();
        if(entryList.size() && (item.name().toStdString() == "eth0")){
            if(item.flags().testFlag(item.IsRunning)){
                if((entryList.at(0).ip().toString().size() >= IPV4_MIN_LENGTH) && (entryList.at(0).ip().toString().size() <= IPV4_MAX_LENGTH)){
                    rootobject->setProperty("ipAddress", entryList.at(0).ip().toString());
                    rootobject->setProperty("isStreamUp", true);
                }else{
                    rootobject->setProperty("isStreamUp", false);
                }
            }else{
                rootobject->setProperty("isStreamUp", false);
            }
        }
    }
}

void maincontroller :: freeMemory(){
    for(int i = 0; i < NUMBER_OF_SOURCE; i++){
        free(inputParam[i].uri);
        inputParam[i].uri = NULL;
        free(outputParam[i].file_out);
        outputParam[i].file_out = NULL;
        free(outputParam[i].host_ip);
        outputParam[i].host_ip = NULL;
    }
}

void maincontroller :: uninitAll(){
    vgst_uninit();
}

bool maincontroller :: validateHostIp(QString textToCheck){
    if(textToCheck.count(QLatin1Char('.')) !=3){
        return false;
    }else{
        return isValidIp(textToCheck.toLatin1().data());
    }
}

bool maincontroller :: validDigit(char *ip_str){
    while (*ip_str){
        if (*ip_str >= '0' && *ip_str <= '9')
            ++ip_str;
        else
            return false;
    }
    return true;
}

bool maincontroller :: isValidIp(char *ip_str){
    int num, dots = 0;
    char *ptr;

    if (ip_str == NULL)
        return false;

    ptr = strtok(ip_str, ".");

    if (ptr == NULL || strlen(ptr) > 3)
        return false;

    while (ptr){
        if(strlen(ptr) > 3){
            return false;
        }
        if (!validDigit(ptr))
            return false;

        num = atoi(ptr);

        if (num >= 0 && num <= 255) {
            ptr = strtok(NULL, ".");
            if (ptr != NULL)
                ++dots;
        } else
            return false;
    }

    if (dots != 3)
        return false;
    return true;
}

void maincontroller :: createStorageDir(QString path){
    QDir opDir(path);
    opDir.mkpath(".");
}


void maincontroller :: getCommonParam(int num_src, int sink_type, int frameRate){
    commonParam.num_src = num_src;
    commonParam.sink_type = sink_type;
    commonParam.frame_rate = frameRate;
}

void maincontroller :: getSourceData(int numSrc, QVariantList settingsList, int width, int height){
    for(int i = 0; i < numSrc; i++){
        QVariantMap input = settingsList.at(i).toMap();
        int bitrate = (input["bitrate"].toInt()) * (((input["bitrateUnit"].toInt() == 1) ? MBPS_MULTIPLIER : KBPS_MULTIPLIER));

        encoderParam[i].bitrate = bitrate;
        encoderParam[i].b_frame = input["bFrame"].toInt();
        encoderParam[i].enc_type = input["encoderType"].toInt();
        encoderParam[i].gop_len = input["gopLength"].toInt();
        encoderParam[i].profile = input["profile"].toInt();
        if(0 == input["qpMode"].toInt()){
            encoderParam[i].qp_mode = UNIFORM;
        }else{
            encoderParam[i].qp_mode = AUTO;
        }
        encoderParam[i].rc_mode = input["rateControl"].toInt();
        encoderParam[i].enable_l2Cache = input["l2Cache"].toInt();
        encoderParam[i].low_bandwidth = input["lowBandwidth"].toInt();
        encoderParam[i].filler_data = input["fillerData"].toInt();
        encoderParam[i].gop_mode= input["gopMode"].toInt();
        encoderParam[i].slice = input["sliceCount"].toInt();
        encoderParam[i].latency_mode = input["latencyMode"].toInt();
        inputParam[i].format = input["format"].toInt();
        inputParam[i].raw = input["raw"].toInt();
        inputParam[i].src_type = input["src"].toInt();
        inputParam[i].enable_scd = input["scd"].toInt();
        inputParam[i].device_type = get_by_name((input["deviceType"].toString()).toLatin1().data());
        inputParam[i].uri = g_strdup((input["uri"].toString()).toLatin1().data());
        inputParam[i].height = height;
        inputParam[i].width = width;
        outputParam[i].file_out = g_strdup((input["outputFileName"].toString()).toLatin1().data());
        outputParam[i].host_ip = g_strdup((input["hostIP"].toString()).toLatin1().data());
        outputParam[i].duration = input["fileDuration"].toInt();
        outputParam[i].port_num = input["port"].toInt();
        audioParam[i].format = g_strdup((input["audioFormat"].toString()).toLatin1().data());
        audioParam[i].channel = input["audioChannel"].toInt();
        audioParam[i].enable_audio = input["audioEnable"].toInt();
        audioParam[i].sampling_rate = input["samplingRate"].toInt();
        audioParam[i].volume = input["volumeLevel"].toDouble();
        if (0 == input["renderSelect"].toInt()){
            audioParam[i].audio_out = AUDIO_DP_OUT;
        }else {
            audioParam[i].audio_out = AUDIO_I2S_OUT;
        }
        if (0 == input["sourceSelect"].toInt()){
            audioParam[i].audio_in = AUDIO_HDMI_IN;
        }else {
            audioParam[i].audio_in = AUDIO_I2S_IN;
        }

    }
}
void maincontroller :: demoModeCall(int start,int enableAudio){
    demoAudioEnable = enableAudio;
    if(start){
        demoBitrate = 0;
        demoEncoderType = 0;
        demoIpSource = 0;
        isRaw = 1;
        videoSrcLoop();

    }
    else{
        demoTimer->stop();
        stopDemoMode();
    }
}

void maincontroller ::  videoSrcLoop(){
    stopDemoMode();
    runDemoMode();
}
void maincontroller :: stopDemoMode(){
    if(demoModeRunning){
        // Stop pipeline
        int err = vgst_stop_pipeline();
        if(VGST_SUCCESS != err){
            rootobject->setProperty("demoModeStatus", false);
        }
        demoModeRunning = false;
    }
}
void maincontroller :: runDemoMode(){
    int hasSource = 2 * DEMO_BITRATE_MAX_LENGTH * DEMO_ENCTYPE_MAX_LENGTH * DEMO_INPUTSRC_MAX_LENGTH;   //2 * DEMO_BITRATE_LENGTH * DEMO_ENCTYPE_LENGTH * DEMO_INPUTSRC_LENGTH
    while(1){
        hasSource--;
        if(hasSource <= 0){
            demoModeCall(0,demoAudioEnable);
            QMetaObject::invokeMethod(rootobject, "demoNoSource");
            rootobject->setProperty("demoModeStatus", false);
            return;
        }
        int i = 0;
            if(demoBitrate > DEMO_BITRATE_LENGTH){
                demoBitrate = 0;
                demoEncoderType++;
                if(demoEncoderType > DEMO_ENCTYPE_LENGTH){
                    demoEncoderType = 0;
                    demoIpSource ++;
                    isRaw = 1;
                    if(demoIpSource > DEMO_INPUTSRC_LENGTH){
                        demoIpSource = 0;
                    }
                }
            }
            if(isRaw == 1){
                inputParam[i].raw = 1;
            }else
                inputParam[i].raw = 0;

        int bitrate = demoBitRateAry[demoBitrate] * MBPS_MULTIPLIER;
        encoderParam[i].bitrate = bitrate;
        encoderParam[i].enc_type = demoEncoderType;
        inputParam[i].device_type = get_by_name((demoVsrcTbl[demoIpSource]).toLatin1().data());
        audioParam[i].enable_audio = demoAudioEnable;
        demoBitrate ++;
        if(isRaw == 1){
            demoBitrate = 0;
            isRaw = 0;
        }
        int err = vgst_config_options(encoderParam, inputParam, outputParam, &commonParam, audioParam);
        if(VGST_SUCCESS != err){
            continue;
        }
        // start pipeline
        err = vgst_start_pipeline();
        if(VGST_SUCCESS != err){
            vgst_stop_pipeline();
            continue;
        }
        if(demoModeRunning == false){
            demoTimer->start(DEMO_TIME_INTERVAL);
        }
        demoModeRunning = true;
        demoBitrateString = inputParam[i].raw == 0 ? (QString::number(demoBitRateAry[demoBitrate-1]))+"Mbps" : "NA";
        rootobject->setProperty("demoSourceName", ((demoVsrcTbl[demoIpSource]).toLatin1().data()));
        rootobject->setProperty("demoBitrate",  QVariant(demoBitrateString));
        rootobject->setProperty("demoEncType", inputParam[i].raw == 0 ? (encoderParam[i].enc_type == 2 ? QVariant(QString("HEVC")): QVariant(QString("AVC"))) : QVariant(QString("NA")));
        break;
    }
}
