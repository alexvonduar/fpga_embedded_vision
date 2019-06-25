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

#include "vgst_split_pipeline.h"

VGST_ERROR_LOG
create_split_pipeline (vgst_ip_params *ip_param, vgst_enc_params *enc_param, vgst_playback *play_ptr) {
    play_ptr->pipeline        = gst_pipeline_new ("vcu-trd");
    if (LIVE_SRC == ip_param->src_type)
      play_ptr->ip_src          = gst_element_factory_make (V4L2_SRC_NAME,    NULL);
    else if (FILE_SRC == ip_param->src_type)
      play_ptr->ip_src          = gst_element_factory_make (FILE_SRC_NAME,    NULL);
    play_ptr->srccapsfilter   = gst_element_factory_make ("capsfilter",     NULL);
    play_ptr->queue           = gst_element_factory_make ("queue",          NULL);
    play_ptr->enc_queue       = gst_element_factory_make ("queue",          NULL);
    play_ptr->enccapsfilter   = gst_element_factory_make ("capsfilter",     NULL);
    play_ptr->videosink       = gst_element_factory_make ("kmssink", NULL);
    play_ptr->fpsdisplaysink  = gst_element_factory_make ("fpsdisplaysink", NULL);
    play_ptr->videosink2      = gst_element_factory_make ("kmssink", NULL);
    play_ptr->fpsdisplaysink2 = gst_element_factory_make ("fpsdisplaysink", NULL);

    play_ptr->tee             = gst_element_factory_make ("tee",NULL);

    if (AVC == enc_param->enc_type) {
      play_ptr->videodec    = gst_element_factory_make (H264_DEC_NAME,      NULL);
      play_ptr->videoenc    = gst_element_factory_make (H264_ENC_NAME,  NULL);
    } else if (HEVC == enc_param->enc_type) {
      play_ptr->videodec    = gst_element_factory_make (H265_DEC_NAME,      NULL);
      play_ptr->videoenc    = gst_element_factory_make (H265_ENC_NAME,  NULL);
    }
    if (!play_ptr->pipeline || !play_ptr->ip_src || !play_ptr->srccapsfilter || !play_ptr->queue || !play_ptr->enc_queue) {
      GST_ERROR ("FAILED to create elements required for split-screen");
      return VGST_ERROR_PIPELINE_CREATE_FAIL;
    }
    if (!play_ptr->enccapsfilter || !play_ptr->videosink || !play_ptr->fpsdisplaysink || !play_ptr->tee || !play_ptr->videoenc \
        || !play_ptr->videodec || !play_ptr->videosink2  || !play_ptr->fpsdisplaysink2) {
      GST_ERROR ("FAILED to create elements required for split-screen");
      return VGST_ERROR_PIPELINE_CREATE_FAIL;
    }
    gst_bin_add_many (GST_BIN(play_ptr->pipeline), play_ptr->ip_src, play_ptr->srccapsfilter, play_ptr->queue, play_ptr->enc_queue,NULL);
    gst_bin_add_many (GST_BIN(play_ptr->pipeline), play_ptr->enccapsfilter, play_ptr->fpsdisplaysink, NULL);
    gst_bin_add_many (GST_BIN(play_ptr->pipeline), play_ptr->videoenc, play_ptr->videodec, play_ptr->tee, NULL);
    gst_bin_add_many (GST_BIN(play_ptr->pipeline), play_ptr->fpsdisplaysink2, NULL);
    return VGST_SUCCESS;
}


void
set_split_screen_property (vgst_application *app, gint index) {
    vgst_ip_params *ip_param = &app->ip_params[index];
    vgst_playback *play_ptr = &app->playback[index];
    vgst_enc_params *enc_param = &app->enc_params[index];
    vgst_cmn_params *cmn_param = app->cmn_params;
    guint num_src = app->cmn_params->num_src;
    guint dec_buffer_cnt = DEFAULT_DEC_BUFFER_CNT/num_src;
    dec_buffer_cnt = dec_buffer_cnt < MIN_DEC_BUFFER_CNT ? MIN_DEC_BUFFER_CNT : DEFAULT_DEC_BUFFER_CNT/num_src;
    GstCaps *srcCaps, *encCaps;

    if (LIVE_SRC == ip_param->src_type) {
      g_object_set (G_OBJECT(play_ptr->ip_src), "io-mode", VGST_V4L2_IO_MODE_DMABUF_EXPORT, NULL);
      g_object_set (G_OBJECT(play_ptr->ip_src), "device", vlib_get_devname(ip_param->device_type), NULL);

      if (!ip_param->raw) {
        g_object_set (G_OBJECT (play_ptr->videoenc),  "gop-length",       enc_param->gop_len,       NULL);
        g_object_set (G_OBJECT (play_ptr->videoenc),  "gop-mode",         enc_param->gop_mode,      NULL);
        g_object_set (G_OBJECT (play_ptr->videoenc),  "low-bandwidth",    enc_param->low_bandwidth, NULL);
        g_object_set (G_OBJECT (play_ptr->videoenc),  "target-bitrate",   enc_param->bitrate,       NULL);
        g_object_set (G_OBJECT (play_ptr->videoenc),  "b-frames",         enc_param->b_frame,       NULL);
        g_object_set (G_OBJECT (play_ptr->videoenc),  "num-slices",       enc_param->slice,         NULL);
        g_object_set (G_OBJECT (play_ptr->videoenc),  "control-rate",     enc_param->rc_mode,       NULL);
        g_object_set (G_OBJECT (play_ptr->videoenc),  "qp-mode",          enc_param->qp_mode,       NULL);
        g_object_set (G_OBJECT (play_ptr->videoenc),  "periodicity-idr",  enc_param->gop_len, NULL );
        if (enc_param->enable_l2Cache) {
          g_object_set (G_OBJECT (play_ptr->videoenc),  "prefetch-buffer",  enc_param->enable_l2Cache, NULL);
        }
        if (enc_param->rc_mode == CBR)
          g_object_set (G_OBJECT (play_ptr->videoenc), "filler-data",      enc_param->filler_data,   NULL);

        g_object_set (G_OBJECT (play_ptr->videodec),  "internal-entropy-buffers",  dec_buffer_cnt,  NULL );
        gchar * profile;
        profile = enc_param->profile == BASELINE_PROFILE ? "baseline" : enc_param->profile == MAIN_PROFILE ? "main" : "high";
        if (AVC == enc_param->enc_type) {
          encCaps  = gst_caps_new_simple ("video/x-h264",
                                          "width",     G_TYPE_INT,        ip_param->width,
                                          "height",    G_TYPE_INT,        ip_param->height,
                                          "profile",   G_TYPE_STRING,     profile,
                                          NULL);
        } else if (HEVC == enc_param->enc_type) {
          encCaps  = gst_caps_new_simple ("video/x-h265",
                                          "width",     G_TYPE_INT,        ip_param->width,
                                          "height",    G_TYPE_INT,        ip_param->height,
                                          "profile",   G_TYPE_STRING,     profile,
                                          NULL);
        }
        GST_DEBUG ("new Caps for enc capsfilter %s",gst_caps_to_string(encCaps));
        g_object_set (G_OBJECT (play_ptr->enccapsfilter),  "caps",  encCaps, NULL);
        gst_caps_unref (encCaps);
      }
    }
    gchar * format;
    format = ip_param->format == NV16 ? "NV16" : "NV12";
    srcCaps  = gst_caps_new_simple ("video/x-raw",
                           "width",     G_TYPE_INT,        ip_param->width,
                           "height",    G_TYPE_INT,        ip_param->height,
                           "format",    G_TYPE_STRING,     format,
                           "framerate", GST_TYPE_FRACTION, cmn_param->frame_rate, MAX_FRAME_RATE_DENOM,
                           NULL);

    GST_DEBUG ("Caps for src capsfilter %s",gst_caps_to_string(srcCaps));
    g_object_set (G_OBJECT (play_ptr->srccapsfilter),  "caps",  srcCaps, NULL);
    gst_caps_unref (srcCaps);

    if (play_ptr->queue) {
      g_object_set (G_OBJECT (play_ptr->queue), "max-size-bytes", 0, NULL);
    }
    if (play_ptr->enc_queue) {
      g_object_set (G_OBJECT (play_ptr->enc_queue), "max-size-bytes", 0, NULL);
    }
    g_object_set (G_OBJECT (play_ptr->fpsdisplaysink), "fps-update-interval",     FPS_UPDATE_INTERVAL, NULL);
    g_object_set (G_OBJECT (play_ptr->fpsdisplaysink), "signal-fps-measurements", TRUE, NULL);
    g_object_set (G_OBJECT (play_ptr->fpsdisplaysink), "text-overlay",            FALSE, NULL);
    g_object_set (G_OBJECT (play_ptr->fpsdisplaysink), "video-sink",              play_ptr->videosink, NULL);
    g_object_set (G_OBJECT (play_ptr->videosink),      "bus-id",                  MIXER_BUS_ID, NULL);
    g_object_set (G_OBJECT (play_ptr->videosink),      "plane-id",                cmn_param->plane_id, NULL);
    g_signal_connect (play_ptr->fpsdisplaysink,        "fps-measurements",        G_CALLBACK (on_fps_measurement), &play_ptr->fps_num[0]);

    cmn_param->plane_id++;
    g_object_set (G_OBJECT (play_ptr->fpsdisplaysink2), "fps-update-interval",     FPS_UPDATE_INTERVAL, NULL);
    g_object_set (G_OBJECT (play_ptr->fpsdisplaysink2), "signal-fps-measurements", TRUE, NULL);
    g_object_set (G_OBJECT (play_ptr->fpsdisplaysink2), "text-overlay",            FALSE, NULL);
    g_object_set (G_OBJECT (play_ptr->fpsdisplaysink2), "video-sink",              play_ptr->videosink2, NULL);
    g_object_set (G_OBJECT (play_ptr->videosink2),      "bus-id",                  MIXER_BUS_ID, NULL);
    g_object_set (G_OBJECT (play_ptr->videosink2),      "plane-id",                cmn_param->plane_id, NULL);
    g_signal_connect (play_ptr->fpsdisplaysink2,        "fps-measurements",        G_CALLBACK (on_fps_measurement), &play_ptr->fps_num[1]);
    cmn_param->plane_id++;
}


VGST_ERROR_LOG
link_split_screen_elements (vgst_ip_params *ip_param, vgst_playback *play_ptr) {
    gchar *name1, *name2;
    gint ret = VGST_SUCCESS;
    if (play_ptr->tee) {
      play_ptr->pad = gst_element_get_request_pad(play_ptr->tee, "src_1");
      name1 = gst_pad_get_name(play_ptr->pad);
      play_ptr->pad2 = gst_element_get_request_pad(play_ptr->tee, "src_2");
      name2 = gst_pad_get_name(play_ptr->pad2);
    }
    if (!gst_element_link_many (play_ptr->ip_src, play_ptr->srccapsfilter, play_ptr->tee, NULL)) {
      GST_ERROR ("Error linking for ip_src --> capsfilter --> tee");
      ret = VGST_ERROR_PIPELINE_LINKING_FAIL;
      goto CLEAN_UP;
    } else {
      GST_DEBUG ("Linked for ip_src --> capsfilter --> tee successfully");
    }
    if (!gst_element_link_pads(play_ptr->tee, name1, play_ptr->videoenc, "sink")) {
      GST_ERROR ("Error linking for tee --> queue");
      ret = VGST_ERROR_PIPELINE_LINKING_FAIL;
      goto CLEAN_UP;
    } else {
      GST_DEBUG ("Linked for tee --> queue successfully");
    }
    if (!gst_element_link_pads(play_ptr->tee, name2, play_ptr->enc_queue, "sink")) {
      GST_ERROR ("Error linking for tee --> enc_queue");
      ret = VGST_ERROR_PIPELINE_LINKING_FAIL;
      goto CLEAN_UP;
    } else {
      GST_DEBUG ("Linked for tee --> enc_queue successfully");
    }
    if (!gst_element_link_many (play_ptr->enc_queue, play_ptr->fpsdisplaysink2, NULL)) {
      GST_ERROR ("Error linking for enc_queue --> fpsdisplaysink2");
      ret = VGST_ERROR_PIPELINE_LINKING_FAIL;
      goto CLEAN_UP;
    } else {
      GST_DEBUG ("Linked for enc_queue --> fpsdisplaysink2 successfully");
    }

    if (!gst_element_link_many (play_ptr->videoenc, play_ptr->enccapsfilter, play_ptr->videodec, play_ptr->queue, play_ptr->fpsdisplaysink, NULL)) {
      GST_ERROR ("Error linking for videoenc --> enccapsfilter --> videodec --> queue --> sink");
      ret = VGST_ERROR_PIPELINE_LINKING_FAIL;
      goto CLEAN_UP;
    } else {
      GST_DEBUG ("Linked for videoenc --> enccapsfilter --> videodec --> queue --> sink successfully");
    }

CLEAN_UP :
    if (name1)
      g_free (name1);
    if (name2)
      g_free (name2);

    return ret;
}

