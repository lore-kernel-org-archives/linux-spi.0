From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 3/3] ARM: dspi: Provide support for DSPI slave more operation (Vybryd vf610)
Date: Tue, 18 Sep 2018 11:34:37 +0200
Message-ID: <20180918093437.26799-4-lukma@denx.de>
References: <20180918093437.26799-1-lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918093437.26799-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The NXP's Vybryd vf610 can work as a SPI slave device (the CS and clock
signal are provided by master).

It is possible to specify a single device to work in that mode. As we do
use DMA for transferring data, the RX channel must be prepared for
incoming data.
Moreover, in slave mode we just set a subset of control fields in
configuration registers (CTAR0, PUSHR).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/spi/spi-fsl-dspi.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 472385f0a842..1d71f6fd2e0b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -209,6 +209,14 @@ struct fsl_dspi {
 	struct fsl_dspi_dma	*dma;
 };
 
+static inline bool dspi_slave_mode(struct fsl_dspi *dspi)
+{
+	if (!(dspi->cur_chip->mcr_val & SPI_MCR_MASTER))
+		return true;
+
+	return false;
+}
+
 static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 {
 	u32 txdata = 0;
@@ -230,6 +238,9 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
 
+	if (dspi_slave_mode(dspi))
+		return data;
+
 	if (dspi->len > 0)
 		cmd |= SPI_PUSHR_CMD_CONT;
 	return cmd << 16 | data;
@@ -326,6 +337,11 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	dma_async_issue_pending(dma->chan_rx);
 	dma_async_issue_pending(dma->chan_tx);
 
+	if (dspi_slave_mode(dspi)) {
+		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
+		return 0;
+	}
+
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
 					DMA_COMPLETION_TIMEOUT);
 	if (time_left == 0) {
@@ -781,6 +797,10 @@ static int dspi_setup(struct spi_device *spi)
 
 		of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
 				&sck_cs_delay);
+
+		if (of_property_read_bool(spi->dev.of_node,
+					  "fsl,spi-slave-mode"))
+			chip->mcr_val &= ~SPI_MCR_MASTER;
 	} else {
 		cs_sck_delay = pdata->cs_sck_delay;
 		sck_cs_delay = pdata->sck_cs_delay;
@@ -798,14 +818,18 @@ static int dspi_setup(struct spi_device *spi)
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
+	if (chip->mcr_val & SPI_MCR_MASTER) {
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
 
-- 
2.11.0
