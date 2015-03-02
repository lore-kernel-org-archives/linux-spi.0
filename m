From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v4 1/3] spi: dw: make sure SPI controller is enabled
Date: Mon,  2 Mar 2015 14:58:55 +0200
Message-ID: <1425301137-8043-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425301137-8043-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425301137-8043-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The error handling is partially broken since the controller is disabled on
error and is not re-enabled until condition occurs, i.e. mode (poll, PIO/DMA),
chip (cs_change), or speed (clk_div) is changed. In the result of these changes
we will have a predictable state of the SPi controller independently on how
successfull was a previous transfer.

The patch disables interrupts and re-enables the SPI controller wherever it
needs to be done. Thus most of the time the SPI controller is kept enabled. The
runtime PM, when it will be implemented, must take care of the controller
disabling and re-enabling.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c |  7 ++-----
 drivers/spi/spi-dw.h | 12 ++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 05af817..2e9e1f9 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -272,8 +272,7 @@ static void giveback(struct dw_spi *dws)
 
 static void int_error_stop(struct dw_spi *dws, const char *msg)
 {
-	/* Stop the hw */
-	spi_enable_chip(dws, 0);
+	spi_reset_chip(dws);
 
 	dev_err(&dws->master->dev, "%s\n", msg);
 	dws->cur_msg->state = ERROR_STATE;
@@ -606,9 +605,7 @@ static void dw_spi_cleanup(struct spi_device *spi)
 /* Restart the controller, disable all interrupts, clean rx fifo */
 static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 {
-	spi_enable_chip(dws, 0);
-	spi_mask_intr(dws, 0xff);
-	spi_enable_chip(dws, 1);
+	spi_reset_chip(dws);
 
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 3d32be6..1a7f083 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -217,6 +217,18 @@ static inline void spi_umask_intr(struct dw_spi *dws, u32 mask)
 }
 
 /*
+ * This does disable the SPI controller, interrupts, and re-enable the
+ * controller back. Transmit and receive FIFO buffers are cleared when the
+ * device is disabled.
+ */
+static inline void spi_reset_chip(struct dw_spi *dws)
+{
+	spi_enable_chip(dws, 0);
+	spi_mask_intr(dws, 0xff);
+	spi_enable_chip(dws, 1);
+}
+
+/*
  * Each SPI slave device to work with dw_api controller should
  * has such a structure claiming its working mode (PIO/DMA etc),
  * which can be save in the "controller_data" member of the
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
