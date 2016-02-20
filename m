From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: replace fixed timeout with calculated" to the spi tree
Date: Sun, 21 Feb 2016 03:11:03 +0900
Message-ID: <E1aXBzj-0001um-6i@finisterre>
References: <1455715739-25161-4-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455715739-25161-4-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: replace fixed timeout with calculated

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

>From 4bfe927a11b18db447706507654aef83c9ef15c1 Mon Sep 17 00:00:00 2001
From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Fri, 19 Feb 2016 08:43:03 +0100
Subject: [PATCH] spi: imx: replace fixed timeout with calculated

Fixed timeout value can fire while transaction is ongoing. This may happen
because there are no strict requirements on SPI transaction duration.
Dynamic timeout value is generated based on SCLK and transaction size.

There is also 4 * SCLK delay between TX bursts related to HW internal CS change.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c5eeb84..6497fc9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -56,7 +56,6 @@
 
 /* The maximum  bytes that a sdma BD can transfer.*/
 #define MAX_SDMA_BD_BYTES  (1 << 15)
-#define IMX_DMA_TIMEOUT (msecs_to_jiffies(3000))
 struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
@@ -93,6 +92,7 @@ struct spi_imx_data {
 	struct clk *clk_per;
 	struct clk *clk_ipg;
 	unsigned long spi_clk;
+	unsigned int spi_bus_clk;
 
 	unsigned int count;
 	void (*tx)(struct spi_imx_data *);
@@ -333,6 +333,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 
 	/* set clock speed */
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, config->speed_hz, &clk);
+	spi_imx->spi_bus_clk = clk;
 
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
@@ -915,11 +916,26 @@ static void spi_imx_dma_tx_callback(void *cookie)
 	complete(&spi_imx->dma_tx_completion);
 }
 
+static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
+{
+	unsigned long timeout = 0;
+
+	/* Time with actual data transfer and CS change delay related to HW */
+	timeout = (8 + 4) * size / spi_imx->spi_bus_clk;
+
+	/* Add extra second for scheduler related activities */
+	timeout += 1;
+
+	/* Double calculated timeout */
+	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
+}
+
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
 	struct dma_async_tx_descriptor *desc_tx = NULL, *desc_rx = NULL;
 	int ret;
+	unsigned long transfer_timeout;
 	unsigned long timeout;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
@@ -966,16 +982,18 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	dma_async_issue_pending(master->dma_tx);
 	spi_imx->devtype_data->trigger(spi_imx);
 
+	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
+
 	/* Wait SDMA to finish the data transfer.*/
 	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
-						IMX_DMA_TIMEOUT);
+						transfer_timeout);
 	if (!timeout) {
 		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
 		dmaengine_terminate_all(master->dma_tx);
 		dmaengine_terminate_all(master->dma_rx);
 	} else {
 		timeout = wait_for_completion_timeout(
-				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
+				&spi_imx->dma_rx_completion, transfer_timeout);
 		if (!timeout) {
 			dev_err(spi_imx->dev, "I/O Error in DMA RX\n");
 			spi_imx->devtype_data->reset(spi_imx);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
