From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Subject: [PATCH 7/8] spi: rspi: Add support for specifying CPHA/CPOL
Date: Tue, 24 Dec 2013 12:40:47 +0100
Message-ID: <1387885248-28425-8-git-send-email-geert+renesas@linux-m68k.org>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for specifying the SPI clock phase and polarity, based on the
SDK reference code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 34674fe6df5d..850025278519 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -181,6 +181,7 @@ struct rspi_data {
 	u8 spsr;
 	u8 spdcr;
 	u8 data_width;
+	u16 spcmd;
 	int irq[MAX_NUM_IRQ];
 	unsigned int numirq;
 	const struct spi_ops *ops;
@@ -328,7 +329,7 @@ static int rspi_set_config_register(const struct rspi_data *rspi,
 		rspi_write8(rspi, 0x00, RSPI_SPCR2);
 
 	/* Sets SPCMD */
-	rspi_write16(rspi, SPCMD_SPB_8_TO_16(access_size) | SPCMD_SSLKP,
+	rspi_write16(rspi, SPCMD_SPB_8_TO_16(access_size) | rspi->spcmd,
 		     RSPI_SPCMD0);
 
 	/* Sets RSPI mode */
@@ -383,7 +384,7 @@ static int qspi_set_config_register(const struct rspi_data *rspi,
 	else
 		spcmd = SPCMD_SPB_32BIT;
 
-	spcmd |= SPCMD_SCKDEN | SPCMD_SLNDEN | SPCMD_SSLKP | SPCMD_SPNDEN;
+	spcmd |= SPCMD_SCKDEN | SPCMD_SLNDEN | rspi->spcmd | SPCMD_SPNDEN;
 
 	/* Resets transfer data length */
 	rspi_write32(rspi, 0, QSPI_SPBMUL0);
@@ -903,6 +904,12 @@ static int rspi_setup(struct spi_device *spi)
 		spi->bits_per_word = 8;
 	rspi->max_speed_hz = spi->max_speed_hz;
 
+	rspi->spcmd = SPCMD_SSLKP;
+	if (spi->mode & SPI_CPOL)
+		rspi->spcmd |= SPCMD_CPOL;
+	if (spi->mode & SPI_CPHA)
+		rspi->spcmd |= SPCMD_CPHA;
+
 	set_config_register(rspi, 8);
 
 	return 0;
@@ -1092,6 +1099,7 @@ static int rspi_probe(struct platform_device *pdev)
 	master->setup = rspi_setup;
 	master->transfer = rspi_transfer;
 	master->cleanup = rspi_cleanup;
+	master->mode_bits = SPI_CPHA | SPI_CPOL;
 
 	for (i = 0; i < rspi->numirq; i++) {
 		ret = devm_request_irq(&pdev->dev, rspi->irq[i], rspi_irq, 0,
-- 
1.7.9.5

