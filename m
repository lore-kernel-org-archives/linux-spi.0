From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/2] spi: introduce master->handle_err() callback
Date: Fri, 27 Feb 2015 17:34:15 +0200
Message-ID: <1425051256-30890-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This callback would be useful to handle an error that occurs in the generic
implementation of transfer_one_message(). The good candidate for this is to
drain FIFO and / or to terminate DMA transfers when timeout happened.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi.c       | 3 +++
 include/linux/spi/spi.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c64a3e5..31d4d9d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -851,6 +851,9 @@ out:
 	if (msg->status == -EINPROGRESS)
 		msg->status = ret;
 
+	if (msg->status)
+		master->handle_err(master, msg);
+
 	spi_finalize_current_message(master);
 
 	return ret;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ed9489d..4eaac3a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -294,6 +294,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *                    transfer_one_message are mutually exclusive; when both
  *                    are set, the generic subsystem does not call your
  *                    transfer_one callback.
+ * @handle_err: the subsystem calls the driver to handle and error that occurs
+ *		in the generic implementation of transfer_one_message().
  * @unprepare_message: undo any work done by prepare_message().
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
@@ -448,6 +450,8 @@ struct spi_master {
 	void (*set_cs)(struct spi_device *spi, bool enable);
 	int (*transfer_one)(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *transfer);
+	void (*handle_err)(struct spi_master *master,
+			   struct spi_message *message);
 
 	/* gpio chip select */
 	int			*cs_gpios;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
