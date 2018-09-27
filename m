From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] ARM: dspi: Provide support for DSPI slave more operation (Vybryd vf610)
Date: Thu, 27 Sep 2018 17:07:09 +0200
Message-ID: <20180927150709.17010-1-lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The NXP's Vybryd vf610 can work as a SPI slave device (the CS and clock
signals are provided by master).

It is possible to specify a single device to work in that mode. As we do
use DMA for transferring data, the RX channel must be prepared for
incoming data.
Moreover, in slave mode we just set a subset of control fields in
configuration registers (CTAR0, PUSHR).

For testing the spidev_test program has been used.
Test script for this patch can be found here:
https://github.com/lmajewski/tests-spi/blob/master/tests/spi/spi_tests.sh


Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:

- Remove patch which adds extra NXP specific DTS property to support slave
mode and reuse the generic one (spi-slave)
- Remove patch which brings back the mcr_register local copy. It is not
needed as generic SPI slave infrastructure is used.
- Rewrite the code to use spi_controller_is_slave() helper functions
---
 drivers/spi/spi-fsl-dspi.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 7cb3ab0a35a0..05aeaf954f85 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -229,6 +229,9 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
 
+	if (spi_controller_is_slave(dspi->master))
+		return data;
+
 	if (dspi->len > 0)
 		cmd |= SPI_PUSHR_CMD_CONT;
 	return cmd << 16 | data;
@@ -325,6 +328,11 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	dma_async_issue_pending(dma->chan_rx);
 	dma_async_issue_pending(dma->chan_tx);
 
+	if (spi_controller_is_slave(dspi->master)) {
+		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
+		return 0;
+	}
+
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
 					DMA_COMPLETION_TIMEOUT);
 	if (time_left == 0) {
@@ -792,14 +800,18 @@ static int dspi_setup(struct spi_device *spi)
 	ns_delay_scale(&pasc, &asc, sck_cs_delay, clkrate);
 
 	chip->ctar_val = SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
-		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
-		| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
-		| SPI_CTAR_PCSSCK(pcssck)
-		| SPI_CTAR_CSSCK(cssck)
-		| SPI_CTAR_PASC(pasc)
-		| SPI_CTAR_ASC(asc)
-		| SPI_CTAR_PBR(pbr)
-		| SPI_CTAR_BR(br);
+		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0);
+
+	if (!spi_controller_is_slave(dspi->master)) {
+		chip->ctar_val |= SPI_CTAR_LSBFE(spi->mode &
+						 SPI_LSB_FIRST ? 1 : 0)
+			| SPI_CTAR_PCSSCK(pcssck)
+			| SPI_CTAR_CSSCK(cssck)
+			| SPI_CTAR_PASC(pasc)
+			| SPI_CTAR_ASC(asc)
+			| SPI_CTAR_PBR(pbr)
+			| SPI_CTAR_BR(br);
+	}
 
 	spi_set_ctldata(spi, chip);
 
@@ -964,8 +976,13 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
-	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS |
-		     (dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0));
+	unsigned int mcr = SPI_MCR_PCSIS |
+		(dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0);
+
+	if (!spi_controller_is_slave(dspi->master))
+		mcr |= SPI_MCR_MASTER;
+
+	regmap_write(dspi->regmap, SPI_MCR, mcr);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 	if (dspi->devtype_data->xspi_mode)
 		regmap_write(dspi->regmap, SPI_CTARE(0),
@@ -1021,6 +1038,9 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 		master->bus_num = bus_num;
 
+		if (of_property_read_bool(np, "spi-slave"))
+			master->slave = true;
+
 		dspi->devtype_data = of_device_get_match_data(&pdev->dev);
 		if (!dspi->devtype_data) {
 			dev_err(&pdev->dev, "can't get devtype_data\n");
-- 
2.11.0
