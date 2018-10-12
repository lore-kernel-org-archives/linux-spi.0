From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: move wml setting to later than setup_transfer" to the spi tree
Date: Fri, 12 Oct 2018 19:01:32 +0200 (CEST)
Message-ID: <20181012170132.4B40D440078@finisterre.ee.mobilebroadband>
References: <1539196453-8704-2-git-send-email-yibin.gong@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, linux-spi@vger.kernel.org
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539196453-8704-2-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: move wml setting to later than setup_transfer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 987a2dfe3f0485a82d87106e7e1c43f35c1d3b09 Mon Sep 17 00:00:00 2001
From: Robin Gong <yibin.gong@nxp.com>
Date: Wed, 10 Oct 2018 10:32:42 +0000
Subject: [PATCH] spi: imx: move wml setting to later than setup_transfer

Current dynamic burst length is based on the whole transfer length,
that's ok if there is only one sg, but is not right in case multi sgs
in one transfer,because the tail data should be based on the last sg
length instead of the whole transfer length. Move wml setting for DMA
to the later place, thus, the next patch could get the right last sg
length for wml setting. This patch is a preparation one, no any
function change involved.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 08dd3a31a3e5..e861157e3459 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -63,6 +63,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	void (*setup_wml)(struct spi_imx_data *);
 	void (*disable)(struct spi_imx_data *);
 	bool has_dmamode;
 	bool has_slavemode;
@@ -583,6 +584,11 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	else			/* SCLK is _very_ slow */
 		usleep_range(delay, delay + 10);
 
+	return 0;
+}
+
+static void mx51_setup_wml(struct spi_imx_data *spi_imx)
+{
 	/*
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
@@ -593,8 +599,6 @@ static int mx51_ecspi_config(struct spi_device *spi)
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
-
-	return 0;
 }
 
 static int mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
@@ -931,6 +935,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.setup_wml = mx51_setup_wml,
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.dynamic_burst = true,
@@ -1138,7 +1143,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
-	int ret;
 
 	if (!t)
 		return 0;
@@ -1179,12 +1183,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	else
 		spi_imx->usedma = 0;
 
-	if (spi_imx->usedma) {
-		ret = spi_imx_dma_configure(spi->master);
-		if (ret)
-			return ret;
-	}
-
 	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
 		spi_imx->rx = mx53_ecspi_rx_slave;
 		spi_imx->tx = mx53_ecspi_tx_slave;
@@ -1289,6 +1287,13 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	unsigned long timeout;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
+	int ret;
+
+	ret = spi_imx_dma_configure(master);
+	if (ret)
+		return ret;
+
+	spi_imx->devtype_data->setup_wml(spi_imx);
 
 	/*
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
-- 
2.19.0
