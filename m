From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv2 1/3] spi: pxa2xx: handle error of pxa2xx_spi_dma_prepare()
Date: Thu, 24 Mar 2016 15:35:42 +0200
Message-ID: <1458826544-28553-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

If by some reason pxa2xx_spi_dma_prepare() fails we have not to ignore its
error. In such case we abort the transfer and return the error to upper
level.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
[Jarkko: Avoid leaking TX descriptors in case RX descriptor allocation
fails. Noted by Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>.
Unmap also buffers in case of failure.]
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Reposting Andy's fix from December that got buried to list during
holidays.
---
 drivers/spi/spi-pxa2xx-dma.c | 13 +++++++++++--
 drivers/spi/spi-pxa2xx.c     |  8 +++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 365fc22c3572..b1883d228103 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -267,19 +267,22 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 int pxa2xx_spi_dma_prepare(struct driver_data *drv_data, u32 dma_burst)
 {
 	struct dma_async_tx_descriptor *tx_desc, *rx_desc;
+	int err = 0;
 
 	tx_desc = pxa2xx_spi_dma_prepare_one(drv_data, DMA_MEM_TO_DEV);
 	if (!tx_desc) {
 		dev_err(&drv_data->pdev->dev,
 			"failed to get DMA TX descriptor\n");
-		return -EBUSY;
+		err = -EBUSY;
+		goto err_tx;
 	}
 
 	rx_desc = pxa2xx_spi_dma_prepare_one(drv_data, DMA_DEV_TO_MEM);
 	if (!rx_desc) {
 		dev_err(&drv_data->pdev->dev,
 			"failed to get DMA RX descriptor\n");
-		return -EBUSY;
+		err = -EBUSY;
+		goto err_rx;
 	}
 
 	/* We are ready when RX completes */
@@ -289,6 +292,12 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_data, u32 dma_burst)
 	dmaengine_submit(rx_desc);
 	dmaengine_submit(tx_desc);
 	return 0;
+
+err_rx:
+	dmaengine_terminate_async(drv_data->tx_chan);
+err_tx:
+	pxa2xx_spi_unmap_dma_buffers(drv_data);
+	return err;
 }
 
 void pxa2xx_spi_dma_start(struct driver_data *drv_data)
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 85e59a406a4c..47bdbd350a24 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -928,6 +928,7 @@ static void pump_transfers(unsigned long data)
 	u32 dma_thresh = drv_data->cur_chip->dma_threshold;
 	u32 dma_burst = drv_data->cur_chip->dma_burst_size;
 	u32 change_mask = pxa2xx_spi_get_ssrc1_change_mask(drv_data);
+	int err;
 
 	/* Get current state information */
 	message = drv_data->cur_msg;
@@ -1047,7 +1048,12 @@ static void pump_transfers(unsigned long data)
 		/* Ensure we have the correct interrupt handler */
 		drv_data->transfer_handler = pxa2xx_spi_dma_transfer;
 
-		pxa2xx_spi_dma_prepare(drv_data, dma_burst);
+		err = pxa2xx_spi_dma_prepare(drv_data, dma_burst);
+		if (err) {
+			message->status = err;
+			giveback(drv_data);
+			return;
+		}
 
 		/* Clear status and start DMA engine */
 		cr1 = chip->cr1 | dma_thresh | drv_data->dma_cr1;
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
