From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 1/3] spi: dw: make sure SPI controller is enabled
Date: Fri, 27 Feb 2015 18:36:15 +0200
Message-ID: <1425054977-9859-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425054977-9859-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425054977-9859-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The error handling is partially broken since the controller is disabled on
error and is not re-enabled until condition occurs, i.e. mode (poll, PIO/DMA),
chip (cs_change), or speed (clk_div) is changed. In the result of these changes
we will have a predictable state of the SPi controller independently on how
successfull a previous transfer was.

The patch disables interrupts and re-enables the SPI controller wherever it
needs to be done. Thus most of the time the SPI controller is kept enabled. The
runtime PM, when it will be implemented, must take care of the controller
disabling and re-enabling.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 05af817..24aaaf98 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -270,10 +270,21 @@ static void giveback(struct dw_spi *dws)
 	spi_finalize_current_message(dws->master);
 }
 
-static void int_error_stop(struct dw_spi *dws, const char *msg)
+/*
+ * This does disable the SPI controller, interrupts, and re-enable the
+ * controller back. Transmit and receive FIFO buffers are cleared when the
+ * device is disabled.
+ */
+static void spi_disable_intr(struct dw_spi *dws)
 {
-	/* Stop the hw */
 	spi_enable_chip(dws, 0);
+	spi_mask_intr(dws, 0xff);
+	spi_enable_chip(dws, 1);
+}
+
+static void int_error_stop(struct dw_spi *dws, const char *msg)
+{
+	spi_disable_intr(dws);
 
 	dev_err(&dws->master->dev, "%s\n", msg);
 	dws->cur_msg->state = ERROR_STATE;
@@ -606,9 +617,7 @@ static void dw_spi_cleanup(struct spi_device *spi)
 /* Restart the controller, disable all interrupts, clean rx fifo */
 static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 {
-	spi_enable_chip(dws, 0);
-	spi_mask_intr(dws, 0xff);
-	spi_enable_chip(dws, 1);
+	spi_disable_intr(dws);
 
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
