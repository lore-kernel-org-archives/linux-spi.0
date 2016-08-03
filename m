From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] spi: Split bus and I/O locking
Date: Wed, 3 Aug 2016 13:28:38 +0300
Message-ID: <20160803102838.GA2504@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark Brown,

The patch ef4d96ec4ad9: "spi: Split bus and I/O locking" from Jul 21,
2016, leads to the following static checker warning:

	drivers/spi/spi.c:1214 __spi_pump_messages()
	warn: inconsistent returns 'mutex:&master->io_mutex'.

drivers/spi/spi.c
  1155          mutex_lock(&master->io_mutex);
  1156  
  1157          if (!was_busy && master->auto_runtime_pm) {
  1158                  ret = pm_runtime_get_sync(master->dev.parent);
  1159                  if (ret < 0) {
  1160                          dev_err(&master->dev, "Failed to power device: %d\n",
  1161                                  ret);
  1162                          return;

goto out?

  1163                  }
  1164          }
  1165  
  1166          if (!was_busy)
  1167                  trace_spi_master_busy(master);
  1168  
  1169          if (!was_busy && master->prepare_transfer_hardware) {
  1170                  ret = master->prepare_transfer_hardware(master);
  1171                  if (ret) {
  1172                          dev_err(&master->dev,
  1173                                  "failed to prepare transfer hardware\n");
  1174  
  1175                          if (master->auto_runtime_pm)
  1176                                  pm_runtime_put(master->dev.parent);
  1177                          return;

Same.

  1178                  }
  1179          }
  1180  
  1181          trace_spi_message_start(master->cur_msg);
  1182  
  1183          if (master->prepare_message) {
  1184                  ret = master->prepare_message(master, master->cur_msg);
  1185                  if (ret) {
  1186                          dev_err(&master->dev,
  1187                                  "failed to prepare message: %d\n", ret);
  1188                          master->cur_msg->status = ret;
  1189                          spi_finalize_current_message(master);
  1190                          goto out;
  1191                  }
  1192                  master->cur_msg_prepared = true;
  1193          }
  1194  
  1195          ret = spi_map_msg(master, master->cur_msg);
  1196          if (ret) {
  1197                  master->cur_msg->status = ret;
  1198                  spi_finalize_current_message(master);
  1199                  goto out;
  1200          }
  1201  
  1202          ret = master->transfer_one_message(master, master->cur_msg);
  1203          if (ret) {
  1204                  dev_err(&master->dev,
  1205                          "failed to transfer one message from queue\n");
  1206                  goto out;
  1207          }
  1208  
  1209  out:
  1210          mutex_unlock(&master->io_mutex);
  1211  
  1212          /* Prod the scheduler in case transfer_one() was busy waiting */
  1213          if (!ret)
  1214                  cond_resched();
  1215  }

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
