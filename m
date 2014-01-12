From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH V2 3/8] spi: rspi: Add support for more than one interrupt
Date: Sun, 12 Jan 2014 11:27:39 +0100
Message-ID: <1389522464-1569-4-git-send-email-geert@linux-m68k.org>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389522464-1569-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Add support for up to 3 interrupts, based on the SDK reference code.
This is needed for RZ/A1H.

Minimum 1 and maximum 3 interrupts can be passed via platform device
resources.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
v2:
  - s/irq[]/irqs[]/
  - s/numirq/num_irqs/
  - Use unsigned int for loop counters that cannot be negative
  - Merge the platform_get_irq() and devm_request_irq() loops
  - Do not update copyright header in further untouched rspi.h

 drivers/spi/spi-rspi.c |   52 +++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index eded530763ca..45da760281f9 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1,7 +1,7 @@
 /*
  * SH RSPI driver
  *
- * Copyright (C) 2012  Renesas Solutions Corp.
+ * Copyright (C) 2012, 2013  Renesas Solutions Corp.
  *
  * Based on spi-sh.c:
  * Copyright (C) 2011 Renesas Solutions Corp.
@@ -176,6 +176,7 @@
 #define SPBFCR_RXTRG_MASK	0x07	/* Receive Buffer Data Triggering Number */
 
 #define DUMMY_DATA		0x00
+#define MAX_NUM_IRQ		3
 
 struct rspi_data {
 	void __iomem *addr;
@@ -187,12 +188,13 @@ struct rspi_data {
 	spinlock_t lock;
 	struct clk *clk;
 	u8 spsr;
+	int irqs[MAX_NUM_IRQ];
+	unsigned int num_irqs;
 	const struct spi_ops *ops;
 
 	/* for dmaengine */
 	struct dma_chan *chan_tx;
 	struct dma_chan *chan_rx;
-	int irq;
 
 	unsigned dma_width_16bit:1;
 	unsigned dma_callbacked:1;
@@ -470,7 +472,7 @@ static int rspi_send_dma(struct rspi_data *rspi, struct spi_transfer *t)
 	struct scatterlist sg;
 	const void *buf = NULL;
 	struct dma_async_tx_descriptor *desc;
-	unsigned len;
+	unsigned int len, i;
 	int ret = 0;
 
 	if (rspi->dma_width_16bit) {
@@ -508,7 +510,8 @@ static int rspi_send_dma(struct rspi_data *rspi, struct spi_transfer *t)
 	 * DMAC needs SPTIE, but if SPTIE is set, this IRQ routine will be
 	 * called. So, this driver disables the IRQ while DMA transfer.
 	 */
-	disable_irq(rspi->irq);
+	for (i = 0; i < rspi->num_irqs; i++)
+		disable_irq(rspi->irqs[i]);
 
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_TXMD, RSPI_SPCR);
 	rspi_enable_irq(rspi, SPCR_SPTIE);
@@ -527,7 +530,8 @@ static int rspi_send_dma(struct rspi_data *rspi, struct spi_transfer *t)
 		ret = -ETIMEDOUT;
 	rspi_disable_irq(rspi, SPCR_SPTIE);
 
-	enable_irq(rspi->irq);
+	for (i = 0; i < rspi->num_irqs; i++)
+		enable_irq(rspi->irqs[i]);
 
 end:
 	rspi_dma_unmap_sg(&sg, rspi->chan_tx, DMA_TO_DEVICE);
@@ -636,7 +640,7 @@ static int rspi_receive_dma(struct rspi_data *rspi, struct spi_transfer *t)
 	struct scatterlist sg, sg_dummy;
 	void *dummy = NULL, *rx_buf = NULL;
 	struct dma_async_tx_descriptor *desc, *desc_dummy;
-	unsigned len;
+	unsigned int len, i;
 	int ret = 0;
 
 	if (rspi->dma_width_16bit) {
@@ -694,7 +698,8 @@ static int rspi_receive_dma(struct rspi_data *rspi, struct spi_transfer *t)
 	 * DMAC needs SPTIE, but if SPTIE is set, this IRQ routine will be
 	 * called. So, this driver disables the IRQ while DMA transfer.
 	 */
-	disable_irq(rspi->irq);
+	for (i = 0; i < rspi->num_irqs; i++)
+		disable_irq(rspi->irqs[i]);
 
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_TXMD, RSPI_SPCR);
 	rspi_enable_irq(rspi, SPCR_SPTIE | SPCR_SPRIE);
@@ -717,7 +722,8 @@ static int rspi_receive_dma(struct rspi_data *rspi, struct spi_transfer *t)
 		ret = -ETIMEDOUT;
 	rspi_disable_irq(rspi, SPCR_SPTIE | SPCR_SPRIE);
 
-	enable_irq(rspi->irq);
+	for (i = 0; i < rspi->num_irqs; i++)
+		enable_irq(rspi->irqs[i]);
 
 end:
 	rspi_dma_unmap_sg(&sg, rspi->chan_rx, DMA_FROM_DEVICE);
@@ -928,6 +934,7 @@ static int rspi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct rspi_data *rspi;
 	int ret, irq;
+	unsigned int i;
 	char clk_name[16];
 	const struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
 	const struct spi_ops *ops;
@@ -940,12 +947,6 @@ static int rspi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq error\n");
-		return -ENODEV;
-	}
-
 	master = spi_alloc_master(&pdev->dev, sizeof(struct rspi_data));
 	if (master == NULL) {
 		dev_err(&pdev->dev, "spi_alloc_master error.\n");
@@ -988,14 +989,25 @@ static int rspi_probe(struct platform_device *pdev)
 	master->transfer = rspi_transfer;
 	master->cleanup = rspi_cleanup;
 
-	ret = devm_request_irq(&pdev->dev, irq, rspi_irq, 0,
-			       dev_name(&pdev->dev), rspi);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq error\n");
-		goto error1;
+	for (i = 0; i < MAX_NUM_IRQ; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			if (rspi->num_irqs)
+				break;
+			dev_err(&pdev->dev, "platform_get_irq error\n");
+			ret = -ENODEV;
+			goto error1;
+		}
+		ret = devm_request_irq(&pdev->dev, irq, rspi_irq, 0,
+				       dev_name(&pdev->dev), rspi);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "request_irq %d error\n", irq);
+			goto error1;
+		}
+		rspi->irqs[i] = irq;
+		rspi->num_irqs++;
 	}
 
-	rspi->irq = irq;
 	ret = rspi_request_dma(rspi, pdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "rspi_request_dma failed.\n");
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
