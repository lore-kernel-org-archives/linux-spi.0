From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Switch to SPI core DMA mapping functionality" to the spi tree
Date: Tue, 21 Jun 2016 19:53:07 +0100
Message-ID: <E1bFQnL-0008W4-Si@debutante>
References: <1466504494-8984-2-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466504494-8984-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Switch to SPI core DMA mapping functionality

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b6ced294fb61418e7d3fc30bac696f313551d412 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 21 Jun 2016 13:21:34 +0300
Subject: [PATCH] spi: pxa2xx: Switch to SPI core DMA mapping functionality

SPI core provides DMA mapping with scatterlists. Start using it instead
of own implementation in spi-pxa2xx. Major difference in addition to
bunch of removed boilerplate code is that SPI core does
mapping/unmapping for all transfers in a message before and after the
message sending where spi-pxa2xx did mapping/unmapping for each
transfers separately.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c | 170 ++++++++-----------------------------------
 drivers/spi/spi-pxa2xx.c     |  28 +++++--
 drivers/spi/spi-pxa2xx.h     |   9 ---
 3 files changed, 50 insertions(+), 157 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index a18a03d0afb7..db3ae1dd829e 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -20,79 +20,6 @@
 
 #include "spi-pxa2xx.h"
 
-static int pxa2xx_spi_map_dma_buffer(struct driver_data *drv_data,
-				     enum dma_data_direction dir)
-{
-	int i, nents, len = drv_data->len;
-	struct scatterlist *sg;
-	struct device *dmadev;
-	struct sg_table *sgt;
-	void *buf, *pbuf;
-
-	if (dir == DMA_TO_DEVICE) {
-		dmadev = drv_data->tx_chan->device->dev;
-		sgt = &drv_data->tx_sgt;
-		buf = drv_data->tx;
-	} else {
-		dmadev = drv_data->rx_chan->device->dev;
-		sgt = &drv_data->rx_sgt;
-		buf = drv_data->rx;
-	}
-
-	nents = DIV_ROUND_UP(len, SZ_2K);
-	if (nents != sgt->nents) {
-		int ret;
-
-		sg_free_table(sgt);
-		ret = sg_alloc_table(sgt, nents, GFP_ATOMIC);
-		if (ret)
-			return ret;
-	}
-
-	pbuf = buf;
-	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
-		size_t bytes = min_t(size_t, len, SZ_2K);
-
-		sg_set_buf(sg, pbuf, bytes);
-		pbuf += bytes;
-		len -= bytes;
-	}
-
-	nents = dma_map_sg(dmadev, sgt->sgl, sgt->nents, dir);
-	if (!nents)
-		return -ENOMEM;
-
-	return nents;
-}
-
-static void pxa2xx_spi_unmap_dma_buffer(struct driver_data *drv_data,
-					enum dma_data_direction dir)
-{
-	struct device *dmadev;
-	struct sg_table *sgt;
-
-	if (dir == DMA_TO_DEVICE) {
-		dmadev = drv_data->tx_chan->device->dev;
-		sgt = &drv_data->tx_sgt;
-	} else {
-		dmadev = drv_data->rx_chan->device->dev;
-		sgt = &drv_data->rx_sgt;
-	}
-
-	dma_unmap_sg(dmadev, sgt->sgl, sgt->nents, dir);
-}
-
-static void pxa2xx_spi_unmap_dma_buffers(struct driver_data *drv_data)
-{
-	if (!drv_data->dma_mapped)
-		return;
-
-	pxa2xx_spi_unmap_dma_buffer(drv_data, DMA_FROM_DEVICE);
-	pxa2xx_spi_unmap_dma_buffer(drv_data, DMA_TO_DEVICE);
-
-	drv_data->dma_mapped = 0;
-}
-
 static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 					     bool error)
 {
@@ -125,8 +52,6 @@ static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 			pxa2xx_spi_write(drv_data, SSTO, 0);
 
 		if (!error) {
-			pxa2xx_spi_unmap_dma_buffers(drv_data);
-
 			msg->actual_length += drv_data->len;
 			msg->state = pxa2xx_spi_next_transfer(drv_data);
 		} else {
@@ -152,11 +77,12 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 			   enum dma_transfer_direction dir)
 {
 	struct chip_data *chip = drv_data->cur_chip;
+	struct spi_transfer *xfer = drv_data->cur_transfer;
 	enum dma_slave_buswidth width;
 	struct dma_slave_config cfg;
 	struct dma_chan *chan;
 	struct sg_table *sgt;
-	int nents, ret;
+	int ret;
 
 	switch (drv_data->n_bytes) {
 	case 1:
@@ -178,17 +104,15 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 		cfg.dst_addr_width = width;
 		cfg.dst_maxburst = chip->dma_burst_size;
 
-		sgt = &drv_data->tx_sgt;
-		nents = drv_data->tx_nents;
-		chan = drv_data->tx_chan;
+		sgt = &xfer->tx_sg;
+		chan = drv_data->master->dma_tx;
 	} else {
 		cfg.src_addr = drv_data->ssdr_physical;
 		cfg.src_addr_width = width;
 		cfg.src_maxburst = chip->dma_burst_size;
 
-		sgt = &drv_data->rx_sgt;
-		nents = drv_data->rx_nents;
-		chan = drv_data->rx_chan;
+		sgt = &xfer->rx_sg;
+		chan = drv_data->master->dma_rx;
 	}
 
 	ret = dmaengine_slave_config(chan, &cfg);
@@ -197,46 +121,10 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 		return NULL;
 	}
 
-	return dmaengine_prep_slave_sg(chan, sgt->sgl, nents, dir,
+	return dmaengine_prep_slave_sg(chan, sgt->sgl, sgt->nents, dir,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 }
 
-bool pxa2xx_spi_dma_is_possible(size_t len)
-{
-	return len <= MAX_DMA_LEN;
-}
-
-int pxa2xx_spi_map_dma_buffers(struct driver_data *drv_data)
-{
-	const struct chip_data *chip = drv_data->cur_chip;
-	int ret;
-
-	if (!chip->enable_dma)
-		return 0;
-
-	/* Don't bother with DMA if we can't do even a single burst */
-	if (drv_data->len < chip->dma_burst_size)
-		return 0;
-
-	ret = pxa2xx_spi_map_dma_buffer(drv_data, DMA_TO_DEVICE);
-	if (ret <= 0) {
-		dev_warn(&drv_data->pdev->dev, "failed to DMA map TX\n");
-		return 0;
-	}
-
-	drv_data->tx_nents = ret;
-
-	ret = pxa2xx_spi_map_dma_buffer(drv_data, DMA_FROM_DEVICE);
-	if (ret <= 0) {
-		pxa2xx_spi_unmap_dma_buffer(drv_data, DMA_TO_DEVICE);
-		dev_warn(&drv_data->pdev->dev, "failed to DMA map RX\n");
-		return 0;
-	}
-
-	drv_data->rx_nents = ret;
-	return 1;
-}
-
 irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 {
 	u32 status;
@@ -245,8 +133,8 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 	if (status & SSSR_ROR) {
 		dev_err(&drv_data->pdev->dev, "FIFO overrun\n");
 
-		dmaengine_terminate_async(drv_data->rx_chan);
-		dmaengine_terminate_async(drv_data->tx_chan);
+		dmaengine_terminate_async(drv_data->master->dma_rx);
+		dmaengine_terminate_async(drv_data->master->dma_tx);
 
 		pxa2xx_spi_dma_transfer_complete(drv_data, true);
 		return IRQ_HANDLED;
@@ -285,16 +173,15 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_data, u32 dma_burst)
 	return 0;
 
 err_rx:
-	dmaengine_terminate_async(drv_data->tx_chan);
+	dmaengine_terminate_async(drv_data->master->dma_tx);
 err_tx:
-	pxa2xx_spi_unmap_dma_buffers(drv_data);
 	return err;
 }
 
 void pxa2xx_spi_dma_start(struct driver_data *drv_data)
 {
-	dma_async_issue_pending(drv_data->rx_chan);
-	dma_async_issue_pending(drv_data->tx_chan);
+	dma_async_issue_pending(drv_data->master->dma_rx);
+	dma_async_issue_pending(drv_data->master->dma_tx);
 
 	atomic_set(&drv_data->dma_running, 1);
 }
@@ -303,21 +190,22 @@ int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 {
 	struct pxa2xx_spi_master *pdata = drv_data->master_info;
 	struct device *dev = &drv_data->pdev->dev;
+	struct spi_master *master = drv_data->master;
 	dma_cap_mask_t mask;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	drv_data->tx_chan = dma_request_slave_channel_compat(mask,
+	master->dma_tx = dma_request_slave_channel_compat(mask,
 				pdata->dma_filter, pdata->tx_param, dev, "tx");
-	if (!drv_data->tx_chan)
+	if (!master->dma_tx)
 		return -ENODEV;
 
-	drv_data->rx_chan = dma_request_slave_channel_compat(mask,
+	master->dma_rx = dma_request_slave_channel_compat(mask,
 				pdata->dma_filter, pdata->rx_param, dev, "rx");
-	if (!drv_data->rx_chan) {
-		dma_release_channel(drv_data->tx_chan);
-		drv_data->tx_chan = NULL;
+	if (!master->dma_rx) {
+		dma_release_channel(master->dma_tx);
+		master->dma_tx = NULL;
 		return -ENODEV;
 	}
 
@@ -326,17 +214,17 @@ int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 
 void pxa2xx_spi_dma_release(struct driver_data *drv_data)
 {
-	if (drv_data->rx_chan) {
-		dmaengine_terminate_sync(drv_data->rx_chan);
-		dma_release_channel(drv_data->rx_chan);
-		sg_free_table(&drv_data->rx_sgt);
-		drv_data->rx_chan = NULL;
+	struct spi_master *master = drv_data->master;
+
+	if (master->dma_rx) {
+		dmaengine_terminate_sync(master->dma_rx);
+		dma_release_channel(master->dma_rx);
+		master->dma_rx = NULL;
 	}
-	if (drv_data->tx_chan) {
-		dmaengine_terminate_sync(drv_data->tx_chan);
-		dma_release_channel(drv_data->tx_chan);
-		sg_free_table(&drv_data->tx_sgt);
-		drv_data->tx_chan = NULL;
+	if (master->dma_tx) {
+		dmaengine_terminate_sync(master->dma_tx);
+		dma_release_channel(master->dma_tx);
+		master->dma_tx = NULL;
 	}
 }
 
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e5c457abb596..3e90a4ce668b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -912,6 +912,17 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 	return clk_div << 8;
 }
 
+static bool pxa2xx_spi_can_dma(struct spi_master *master,
+			       struct spi_device *spi,
+			       struct spi_transfer *xfer)
+{
+	struct chip_data *chip = spi_get_ctldata(spi);
+
+	return chip->enable_dma &&
+	       xfer->len <= MAX_DMA_LEN &&
+	       xfer->len >= chip->dma_burst_size;
+}
+
 static void pump_transfers(unsigned long data)
 {
 	struct driver_data *drv_data = (struct driver_data *)data;
@@ -929,6 +940,7 @@ static void pump_transfers(unsigned long data)
 	u32 dma_burst = drv_data->cur_chip->dma_burst_size;
 	u32 change_mask = pxa2xx_spi_get_ssrc1_change_mask(drv_data);
 	int err;
+	int dma_mapped;
 
 	/* Get current state information */
 	message = drv_data->cur_msg;
@@ -963,7 +975,7 @@ static void pump_transfers(unsigned long data)
 	}
 
 	/* Check if we can DMA this transfer */
-	if (!pxa2xx_spi_dma_is_possible(transfer->len) && chip->enable_dma) {
+	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
 
 		/* reject already-mapped transfers; PIO won't always work */
 		if (message->is_dma_mapped
@@ -1040,10 +1052,10 @@ static void pump_transfers(unsigned long data)
 
 	message->state = RUNNING_STATE;
 
-	drv_data->dma_mapped = 0;
-	if (pxa2xx_spi_dma_is_possible(drv_data->len))
-		drv_data->dma_mapped = pxa2xx_spi_map_dma_buffers(drv_data);
-	if (drv_data->dma_mapped) {
+	dma_mapped = master->can_dma &&
+		     master->can_dma(master, message->spi, transfer) &&
+		     master->cur_msg_mapped;
+	if (dma_mapped) {
 
 		/* Ensure we have the correct interrupt handler */
 		drv_data->transfer_handler = pxa2xx_spi_dma_transfer;
@@ -1075,12 +1087,12 @@ static void pump_transfers(unsigned long data)
 		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
 			master->max_speed_hz
 				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
-			drv_data->dma_mapped ? "DMA" : "PIO");
+			dma_mapped ? "DMA" : "PIO");
 	else
 		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
 			master->max_speed_hz / 2
 				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
-			drv_data->dma_mapped ? "DMA" : "PIO");
+			dma_mapped ? "DMA" : "PIO");
 
 	if (is_lpss_ssp(drv_data)) {
 		if ((pxa2xx_spi_read(drv_data, SSIRF) & 0xff)
@@ -1594,6 +1606,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		if (status) {
 			dev_dbg(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma = false;
+		} else {
+			master->can_dma = pxa2xx_spi_can_dma;
 		}
 	}
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index e6b09000ff14..d217ad55cc12 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -50,12 +50,6 @@ struct driver_data {
 	struct tasklet_struct pump_transfers;
 
 	/* DMA engine support */
-	struct dma_chan *rx_chan;
-	struct dma_chan *tx_chan;
-	struct sg_table rx_sgt;
-	struct sg_table tx_sgt;
-	int rx_nents;
-	int tx_nents;
 	atomic_t dma_running;
 
 	/* Current message transfer state info */
@@ -67,7 +61,6 @@ struct driver_data {
 	void *tx_end;
 	void *rx;
 	void *rx_end;
-	int dma_mapped;
 	u8 n_bytes;
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
@@ -145,8 +138,6 @@ extern void *pxa2xx_spi_next_transfer(struct driver_data *drv_data);
 #define MAX_DMA_LEN		SZ_64K
 #define DEFAULT_DMA_CR1		(SSCR1_TSRE | SSCR1_RSRE | SSCR1_TRAIL)
 
-extern bool pxa2xx_spi_dma_is_possible(size_t len);
-extern int pxa2xx_spi_map_dma_buffers(struct driver_data *drv_data);
 extern irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data);
 extern int pxa2xx_spi_dma_prepare(struct driver_data *drv_data, u32 dma_burst);
 extern void pxa2xx_spi_dma_start(struct driver_data *drv_data);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
