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
#include <stdio.h>
#include <getopt.h>
#include <errno.h>
#include <stdlib.h>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWidgets/QMainWindow>
#include <QQmlContext>
#include <QtWidgets/QApplication>
#include "dirop.h"
#include <maincontroller.h>
#include <QScreen>
#include "video_cfg.h"
#define MAX_MODES 2
#define HDMI_ID 1

void signalhandler(int sig){
    QCoreApplication::exit(sig);
}
static void usage(const char *argv0)
{
    qDebug("Usage: %s [options]\n", argv0);
    qDebug("-d, --drm-module name   DRM module: 'DP' or 'HDMI' (default: DP)\n");
    qDebug("-h, --help              Show this help screen\n");
    qDebug("-r, --resolution WxH    Width'x'Height (Supported resolutions: 3840x2160,1920x1080)\n\t\t\t\t\t Default: Native resolution of monitor");
}

static struct option opts[] = {
    { "drm-module", required_argument, NULL, 'd' },
    { "help", no_argument, NULL, 'h' },
    { "resolution", required_argument, NULL, 'r' },
    { NULL, 0, NULL, 0 }
};
int main(int argc, char *argv[])
{
    QStringList outputSinkArr = {"Display Port", "Record", "Stream"};
    QStringList controls = {"AVC Low", "AVC Medium", "AVC High", "HEVC Low", "HEVC Medium", "HEVC High", "Custom"};
    QStringList codecType = {"Enc-Dec", "Pass-through", "Enc", "NA"};
    QStringList audioSourceType = {"HDMI","I2S"};
    QStringList audioRenderType = {"DP","I2S"};
    QStringList scdType = {"Disable","Enable"};

    float resolutionFraction;
    int ret, i, c;
    int bestMode = 1;
    const int width[MAX_MODES] = {3840, 1920};
    const int height[MAX_MODES] = {2160, 1080};
    struct vlib_config_data cfg;
    memset(&cfg, 0, sizeof(cfg));
    cfg.width_in = width[0];
    cfg.height_in = height[0];
    size_t vr;

    while ((c = getopt_long(argc, argv, "d:hpr:", opts, NULL)) != -1) {
        switch (c) {
        case 'd':
            sscanf(optarg, "%u", &cfg.display_id);
            if(cfg.display_id == HDMI_ID)
                outputSinkArr.replace(0,"HDMI-Tx");
            break;
        case 'h':
            usage(argv[0]);
            return 0;
        case 'r':
            ret = sscanf(optarg, "%ux%u", &cfg.width_in, &cfg.height_in);
            if (ret != 2) {
                qDebug("Invalid size '%s'\n", optarg);
                return 1;
            }
            bestMode = 0;
            break;
        default:
            qDebug("Invalid option -%c\n", c);
            qDebug("Run %s -h for help\n", argv[0]);
            return 1;
        }
    }

    /* Find and set best supported mode */
    for (i = 0; i < MAX_MODES; i++) {
        if (bestMode) {
            ret = vlib_drm_try_mode(cfg.display_id, width[i],height[i], &vr);
            if (ret == VLIB_SUCCESS) {
                cfg.width_in = width[i];
                cfg.height_in = height[i];
                break;
            }
        }
        /*check whether user input is matched to native resolution of monitor*/
        else if (cfg.width_in == width[i] && cfg.height_in == height[i]) {
            ret = vlib_drm_try_mode(cfg.display_id, cfg.width_in,
                                    cfg.height_in, &vr);
            if (ret == VLIB_SUCCESS)
                break;
            else{
                qDebug()<<"Input resolution"<<cfg.width_in<<"x"<<cfg.height_in<<"not supported by monitor";
                return 1;
            }
        }
    }
    if (i == MAX_MODES) {
       qDebug("Only supported resolutions are: 4kp and 1080p\n");
        return 1;
    }
    else {
        /* Set multiplier based on 1080p reference resolution height[1] */
        resolutionFraction = (float) cfg.height_in / height[1];
        qputenv("QT_SCALE_FACTOR",QString::number(resolutionFraction).toUtf8());
    }

    vlib_drm_find_preferred_mode(&cfg);

    QApplication qapp(argc, argv);
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQmlApplicationEngine engine;

    signal(SIGINT, signalhandler);

    QVariantList numSrcList;
    QVariantMap mapNumSrc;
    for(int i = 0; i < NUMBER_OF_SOURCE; i++){
        mapNumSrc.insert("shortName", (i+1));
        numSrcList.append(mapNumSrc);
    }
    QVariantList sourceList;
    QVariantMap map;
    QVariantMap filemap;
    QVariantMap streammap;
    filemap.insert("shortName", "FILE");
    streammap.insert("shortName", "STREAM-IN");
    for(int i = 0; i < sources_count(); i++){
        map.insert("shortName", QString(get_name_of_source_at(i)));
        sourceList.append(map);
    }
    sourceList.append(filemap);
    sourceList.append(streammap);
    if(cfg.height_in==height[1] && cfg.width_in==width[1]){
        engine.rootContext()->setContextProperty("refreshRate",true);
    }
    else{
        engine.rootContext()->setContextProperty("refreshRate",false);
    }
    QVariantList outputSinkList;
    QVariantMap mapOPLst;
    for(int i = 0; i < outputSinkArr.size(); i++){
        mapOPLst.insert("shortName", outputSinkArr[i]);
        outputSinkList.append(mapOPLst);
    }
    QVariantList controlList;
    QVariantMap mapCtrl;
    for(int i = 0; i < controls.size(); i++){
        mapCtrl.insert("shortName", controls[i]);
        controlList.append(mapCtrl);
    }

    QVariantList codecList;
    QVariantMap mapCodec;
    for(int i = 0; i < codecType.size(); i++){
        mapCodec.insert("shortName", codecType[i]);
        codecList.append(mapCodec);
    }

    QVariantList audioSourceList;
    QVariantMap mapAudioSource;
    for(int i=0; i<audioSourceType.size();i++){
        mapAudioSource.insert("shortName", audioSourceType[i]);
        audioSourceList.append(mapAudioSource);
    }
    QVariantList audioRenderList;
    QVariantMap mapAudioRender;
    for(int i=0; i<audioRenderType.size();i++){
        mapAudioRender.insert("shortName",audioRenderType[i]);
        audioRenderList.append(mapAudioRender);
    }
    QVariantList scdList;
    QVariantMap mapScd;
    for(int i=0;i<scdType.size();i++){
        mapScd.insert("shortName",scdType[i]);
        scdList.append(mapScd);

    }

    engine.rootContext()->setContextProperty("resolutionFactor",resolutionFraction);
    engine.rootContext()->setContextProperty("numSourceList",QVariant::fromValue(numSrcList));
    engine.rootContext()->setContextProperty("videoSourceList",QVariant::fromValue(sourceList));
    engine.rootContext()->setContextProperty("outputSinkList",QVariant::fromValue(outputSinkList));
    engine.rootContext()->setContextProperty("controlList",QVariant::fromValue(controlList));
    engine.rootContext()->setContextProperty("codecList",QVariant::fromValue(codecList));
    engine.rootContext()->setContextProperty("audioSourceList",QVariant::fromValue(audioSourceList));
    engine.rootContext()->setContextProperty("audioRenderList",QVariant::fromValue(audioRenderList));
    engine.rootContext()->setContextProperty("scdList",QVariant::fromValue(scdList));

    QDir opDir(ROOT_FILE_PATH "/" RECORD_DIR);
    opDir.mkpath(".");
    engine.rootContext()->setContextProperty("rootWidth",cfg.width_in);
    engine.rootContext()->setContextProperty("rootHeight",cfg.height_in);
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));

    QQmlContext *ctx = engine.rootContext();
    maincontroller mc;

    mc.inits();
    mc.rootUIObj(engine.rootObjects().first());
    ctx->setContextProperty("controller", &mc);
    if(argv[1] && (strcmp(argv[1], "-d") == 0)){
        if(argv[2]){
            mc.commonParam.driver_type = atoi(argv[2]);
        }
    }
    else{
        mc.commonParam.driver_type =0;
    }


    QObject :: connect(&engine, SIGNAL(quit()), qApp, SLOT(quit()) );
    QObject :: connect( qApp, SIGNAL(aboutToQuit()),&mc,SLOT(closeall()));

    DirOp currDir;
    currDir.currentDir.setPath(ROOT_FILE_PATH);
    ctx->setContextProperty("dirOPS", &currDir);
    return qapp.exec();
}
