From: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] spi: imx: add support for all SPI word width for DMA transfer
Date: Sun, 1 Mar 2015 15:15:33 +0100
Message-ID: <1425219333-3014-3-git-send-email-anton_bondarenko@mentor.com>
References: <1425219333-3014-1-git-send-email-anton_bondarenko@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	<b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425219333-3014-1-git-send-email-anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

DMA transfer for SPI was limited to up to 8 bits word size until now.
Sync in SPI burst size and DMA bus width is necessary to correctly
support other BPW supported by HW.

Signed-off-by: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-imx.c | 118 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f22d9cc..10d735d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -89,11 +89,15 @@ struct spi_imx_data {
 
 	struct completion xfer_done;
 	void __iomem *base;
+	unsigned long base_phys;
+
 	struct clk *clk_per;
 	struct clk *clk_ipg;
 	unsigned long spi_clk;
 	unsigned int spi_bus_clk;
 
+	unsigned int bpw_w;
+
 	unsigned int count;
 	void (*tx)(struct spi_imx_data *);
 	void (*rx)(struct spi_imx_data *);
@@ -199,8 +203,14 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 			 struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	unsigned int bpw_w = transfer->bits_per_word;
+
+	if (!bpw_w)
+		bpw_w = spi->bits_per_word;
+
+	bpw_w = DIV_ROUND_UP(bpw_w, 8);
 
-	if (spi_imx->dma_is_inited && (transfer->len > spi_imx->wml))
+	if (spi_imx->dma_is_inited && (transfer->len > spi_imx->wml * bpw_w))
 		return true;
 	return false;
 }
@@ -757,11 +767,62 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int spi_imx_sdma_configure(struct spi_master *master)
+{
+	int ret;
+	enum dma_slave_buswidth dsb_default = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	struct dma_slave_config slave_config = {};
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+
+	switch (spi_imx->bpw_w) {
+	case 4:
+		dsb_default = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	case 2:
+		dsb_default = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 1:
+		dsb_default = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	default:
+		pr_err("Not supported word size %d\n", spi_imx->bpw_w);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	slave_config.direction = DMA_MEM_TO_DEV;
+	slave_config.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
+	slave_config.dst_addr_width = dsb_default;
+	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx)
+					- spi_imx->wml;
+	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
+	if (ret) {
+		pr_err("error in TX dma configuration.\n");
+		goto err;
+	}
+
+	memset(&slave_config, 0, sizeof(slave_config));
+
+	slave_config.direction = DMA_DEV_TO_MEM;
+	slave_config.src_addr = spi_imx->base_phys + MXC_CSPIRXDATA;
+	slave_config.src_addr_width = dsb_default;
+	slave_config.src_maxburst = spi_imx_get_fifosize(spi_imx)
+					- spi_imx->wml;
+	ret = dmaengine_slave_config(master->dma_rx, &slave_config);
+	if (ret)
+		pr_err("error in RX dma configuration.\n");
+
+err:
+	return ret;
+}
+
 static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	struct spi_imx_config config;
+	unsigned int bpw_w_new;
+	int ret = 0;
 
 	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
 	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
@@ -785,9 +846,18 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->tx = spi_imx_buf_tx_u32;
 	}
 
-	spi_imx->devtype_data->config(spi_imx, &config);
+	bpw_w_new = DIV_ROUND_UP(config.bpw, 8);
+	if (spi_imx->dma_is_inited && spi_imx->bpw_w != bpw_w_new) {
+		spi_imx->bpw_w = bpw_w_new;
+		ret = spi_imx_sdma_configure(spi->master);
+		if (ret != 0)
+			pr_err("Can't configure SDMA, error %d\n", ret);
+	}
 
-	return 0;
+	if (!ret)
+		ret = spi_imx->devtype_data->config(spi_imx, &config);
+
+	return ret;
 }
 
 static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
@@ -808,10 +878,8 @@ static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
 }
 
 static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
-			     struct spi_master *master,
-			     const struct resource *res)
+			     struct spi_master *master)
 {
-	struct dma_slave_config slave_config = {};
 	int ret;
 
 	/* use pio mode for i.mx6dl chip TKT238285 */
@@ -828,17 +896,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 		goto err;
 	}
 
-	slave_config.direction = DMA_MEM_TO_DEV;
-	slave_config.dst_addr = res->start + MXC_CSPITXDATA;
-	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx)
-					- spi_imx->wml;
-	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
-	if (ret) {
-		dev_err(dev, "error in TX dma configuration.\n");
-		goto err;
-	}
-
 	/* Prepare for RX : */
 	master->dma_rx = dma_request_slave_channel(dev, "rx");
 	if (!master->dma_rx) {
@@ -847,23 +904,19 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 		goto err;
 	}
 
-	slave_config.direction = DMA_DEV_TO_MEM;
-	slave_config.src_addr = res->start + MXC_CSPIRXDATA;
-	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	slave_config.src_maxburst = spi_imx_get_fifosize(spi_imx)
-					- spi_imx->wml;
-	ret = dmaengine_slave_config(master->dma_rx, &slave_config);
-	if (ret) {
-		dev_err(dev, "error in RX dma configuration.\n");
-		goto err;
-	}
-
 	init_completion(&spi_imx->dma_rx_completion);
 	init_completion(&spi_imx->dma_tx_completion);
 	master->can_dma = spi_imx_can_dma;
 	master->max_dma_len = MAX_SDMA_BD_BYTES;
 	spi_imx->bitbang.master->flags = SPI_MASTER_MUST_RX |
 					 SPI_MASTER_MUST_TX;
+	spi_imx->bpw_w = 1;
+	ret = spi_imx_sdma_configure(master);
+	if (ret) {
+		dev_info(dev, "cannot get setup DMA.\n");
+		goto err;
+	}
+
 	spi_imx->dma_is_inited = 1;
 
 	return 0;
@@ -920,7 +973,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	int ret;
 	unsigned long timeout;
 	unsigned long transfer_timeout;
-	const int left = transfer->len % spi_imx->wml;
+	const int left = transfer->len % (spi_imx->wml * spi_imx->bpw_w);
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 
@@ -1001,7 +1054,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 
 			spi_imx->rx_buf = transfer->rx_buf
 						+ (transfer->len - left);
-			spi_imx->txfifo = left;
+			spi_imx->txfifo = DIV_ROUND_UP(left, spi_imx->bpw_w);
 			reinit_completion(&spi_imx->xfer_done);
 
 			spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TCEN);
@@ -1203,6 +1256,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 		ret = PTR_ERR(spi_imx->base);
 		goto out_master_put;
 	}
+	spi_imx->base_phys = res->start;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -1242,8 +1296,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx6 now, can remove the constrain if validated on
 	 * other chips.
 	 */
-	if (spi_imx->devtype_data == &imx51_ecspi_devtype_data
-	    && spi_imx_sdma_init(&pdev->dev, spi_imx, master, res))
+	if (spi_imx->devtype_data == &imx51_ecspi_devtype_data &&
+	    spi_imx_sdma_init(&pdev->dev, spi_imx, master))
 		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
 
 	spi_imx->devtype_data->reset(spi_imx);
-- 
2.3.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
