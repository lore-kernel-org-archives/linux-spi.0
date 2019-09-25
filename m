From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 2/2] spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver
Date: Wed, 25 Sep 2019 11:11:43 +0200
Message-ID: <20190925091143.15468-3-lukma@denx.de>
References: <20190924110547.14770-1-lukma@denx.de>
 <20190925091143.15468-1-lukma@denx.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190925091143.15468-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This change provides the dspi_slave_abort() function, which is a callback
for slave_abort() method of SPI controller generic driver.

As in the SPI slave mode the transmission is driven by master, any
distortion may cause the slave to enter undefined internal state.
To avoid this problem the dspi_slave_abort() terminates all pending and
ongoing DMA transactions (with sync) and clears internal FIFOs.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- None
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
