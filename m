From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver" to the spi tree
Date: Tue,  1 Oct 2019 12:41:05 +0100 (BST)
Message-ID: <20191001114105.7830D2742A10@ypsilon.sirena.org.uk>
References: <20190924110547.14770-3-lukma@denx.de>
Cc: krzk@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924110547.14770-3-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From f4b323905d8b3e28b2a9cef9325dbec1b0f7f064 Mon Sep 17 00:00:00 2001
From: Lukasz Majewski <lukma@denx.de>
Date: Tue, 24 Sep 2019 13:05:47 +0200
Subject: [PATCH] spi: Introduce dspi_slave_abort() function for NXP's dspi SPI
 driver

This change provides the dspi_slave_abort() function, which is a callback
for slave_abort() method of SPI controller generic driver.

As in the SPI slave mode the transmission is driven by master, any
distortion may cause the slave to enter undefined internal state.
To avoid this problem the dspi_slave_abort() terminates all pending and
ongoing DMA transactions (with sync) and clears internal FIFOs.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Link: https://lore.kernel.org/r/20190924110547.14770-3-lukma@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index bec758e978fb..2c0f211eed87 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1006,6 +1006,25 @@ static void dspi_init(struct fsl_dspi *dspi)
 			     SPI_CTARE_FMSZE(0) | SPI_CTARE_DTCP(1));
 }
 
+static int dspi_slave_abort(struct spi_master *master)
+{
+	struct fsl_dspi *dspi = spi_master_get_devdata(master);
+
+	/*
+	 * Terminate all pending DMA transactions for the SPI working
+	 * in SLAVE mode.
+	 */
+	dmaengine_terminate_sync(dspi->dma->chan_rx);
+	dmaengine_terminate_sync(dspi->dma->chan_tx);
+
+	/* Clear the internal DSPI RX and TX FIFO buffers */
+	regmap_update_bits(dspi->regmap, SPI_MCR,
+			   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
+			   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
+
+	return 0;
+}
+
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1030,6 +1049,7 @@ static int dspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	ctlr->cleanup = dspi_cleanup;
+	ctlr->slave_abort = dspi_slave_abort;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 
 	pdata = dev_get_platdata(&pdev->dev);
-- 
2.20.1
