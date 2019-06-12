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


#include "vgst_utils.h"
#include "vgst_pipeline.h"
#include "vgst_split_pipeline.h"

vgst_application app;

GST_DEBUG_CATEGORY_EXTERN (vgst_lib);
#define GST_CAT_DEFAULT vgst_lib

void
init_struct_params (vgst_enc_params *enc_param, vgst_ip_params *ip_param, vgst_op_params *op_param,
        vgst_cmn_params *cmn_param, vgst_aud_params *aud_param) {
    memset (&app, 0, sizeof(vgst_application));
    app.enc_params = enc_param;
    app.ip_params  = ip_param;
    app.op_params  = op_param;
    app.cmn_params = cmn_param;
    app.aud_params = aud_param;
}

const gchar *
error_to_string (VGST_ERROR_LOG error_code, gint index) {
    switch (error_code) {
    case VGST_SUCCESS :
      return "Success";
    case VGST_ERROR_FILE_IO :
      return "File I/O Error";
    case VGST_ERROR_GOP_NOT_SUPPORTED :
      return "Gop length must be multiple of b-frames+1";
    case VGST_ERROR_PIPELINE_CREATE_FAIL :
      return "pipeline creation failed";
    case VGST_ERROR_PIPELINE_LINKING_FAIL :
      return "pipeline linking failed";
    case VGST_ERROR_STATE_CHANGE_FAIL :
      return "state change failed";
    case VGST_ERROR_B_FRAME_RANGE_MISMATCH :
      return "b-frames should be in the range of 0-4";
    case VGST_ERROR_GOP_LENGTH_RANGE_MISMATCH :
      return "GoP length should be in the range of 1 -1000";
    case VGST_ERROR_ENCODER_TYPE_NOT_SUPPORTED :
      return "Encoder type not supported";
    case VGST_ERROR_SRC_TYPE_NOT_SUPPORTED :
      return "Source type not supported";
    case VGST_ERROR_FORMAT_NOT_SUPPORTED :
      return "format type not supported";
    case VGST_ERROR_SRC_COUNT_INVALID :
      return "source count invalid";
    case VGST_ERROR_RESOLUTION_NOT_SUPPORTED :
      return "Resolution WxH should be 3840x2160";
    case VGST_ERROR_DEVICE_TYPE_INVALID :
      return "Device type invalid";
    case VGST_ERROR_PIPELINE_NOT_INITIALIZED :
      return "pipeline not initialized";
    case VGST_ERROR_SET_ENC_BUF_ENV_FAILED :
      return "Encoder buffer env setting failed";
    case VGST_ERROR_RUN_TIME_PIPELINE_FAILED :
      if (app.playback[index].err_msg)
        return app.playback[index].err_msg;
      break;
    case VGST_ERROR_MULTI_STREAM_FAIL:
      return "Multi stream on DP or SDI not supported";
    case VGST_ERROR_SPLIT_SCREEN_FAIL :
      return "Split Screen on DP or SDI not supported";
    case VGST_ERROR_SPLIT_SCREEN_NOT_SUPPORTED:
      return "Split screen is not supported for more than 1-4kp/2-1080p input source";
    case VGST_ERROR_DRIVER_TYPE_MISMATCH :
      return "driver type mismatched";
    case VGST_ERROR_SLICE_RANGE_MISMATCH :
      return "Slice range mismatched";
    case VGST_ERROR_BITRATE_NOT_SUPPORTED :
      return "bitrate not supported";
    case VGST_ERROR_QPMODE_NOT_SUPPORTED :
      return "Qp mode not supported";
    case VGST_ERROR_PROFILE_NOT_SUPPORTED :
      return "Profile not supported";
    case VGST_ERROR_PROFILE_FORMAT_NOT_SUPPORTED :
      return "Profile and Format not supported";
    case VGST_ERROR_RCMODE_NOT_SUPPORTED :
      return "Rate control mode not supported";
    case VGST_ERROR_PORT_NUM_RANGE_MISMATCH :
      return "Port number range mismatched";
    case VGST_ERROR_OVERLAY_CREATION_FAIL :
      return "Failed to create overlay, multi-stream pipeline failed";
    case VGST_ERROR_APP_PTR_NULL :
      return "Application pointers are null";
    case VGST_ERROR_GOP_MODE_NOT_SUPPORTED :
      return "Gop-mode not supported";
    case VGST_ERROR_B_FRAME_LOW_LATENCY_MODE_NOT_SUPPORTED :
      return "b-frame in low_latency or sub_frame latency mode not supported";
    case VGST_ERROR_LATENCY_MODE_NOT_SUPPORTED :
      return "Latency mode not supported";
    case VGST_ERROR_INPUT_OPTIONS_INVALID :
      return "Input options are incorrect";
    case VGST_ERROR_4KP60_PARAM_NOT_SUPPORTED :
      return "(b-frame>0) (gop-mode=low_delay_b) (l2-cache=false) in 1-4kp60 not supported";
    case VGST_ERROR_2_4KP30_PARAM_NOT_SUPPORTED :
      return "(b-frame>0) (gop-mode=low_delay_b) (l2-cache=false) (bitrate>30Mbps) (latency-mode=SubFrame) in 2-4kp30 not supported";
    case VGST_ERROR_4_1080P60_PARAM_NOT_SUPPORTED :
      return "(b-frame>0) (gop-mode=low_delay_b) (l2-cache=false) (bitrate>15Mbps) (latency-mode=SubFrame) in 4-1080p60 not supported";
    case VGST_ERROR_TPG_IN_1080P30_NOT_SUPPORTED :
      return "TPG 1080p30 resolution not supported";
    case VGST_ERROR_FILE_IN_MULTISTREAM_NOT_SUPPORTED :
      return "File playback in multi stream not supported";
    case VGST_ERROR_CBR_VBR_SUB_FRAME_LATENCY_NOT_SUPPORTED :
      return "Sub_Frame latency mode is not supported in CBR/VBR rc mode";
    case VGST_ERROR_VBR_IN_STREAMING_NOT_SUPPORTED :
      return "VBR rc is not supported in streaming use case";
    case VGST_ERROR_AUDIO_CHANNEL_NOT_SUPPORTED :
      return "Audio channel not supported";
    case VGST_ERROR_AUDIO_VOLUME_NOT_SUPPORTED :
      return "Audio volume not supported";
    case VGST_ERROR_AUDIO_IN_TYPE_NOT_SUPPORTED :
      return "Audio audio in type is not supported";
    case VGST_ERROR_AUDIO_OUT_TYPE_NOT_SUPPORTED :
      return "Audio out type is not supported";
    case VGST_ERROR_8_1080P30_PARAM_NOT_SUPPORTED :
     return "(b-frame>0) (gop-mode=low_delay_b) (l2-cache=false) (bitrate>7.5Mbps) (latency-mode=SubFrame) in 8-1080p30 not supported";
    case VGST_ERROR_OTHER :
      return "Unknown error";
    }

    vlib_error error = (vlib_error) error_code;
    switch (error) {
      case VLIB_NO_MEDIA_SRC :
        return vlib_error_name (VLIB_NO_MEDIA_SRC);
      case VLIB_ERROR_INIT :
        return vlib_error_name (VLIB_ERROR_INIT);
      case VLIB_ERROR_DEINIT :
        return vlib_error_name (VLIB_ERROR_DEINIT);
      case VLIB_ERROR_SRC_CONFIG :
        return vlib_error_name (VLIB_ERROR_SRC_CONFIG);
      case VLIB_ERROR_HDMIRX_INVALID_STATE :
        return vlib_error_name(VLIB_ERROR_HDMIRX_INVALID_STATE);
      case VLIB_ERROR_HDMIRX_INVALID_RES :
        return vlib_error_name(VLIB_ERROR_HDMIRX_INVALID_RES);
      case VLIB_ERROR_HDMIRX_INVALID_FPS :
        return vlib_error_name(VLIB_ERROR_HDMIRX_INVALID_FPS);
      case VLIB_ERROR_HDMIRX_INVALID_SEQUENCE :
        return vlib_error_name(VLIB_ERROR_HDMIRX_INVALID_SEQUENCE);
      case VLIB_ERROR_SET_FPS :
        return vlib_error_name(VLIB_ERROR_SET_FPS);
      case VLIB_ERROR_MIPI_CONFIG_FAILED :
        return vlib_error_name(VLIB_ERROR_MIPI_CONFIG_FAILED);
      case VLIB_ERROR_INVALID_STATE :
        return vlib_error_name(VLIB_ERROR_INVALID_STATE);
      case VLIB_ERROR_MIPI_NOT_CONNECTED :
        return vlib_error_name(VLIB_ERROR_MIPI_NOT_CONNECTED);
      case VLIB_ERROR_INVALID_RESOLUTION :
        return vlib_error_name(VLIB_ERROR_INVALID_RESOLUTION);
      case VLIB_ERROR_SET_FORMAT_FAILED :
        return vlib_error_name(VLIB_ERROR_SET_FORMAT_FAILED);
      case VLIB_ERROR_GET_FORMAT_FAILED :
        return vlib_error_name(VLIB_ERROR_GET_FORMAT_FAILED);
      case VLIB_ERROR_HDMIRX_1_NOT_AVAILABLE :
        return vlib_error_name(VLIB_ERROR_HDMIRX_1_NOT_AVAILABLE);
      case VLIB_ERROR_HDMIRX_2_NOT_AVAILABLE :
        return vlib_error_name(VLIB_ERROR_HDMIRX_2_NOT_AVAILABLE);
      case VLIB_ERROR_HDMIRX_3_NOT_AVAILABLE :
        return vlib_error_name(VLIB_ERROR_HDMIRX_3_NOT_AVAILABLE);
      case VLIB_ERROR_TPG_1_NOT_AVAILABLE :
        return vlib_error_name(VLIB_ERROR_TPG_1_NOT_AVAILABLE);
      case VLIB_ERROR_SDI_NOT_AVAILABLE :
        return vlib_error_name(VLIB_ERROR_SDI_NOT_AVAILABLE);
      case VLIB_ERROR_SCD_NOT_AVAILABLE :
        return vlib_error_name(VLIB_ERROR_SCD_NOT_AVAILABLE);
      case VLIB_ERROR_DRM_DEVICE_OPEN_FAIL :
        return vlib_error_name(VLIB_ERROR_DRM_DEVICE_OPEN_FAIL);
      case VLIB_ERROR_DRM_MODE_GET_PLANE_RES_FAIL :
        return vlib_error_name(VLIB_ERROR_DRM_MODE_GET_PLANE_RES_FAIL);
      case VLIB_ERROR_DRM_PLANE_NOT_FOUND :
        return vlib_error_name(VLIB_ERROR_DRM_PLANE_NOT_FOUND);
      case VLIB_ERROR_INVALID_DRM_DEVICE :
        return vlib_error_name(VLIB_ERROR_INVALID_DRM_DEVICE);
      default :
        return "Unknown Error";
    }
    return "Unknown Error";
}


void
on_pad_added (GstElement *element,
              GstPad     *pad,
              gpointer   data) {
    gchar *str;
    guint i, index =0;
    vgst_playback *play_ptr = (vgst_playback *)data;
    GstCaps *caps = gst_pad_get_current_caps (pad);
    GstStructure *structure;
    gint width, height;
    str = gst_caps_to_string(caps);

    for (i = 0; i< app.cmn_params->num_src; i++) {
      if (&app.playback[i] == play_ptr) {
        index = i;
        break;
      }
    }
    GST_DEBUG ("Caps value is %s::%d::%d", str, app.aud_params[index].enable_audio, app.cmn_params->driver_type);
    if (g_str_has_prefix (str, "video/")) {
      if (app.cmn_params->sink_type == DISPLAY &&
         (app.cmn_params->driver_type == HDMI_Tx || app.cmn_params->driver_type == SDI_Tx)) {
        structure = gst_caps_get_structure(caps, 0);
        if (structure != NULL) {
          gst_structure_get_int(structure, "width", &width);
          gst_structure_get_int(structure, "height", &height);
          if ((width == MAX_WIDTH/2) && (height == MAX_HEIGHT/2)) {
            g_object_set (G_OBJECT (play_ptr->videosink), "hold-extra-sample", TRUE, NULL);
          }
        }
      }
      if (app.ip_params[index].accelerator) {
        /* There is difference b/w raw data coming from v4l2src and VCU decoder.
           We are distinguishing it by flag raw.
        */
        g_object_set (G_OBJECT (play_ptr->bypass),  "raw",     FALSE,     NULL);
        if (!gst_element_link_many(play_ptr->ip_src, play_ptr->bypass, play_ptr->queue, play_ptr->fpsdisplaysink, NULL)) {
          GST_ERROR ("Error linking for ip_src --> bypass --> queue --> fpsdisplaysink");
        } else {
          GST_DEBUG ("Linked for ip_src --> bypass --> queue --> fpsdisplaysink successfully");
        }
      } else {
        if (!gst_element_link_many(play_ptr->ip_src, play_ptr->queue, play_ptr->fpsdisplaysink, NULL)) {
          GST_ERROR ("Error linking for ip_src --> queue --> fpsdisplaysink");
        } else {
          GST_DEBUG ("Linked for ip_src --> queue --> fpsdisplaysink successfully");
        }
      }
    } else if (g_str_has_prefix (str, "audio/") && app.aud_params[index].enable_audio) {
      if (play_ptr->pipeline && play_ptr->alsasink) {
        gst_bin_add_many (GST_BIN(play_ptr->pipeline), play_ptr->alsasink, NULL);
        GST_DEBUG ("alsasink is added in the pipeline and syncing to patent state");
        gst_element_sync_state_with_parent (play_ptr->alsasink);
      }
      if (DP == app.cmn_params->driver_type) {
        if (!gst_element_link_many(play_ptr->ip_src, play_ptr->volume, play_ptr->audconvert, play_ptr->audresample, play_ptr->alsasink, NULL)) {
          GST_ERROR ("Error linking for ip_src --> volume --> audioconvert --> audioresample --> alsasink");
        } else {
          GST_DEBUG ("Linked for ip_src --> volume --> audioconvert --> audioresample --> alsasink successfully");
        }
      } else if (HDMI_Tx == app.cmn_params->driver_type || SDI_Tx == app.cmn_params->driver_type) {
        if (!gst_element_link_many(play_ptr->ip_src, play_ptr->volume, play_ptr->audconvert, play_ptr->audresample, play_ptr->audcapsfilter, play_ptr->alsasink, NULL)) {
          GST_ERROR ("Error linking for ip_src --> volume --> audioconvert --> audioresample --> audiocapsfilter --> alsasink");
        } else {
          GST_DEBUG ("Linked for ip_src --> volume --> audioconvert --> audioresample --> audiocapsfilter --> alsasink successfully");
        }
      }
    }
    g_free (str);
    gst_caps_unref (caps);
}


void
vgst_print_params (guint index) {
    vgst_ip_params *ip_param = &app.ip_params[index];
    vgst_enc_params *enc_param = &app.enc_params[index];
    vgst_cmn_params *cmn_param = app.cmn_params;
    vgst_op_params *op_param = &app.op_params[index];
    vgst_aud_params *aud_param =  &app.aud_params[index];

    GST_DEBUG ("Src type %d", ip_param->src_type);
    GST_DEBUG ("Device type %d [1 =TPG, 3,4,5,6,7,8,9 =HDMI, 10 = CSI, 11 = SDI]", ip_param->device_type);
    GST_DEBUG ("Format type %d", ip_param->format);
    if (ip_param->uri)
      GST_DEBUG ("Uri %s", ip_param->uri);
    GST_DEBUG ("Width %u", ip_param->width);
    GST_DEBUG ("Height %u", ip_param->height);
    GST_DEBUG ("Raw %d", ip_param->raw);
    if (FALSE == ip_param->raw) {
      GST_DEBUG ("Gop Length %u", enc_param->gop_len);
      GST_DEBUG ("No. of b-frames %u", enc_param->b_frame);
      GST_DEBUG ("Bitrate %u", enc_param->bitrate);
      GST_DEBUG ("Encode type %d", enc_param->enc_type);
      GST_DEBUG ("Enable L2Cache %d", enc_param->enable_l2Cache);
      GST_DEBUG ("Profile %d", enc_param->profile);
      GST_DEBUG ("QP mode %d", enc_param->qp_mode);
      GST_DEBUG ("Rate Control mode %d", enc_param->rc_mode);
      GST_DEBUG ("Slice %u", enc_param->slice);
      GST_DEBUG ("Filler_data %u", enc_param->filler_data);
      GST_DEBUG ("Gop_mode %u", enc_param->gop_mode);
      GST_DEBUG ("Low_bandwidth %u", enc_param->low_bandwidth);
    }
    GST_DEBUG ("Duration %u minute/s", op_param->duration);
    if (op_param->file_out)
      GST_DEBUG ("Record file path %s",   op_param->file_out);
    if (op_param->host_ip)
      GST_DEBUG ("Host ip address %s",   op_param->host_ip);
    GST_DEBUG ("Output sink type %d",  cmn_param->sink_type);
    if (aud_param->format)
      GST_DEBUG ("Format type %s",  aud_param->format);
    GST_DEBUG ("Enable_audio %d",  aud_param->enable_audio);
    GST_DEBUG ("Sampling_rate %d",  aud_param->sampling_rate);
    GST_DEBUG ("Channel %d",  aud_param->channel);
    GST_DEBUG ("Volume %f",  aud_param->volume);
    GST_DEBUG ("Audio source type %d",  aud_param->audio_in);
    GST_DEBUG ("Audio renderer type %d",  aud_param->audio_out);
}


gboolean
bus_callback (GstBus *bus, GstMessage *msg, gpointer ptr) {
    vgst_playback *play_ptr = (vgst_playback *)ptr;
    switch (GST_MESSAGE_TYPE (msg)) {
    case GST_MESSAGE_EOS:
      GST_DEBUG ("End of stream");
      if (!play_ptr->stop_flag && FILE_SRC == app.ip_params->src_type) {
        if (gst_element_seek_simple (play_ptr->pipeline, GST_FORMAT_TIME, GST_SEEK_FLAG_FLUSH | GST_SEEK_FLAG_ACCURATE, 0)) {
          GST_DEBUG ("seeking to %d succeeded", 0);
        } else {
          GST_ERROR ("seeking to %d failed", 0);
        }
        break;
      }
      play_ptr->eos_flag = TRUE;
      if (play_ptr->loop && g_main_is_running (play_ptr->loop)) {
        GST_DEBUG ("Quitting the loop");
        g_main_loop_quit (play_ptr->loop);
        g_main_loop_unref (play_ptr->loop);
      }
      break;
    case GST_MESSAGE_ERROR: {
      gchar  *debug;
      GError *error;
      gst_message_parse_error (msg, &error, &debug);
      g_free (debug);
      GST_ERROR ("Error: %s   src[%s]", error->message, GST_OBJECT_NAME(msg->src));
      if (error && !play_ptr->err_msg) {
        play_ptr->err_msg = g_strdup (error->message);
      }
      // playback can't continue in error condition
      play_ptr->err_flag = TRUE;
      g_error_free (error);
      if (play_ptr->loop && g_main_is_running (play_ptr->loop)) {
        GST_DEBUG ("Quitting the loop");
        g_main_loop_quit (play_ptr->loop);
        g_main_loop_unref (play_ptr->loop);
      }
      break;
    }
    case GST_MESSAGE_TAG : {
      GstTagList *tags = NULL;
      gst_message_parse_tag (msg, &tags);
      if (tags) {
        gst_tag_list_foreach (tags, fetch_tag, play_ptr);
        gst_tag_list_unref (tags);
      }
      break;
    }
    default:
      break;
    }
    return TRUE;
}


VGST_ERROR_LOG
vgst_create_pipeline () {
    guint i =0;
    gint ret;
    vgst_cmn_params *cmn_param = app.cmn_params;
    vgst_ip_params *ip_param = app.ip_params;
    vgst_enc_params *enc_param = app.enc_params;
    vgst_playback *play_ptr = app.playback;
    vgst_aud_params *aud_param = app.aud_params;

    for (i =0; i < cmn_param->num_src; i++) {
      if (SPLIT_SCREEN == cmn_param->sink_type) {
        if (!(ret = create_split_pipeline (&ip_param[i], &enc_param[i], &play_ptr[i]))) {
          GST_DEBUG ("Succeed to create pipeline !!!");
        } else {
          GST_ERROR ("failed to create pipeline !!!");
          return ret;
        }

        // set all the property for split-screen
        set_split_screen_property (&app, i);

        // linking all the elements for split screen
        if ((ret = link_split_screen_elements (&ip_param[i], &play_ptr[i]))) {
          GST_ERROR ("Failed to link elements !!!");
          return ret;
        }
      } else {
        if (!(ret = create_pipeline (&ip_param[i], &enc_param[i], &play_ptr[i], cmn_param->sink_type, app.op_params->file_out, &aud_param[i]))) {
          GST_DEBUG ("Succeed to create pipeline !!!");
        } else {
          GST_ERROR ("failed to create pipeline !!!");
          return ret;
       }

        // set all the property
        set_property (&app, i);

        // linking all the elements
        if ((ret = link_elements (&ip_param[i], &play_ptr[i], cmn_param->sink_type, &aud_param[i], app.op_params->file_out))) {
          GST_ERROR ("Failed to link elements !!!");
          return ret;
        }
      }
    }
    return VGST_SUCCESS;
}

void
get_fps (guint index, guint *fps) {
    gint i =0;
    if (!fps) {
      GST_ERROR ("Fps pointer is NULL");
      return;
    } else {
      fps[i] = app.playback[index].fps_num[i];
      i++;
      if (SPLIT_SCREEN == app.cmn_params->sink_type) {
        // In case of split screen, 0th index(Left) is processed and 1st index(Right) is Raw
        fps[i] = app.playback[index].fps_num[i];
      }
    }
}

VGST_ERROR_LOG
vgst_run_pipeline () {
    guint i =0;
    guint x =0, y = 0, tmp =0;
    guint num_src = app.cmn_params->num_src;
    GstBus *bus;
    gint ret = VGST_SUCCESS;
    vgst_ip_params *ip_param = app.ip_params;
    vgst_playback *play_ptr = app.playback;
    vgst_cmn_params *cmn_param = app.cmn_params;

    for (i =0; i< num_src; i++) {
      bus = gst_pipeline_get_bus (GST_PIPELINE (app.playback[i].pipeline));
      gst_bus_add_watch (bus, bus_callback, &app.playback[i]);
      gst_object_unref (bus);
    }
    for (i =0; i< num_src; i++) {
      if (SPLIT_SCREEN == cmn_param->sink_type) {
        play_ptr[i].overlay = GST_VIDEO_OVERLAY (play_ptr[i].videosink);
        play_ptr[i].overlay2 = GST_VIDEO_OVERLAY (play_ptr[i].videosink2);
        if (play_ptr[i].overlay) {
          get_coordinates (&x, &y, tmp++, (num_src*2));
          ret = gst_video_overlay_set_render_rectangle (play_ptr[i].overlay, x, y, ip_param[i].width, ip_param[i].height);
          if (ret) {
            gst_video_overlay_expose (play_ptr[i].overlay);
            ret =VGST_SUCCESS;
          }
        } else {
          GST_ERROR ("Failed to create overlay");
          return VGST_ERROR_OVERLAY_CREATION_FAIL;
        }
        if (play_ptr[i].overlay2) {
          get_coordinates (&x, &y, tmp++, (num_src*2));
          ret = gst_video_overlay_set_render_rectangle (play_ptr[i].overlay2, x, y, ip_param[i].width, ip_param[i].height);
          if (ret) {
            gst_video_overlay_expose (play_ptr[i].overlay2);
            ret =VGST_SUCCESS;
          }
        } else {
          GST_ERROR ("Failed to create overlay2");
          return VGST_ERROR_OVERLAY_CREATION_FAIL;
        }
      } else if ((DISPLAY == cmn_param->sink_type && cmn_param->num_src > 1)) {
        play_ptr[i].overlay = GST_VIDEO_OVERLAY (play_ptr[i].videosink);
        if (play_ptr[i].overlay) {
          get_coordinates (&x, &y, i, num_src);
          ret = gst_video_overlay_set_render_rectangle (play_ptr[i].overlay, x, y, ip_param[i].width, ip_param[i].height);
          if (ret) {
            gst_video_overlay_expose (play_ptr[i].overlay);
            ret =VGST_SUCCESS;
          }
        } else {
          GST_ERROR ("Failed to create overlay");
          return VGST_ERROR_OVERLAY_CREATION_FAIL;
        }
      }
      GST_DEBUG ("Triggering play command");
      if (GST_STATE_CHANGE_FAILURE == gst_element_set_state (play_ptr[i].pipeline, GST_STATE_PLAYING)) {
        GST_ERROR ("state change to Play failed");
        return VGST_ERROR_STATE_CHANGE_FAIL;
      }
    }
    return VGST_SUCCESS;
}

guint
get_bitrate (int index) {
    if ((FILE_SRC == app.ip_params[index].src_type || STREAMING_SRC == app.ip_params[index].src_type) && app.playback[index].file_br) {
      return app.playback[index].file_br;
    } else
      return 0;
}

guint
get_video_type (int index) {
    return app.playback[index].video_type;
}

gint
poll_event (int *arg, int index) {
    guint i, num_src = app.cmn_params->num_src;
    gboolean eos_flag = TRUE;
    for (i =0; i< num_src; i++) {
      eos_flag &= app.playback[i].eos_flag;
    }
    if (eos_flag) {
      return EVENT_EOS;
    }
    if (app.playback[index].err_msg) {
      *arg = VGST_ERROR_RUN_TIME_PIPELINE_FAILED;
      return EVENT_ERROR;
    }
    return EVENT_NONE;
}

void
get_position (guint index, gint64 *position) {
    GstFormat format = GST_FORMAT_TIME;
    if (!app.playback[index].pipeline || !app.cmn_params) {
      GST_ERROR ("Pipeline not initialized");
      return;
    }

    if (!gst_element_query_position (app.playback[index].pipeline, format, position)) {
      GST_ERROR ("Unable to retrieve current position");
    }
    if ((app.cmn_params->sink_type  == RECORD) && *position >= app.op_params[index].duration * GST_MINUTE * GST_SECOND) {
      GST_DEBUG ("Sending EOS event");
      GstEvent *event = gst_event_new_eos();
      if (event) {
        if (gst_element_send_event (app.playback[index].pipeline, event)) {
          GST_DEBUG ("send EOS event to pipeline Succeed");
        } else
          GST_ERROR("send EOS event to pipeline failed");
      }
    }
}

void
get_duration (guint index, gint64 *duration) {
    GstFormat format = GST_FORMAT_TIME;
    if (!app.playback[index].pipeline) {
      GST_ERROR ("Pipeline not initialized");
      return;
    }
    if (!gst_element_query_duration (app.playback[index].pipeline, format, duration)) {
      GST_ERROR ("Unable to retrieve current duration");
    }
}

gint
stop_pipeline (void) {
    if (!app.cmn_params) {
      GST_ERROR ("Pipeline not initialized");
      return VGST_ERROR_PIPELINE_NOT_INITIALIZED;
    }
    guint num_src = app.cmn_params->num_src;
    gint i =0, ret = VGST_SUCCESS;
    for (i =0; i< num_src; i++) {
      vgst_playback *play_ptr = &app.playback[i];
      if (!play_ptr || !play_ptr->pipeline) {
        GST_ERROR ("Pipeline handle is null");
        ret |= VGST_ERROR_PIPELINE_NOT_INITIALIZED;
        continue;
      }
      play_ptr->stop_flag = TRUE;
      if (!play_ptr->eos_flag && !play_ptr->err_flag) {
        if (app.cmn_params->sink_type == RECORD) {
          GST_DEBUG ("sending EOS event");
          GstEvent *event = gst_event_new_eos();
          if (event) {
            if (gst_element_send_event (play_ptr->pipeline, event)) {
              GST_DEBUG ("send event to pipeline Succeed");
              play_ptr->loop = g_main_loop_new (NULL, FALSE);
              g_main_loop_run (play_ptr->loop);
            } else
              GST_ERROR("send event to pipeline failed");
          }
        }
      }
      GST_DEBUG ("setting to NULL state");
      if (GST_STATE_CHANGE_FAILURE == gst_element_set_state (play_ptr->pipeline, GST_STATE_NULL)) {
        GST_ERROR ("state change is failed");
        ret |= VGST_ERROR_STATE_CHANGE_FAIL;
        continue;
      }
      if (play_ptr->pipeline) {
        if (play_ptr->pad) {
          GST_DEBUG ("releasing pad");
          gst_element_release_request_pad (play_ptr->tee, play_ptr->pad);
          gst_object_unref (play_ptr->pad);
        }
        if (play_ptr->pad2) {
          GST_DEBUG ("releasing pad");
          gst_element_release_request_pad (play_ptr->tee, play_ptr->pad2);
          gst_object_unref (play_ptr->pad2);
        }
        if (play_ptr->audpad) {
          GST_DEBUG ("releasing audio pad");
          gst_element_release_request_pad (play_ptr->mux, play_ptr->audpad);
          gst_object_unref (play_ptr->audpad);
        }
        if (play_ptr->vidpad) {
          GST_DEBUG ("releasing video pad");
          gst_element_release_request_pad (play_ptr->mux, play_ptr->vidpad);
          gst_object_unref (play_ptr->vidpad);
        }
        GST_DEBUG ("removing  bus");
        GstBus *bus;
        bus = gst_pipeline_get_bus (GST_PIPELINE (play_ptr->pipeline));
        if (bus) {
          gst_bus_remove_watch (bus);
          gst_object_unref (bus);
        }
        if (play_ptr->err_msg) {
          g_free (play_ptr->err_msg);
          play_ptr->err_msg = NULL;
        }
        gst_object_unref (GST_OBJECT (play_ptr->pipeline));
        play_ptr->pipeline = NULL;
      }
    }
    GST_DEBUG ("returning from stop");
    return ret;
}
