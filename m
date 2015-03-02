From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 6/9] spi: dw-mid: clear ongoing DMA transfers on timeout
Date: Mon,  2 Mar 2015 20:16:03 +0200
Message-ID: <1425320166-13788-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425320166-13788-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425320166-13788-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch shuts up any ongoing DMA transfer in case of error.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 13 +++++++++++++
 drivers/spi/spi-dw.c     |  3 +++
 drivers/spi/spi-dw.h     |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 3729cdd..e614190 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -270,11 +270,24 @@ static int mid_spi_dma_transfer(struct dw_spi *dws)
 	return 0;
 }
 
+static void mid_spi_dma_stop(struct dw_spi *dws)
+{
+	if (test_bit(TX_BUSY, &dws->dma_chan_busy)) {
+		dmaengine_terminate_all(dws->txchan);
+		clear_bit(TX_BUSY, &dws->dma_chan_busy);
+	}
+	if (test_bit(RX_BUSY, &dws->dma_chan_busy)) {
+		dmaengine_terminate_all(dws->rxchan);
+		clear_bit(RX_BUSY, &dws->dma_chan_busy);
+	}
+}
+
 static struct dw_spi_dma_ops mid_dma_ops = {
 	.dma_init	= mid_spi_dma_init,
 	.dma_exit	= mid_spi_dma_exit,
 	.dma_setup	= mid_spi_dma_setup,
 	.dma_transfer	= mid_spi_dma_transfer,
+	.dma_stop	= mid_spi_dma_stop,
 };
 #endif
 
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c7c2fcc..d53cffe 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -432,6 +432,9 @@ static void dw_spi_handle_err(struct spi_master *master,
 {
 	struct dw_spi *dws = spi_master_get_devdata(master);
 
+	if (dws->dma_mapped)
+		dws->dma_ops->dma_stop(dws);
+
 	spi_reset_chip(dws);
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 7351692..7f130bd 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -93,6 +93,7 @@ struct dw_spi_dma_ops {
 	void (*dma_exit)(struct dw_spi *dws);
 	int (*dma_setup)(struct dw_spi *dws);
 	int (*dma_transfer)(struct dw_spi *dws);
+	void (*dma_stop)(struct dw_spi *dws);
 };
 
 struct dw_spi {
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
