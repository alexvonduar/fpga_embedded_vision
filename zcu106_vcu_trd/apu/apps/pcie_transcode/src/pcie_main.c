/******************************************************************************
 * (c) Copyright 2019 Xilinx, Inc. All rights reserved.
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


#include <pcie_main.h>
#include <pcie_src.h>

App s_app;

GST_DEBUG_CATEGORY (pciesrc_sink_debug);
#define GST_CAT_DEFAULT pciesrc_sink_debug

gboolean bus_message (GstBus * bus, GstMessage * message, App * app) {
    switch (GST_MESSAGE_TYPE (message)) {
    case GST_MESSAGE_ERROR:
      GST_ERROR ("Received error from %s", GST_MESSAGE_SRC_NAME (message));
      if (app->loop && g_main_is_running (app->loop)) {
        g_main_loop_quit (app->loop);
      }
      break;
    case GST_MESSAGE_EOS:
      GST_DEBUG ("EOS reached %lu\n",app->write_offset);
      if (app->write_offset) {
        pcie_write (app->fd, app->write_offset, 0, app->buf);
        app->write_offset = 0;
      }
      if (g_main_loop_is_running (app->loop)) {
        GST_DEBUG ("Qutting the loop");
        if (app->loop && g_main_is_running (app->loop)) {
          g_main_loop_quit (app->loop);
        }
      }
      break;
    default:
      break;
    }
    return TRUE;
}

gboolean handle_keyboard (GIOChannel *source, GIOCondition cond, App *data) {
    gchar *str = NULL;
    GstEvent *event;
    if (g_io_channel_read_line (source, &str, NULL, NULL, NULL) != G_IO_STATUS_NORMAL) {
      return TRUE;
    }
    switch (g_ascii_tolower (str[0])) {
      case 'q': {
        GST_DEBUG ("Quitting the playback");
        event = gst_event_new_eos();
        if (event) {
          if (gst_element_send_event (data->pipeline, event)) {
            data->eos_flag = TRUE;
            GST_DEBUG ("Send event to pipeline Succeed");
          } else
            GST_ERROR ("Send event to pipeline failed");
        }
        return FALSE;
      }
      break;
    }
    g_free (str);
    return TRUE;
}

void on_pad_added (GstElement *element,
                   GstPad     *pad,
                   gpointer   data) {
    gchar *str;
    GstPad *vidpad = NULL, *audpad = NULL;
    gchar *vidpadname = NULL, *audpadname = NULL;
    App *play_ptr = (App *)data;
    GstCaps *caps = gst_pad_get_current_caps (pad);
    str = gst_caps_to_string(caps);
    GST_DEBUG ("Caps value is %s", str);

    if (g_str_has_prefix (str, "video/")) {
      vidpad = gst_element_get_request_pad(play_ptr->mux, "sink_%d");
      vidpadname = gst_pad_get_name(vidpad);
      GST_DEBUG ("Video pad name %s", vidpadname);

      if (!gst_element_link_many(play_ptr->decodebin, play_ptr->videoqueue, play_ptr->videoenc, play_ptr->videoparser, NULL)) {
        GST_ERROR ("Error linking for decodebin --> queue --> capfilter --> videoenc -> videoparser");
        goto CLEAN_UP;
      } else {
        GST_DEBUG ("Linked for decodebin --> queue --> capfilter --> videoenc --> videoparser successfully");
      }

      if (!gst_element_link_pads(play_ptr->videoparser, "src", play_ptr->mux, vidpadname)) {
        GST_ERROR ("Error linking for videoparser --> mux");
        goto CLEAN_UP;
      } else {
        GST_DEBUG ("Linked for videoparser --> mux successfully");
      }
      goto EXIT;
    } else if (g_str_has_prefix (str, "audio/")) {
      audpad = gst_element_get_request_pad(play_ptr->mux, "sink_%d");
      audpadname = gst_pad_get_name(audpad);
      GST_DEBUG ("Audio pad name %s", audpadname);

      if (!gst_element_link_many(play_ptr->decodebin, play_ptr->audioqueue, play_ptr->audioconvert, play_ptr->audioresample, play_ptr->audioenc, NULL)) {
        GST_ERROR ("Error linking for decodebin --> queue --> audioconvert --> audioresample --> audioenc");
        goto CLEAN_UP;
      } else {
        GST_DEBUG ("Linked for decodebin --> queue --> audioconvert --> audioresample --> audioenc successfully");
      }

      if (!gst_element_link_pads(play_ptr->audioenc, "src", play_ptr->mux, audpadname)) {
        GST_ERROR ("Error linking for audioenc --> mux");
        goto CLEAN_UP;
      } else {
        GST_DEBUG ("Linked for audioenc --> mux successfully");
      }
      goto EXIT;
    }

CLEAN_UP:
    if (audpad) {
      GST_DEBUG ("Releasing audio pad");
      gst_element_release_request_pad (play_ptr->mux, audpad);
    }
    if (vidpad) {
      GST_DEBUG ("Releasing video pad");
      gst_element_release_request_pad (play_ptr->mux, vidpad);
    }
EXIT :
    if (vidpadname)
      g_free (vidpadname);
    if (audpadname)
      g_free (audpadname);

    if (str)
      g_free (str);
    if (caps)
      gst_caps_unref (caps);
}


GstFlowReturn new_sample (GstElement *sink, App *data) {
    GstSample *sample;
    GstBuffer *buffer;
    GstMapInfo map;

    /* get the sample from pciesink */
    g_signal_emit_by_name (sink, "pull-sample", &sample);
    buffer = gst_sample_get_buffer (sample);
    if (!buffer) {
      GST_DEBUG ("Buffer is null");
      return GST_FLOW_EOS;
    }

    gst_buffer_map (buffer, &map, GST_MAP_READ);
    if (data->write_offset + map.size > WRITE_BUF_SIZE) {
      pcie_write (data->fd, data->write_offset, 0, data->buf);
      data->write_offset = 0;
    }

    memcpy (data->buf + data->write_offset, map.data, map.size);

    data->write_offset += map.size;

    gst_buffer_unmap (buffer, &map);

    /* Don't need the sample anymore */
    gst_sample_unref (sample);

    return GST_FLOW_OK;
}

void set_property (App *app) {
    /* set to read from pciesrc */
    g_object_set (G_OBJECT (app->pciesrc), "stream-type", GST_APP_STREAM_TYPE_SEEKABLE, "format", GST_FORMAT_BYTES, "size", app->length, NULL);
    g_object_set (G_OBJECT (app->pciesrc), "max-bytes", CHUNK_SIZE, NULL);
    g_object_set (app->audioqueue, "max-size-bytes", 0, NULL);
    g_object_set (app->videoqueue, "max-size-bytes", 0, NULL);

    /* Configure encoder */
    g_object_set (G_OBJECT (app->videoenc),  "gop-length",       app->enc_param.gop_len,           NULL);
    g_object_set (G_OBJECT (app->videoenc),  "gop-mode",         app->enc_param.gop_mode,          NULL);
    g_object_set (G_OBJECT (app->videoenc),  "low-bandwidth",    app->enc_param.low_bandwidth,     NULL);
    g_object_set (G_OBJECT (app->videoenc),  "target-bitrate",   app->enc_param.bitrate,           NULL);
    g_object_set (G_OBJECT (app->videoenc),  "b-frames",         app->enc_param.b_frame,           NULL);
    g_object_set (G_OBJECT (app->videoenc),  "num-slices",       app->enc_param.slice,             NULL);
    g_object_set (G_OBJECT (app->videoenc),  "control-rate",     app->enc_param.rc_mode,           NULL);
    g_object_set (G_OBJECT (app->videoenc),  "qp-mode",          app->enc_param.qp_mode,           NULL);
    g_object_set (G_OBJECT (app->videoenc),  "prefetch-buffer",  app->enc_param.enable_l2Cache,    NULL);
    if (app->enc_param.rc_mode == CBR)
      g_object_set (G_OBJECT (app->videoenc),  "filler-data",      app->enc_param.filler_data,     NULL);
    GST_DEBUG ("gop-len %d", app->enc_param.gop_len);
    GST_DEBUG ("gop_mode %d", app->enc_param.gop_mode);
    GST_DEBUG ("low_bandwidth %d", app->enc_param.low_bandwidth);
    GST_DEBUG ("bitrate %d", app->enc_param.bitrate);
    GST_DEBUG ("b_frame %d", app->enc_param.b_frame);
    GST_DEBUG ("slice %d", app->enc_param.slice);
    GST_DEBUG ("rc_mode %d", app->enc_param.rc_mode);
    GST_DEBUG ("qp_mode %d", app->enc_param.qp_mode);
    GST_DEBUG ("enable_l2Cache %d", app->enc_param.enable_l2Cache);
    GST_DEBUG ("filler_data %d", app->enc_param.filler_data);

    /* Configure pciesink */
    g_object_set (app->pciesink, "emit-signals", TRUE, NULL);
    g_object_set (app->pciesink, "sync", FALSE, NULL);
}

gint main (gint argc, gchar *argv[]) {
    App *app = &s_app;
    GstBus *bus;
    GIOChannel *io_stdin;
    ssize_t rc;
    gint ret = 0;

    gst_init (&argc, &argv);
    memset (app, 0, sizeof(App));
    GST_DEBUG_CATEGORY_INIT (pciesrc_sink_debug, "pcie-transcode", 0, "pcie-transcode pipeline example");

    app->sourceid = 0;
    /* try to open the file as an mmapped file */
    app->fd = pcie_open();
    if (app->fd < 0) {
      GST_ERROR ("Unable to open device %d", app->fd);
      goto FAIL;
    }

    /* get some vitals, this will be used to read data from the mmapped file and
     * feed it to pciesrc. */
    app->length  = pcie_get_file_length(app->fd);
    if (app->length <= 0) {
      GST_ERROR ("Unable to get file_length");
      goto FAIL;
    } else {
      GST_DEBUG ("File length is %lu.", app->length);
    }

    ret = pcie_get_enc_params (app->fd, &app->enc_param);
    if (ret < 0) {
      GST_ERROR ("Unable to get encoder params");
      goto FAIL;
    }

    app->write_offset = 0;
    app->read_offset = 0;
    app->intOffset = 0;
    app->eos_flag = FALSE;

    /* create a mainloop to get messages */
    app->loop = g_main_loop_new (NULL, TRUE);

    app->pipeline = gst_pipeline_new ("pipeline");
    app->pciesrc = gst_element_factory_make ("appsrc", NULL);
    app->decodebin = gst_element_factory_make ("decodebin", NULL);
    app->audioqueue = gst_element_factory_make ("queue", NULL);
    app->videoqueue = gst_element_factory_make ("queue", NULL);
    app->audioenc = gst_element_factory_make ("faac", NULL);
    app->mux = gst_element_factory_make ("mpegtsmux", NULL);
    app->audioconvert = gst_element_factory_make ("audioconvert", NULL);
    app->audioresample = gst_element_factory_make ("audioresample", NULL);
    app->pciesink = gst_element_factory_make ("appsink", NULL);

    if (app->enc_param.enc_type == AVC) {
      app->videoenc = gst_element_factory_make ("omxh264enc", NULL);
      app->videoparser = gst_element_factory_make ("h264parse", NULL);
    } else {
      app->videoenc = gst_element_factory_make ("omxh265enc", NULL);
      app->videoparser = gst_element_factory_make ("h265parse", NULL);
    }
    if (!app->pipeline || !app->pciesrc || !app->decodebin || !app->audioqueue || !app->videoqueue || !app->audioenc || !app->mux || \
        !app->audioconvert || !app->audioresample  || !app->pciesink || !app->videoenc || !app->videoparser) {
      GST_ERROR ("Unable to create required elements");
      goto FAIL;
    }
    io_stdin = g_io_channel_unix_new (fileno (stdin));
    g_io_add_watch (io_stdin, G_IO_IN, (GIOFunc)handle_keyboard, app);

    bus = gst_pipeline_get_bus (GST_PIPELINE (app->pipeline));

    /* add watch for messages */
    gst_bus_add_watch (bus, (GstBusFunc) bus_message, app);
    GST_DEBUG ("Change the settings");

    set_property (app);


    gst_bin_add_many (GST_BIN (app->pipeline), app->pciesrc, app->decodebin, app->audioqueue, app->videoqueue, app->pciesink, app->mux, app->audioenc, app->videoenc, \
                      app->videoparser, app->audioconvert, app->audioresample, NULL);

    g_signal_connect (app->pciesrc, "need-data", G_CALLBACK (start_feed), app);
    g_signal_connect (app->pciesrc, "enough-data", G_CALLBACK (stop_feed), app);
    g_signal_connect (app->pciesrc, "seek-data", G_CALLBACK (seek_data), app);
    g_signal_connect (app->decodebin, "pad-added", G_CALLBACK (on_pad_added), app);
    g_signal_connect (app->pciesink, "new-sample", G_CALLBACK (new_sample), app);

    if (!gst_element_link_many (app->mux, app->pciesink, NULL)) {
      GST_ERROR ("Error linking for mux --> pciesink");
      goto FAIL;
    } else {
      GST_DEBUG ("Linked for mux --> pciesink successfully");
    }

    if (gst_element_link_many (app->pciesrc, app->decodebin, NULL) != TRUE) {
      GST_ERROR ("Error linking for pciesrc --> decodebin");
      goto FAIL;
    }
    if (app->length < ONE_GB_SIZE) {
      app->total_len = app->length;
    } else {
      app->total_len = ONE_GB_SIZE;
    }
    GST_DEBUG ("Setting size %lu\n", app->total_len);
    app->data = g_malloc0(app->total_len);
    /* go to playing and wait in a mainloop. */
    gst_element_set_state (app->pipeline, GST_STATE_PLAYING);

    /* this mainloop is stopped when we receive an error or EOS */
    g_main_loop_run (app->loop);

    GST_DEBUG ("Stopping");

    gst_element_set_state (app->pipeline, GST_STATE_NULL);
    GST_DEBUG ("Set transfer done");
    rc = pcie_set_read_transfer_done(app->fd, 0xef);
    if (rc < 0)
      GST_ERROR ("Read transfer done ioctl failed");

    rc = pcie_set_write_transfer_done(app->fd, 0xef);
    if (rc < 0)
      GST_ERROR ("Write transfer done ioctl failed");
FAIL:
    GST_DEBUG ("Close fd");
    if (app->fd >= 0)
      close(app->fd);

    if (app->data) {
      g_free (app->data);
      app->data = NULL;
    }
    if (app->pipeline)
      gst_object_unref (app->pipeline);

    if (bus)
      gst_object_unref (bus);

    if (app->loop && g_main_is_running (app->loop)) {
      g_main_loop_unref (app->loop);
    }

    return 0;
}
