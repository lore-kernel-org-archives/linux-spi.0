From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/6] spi: rspi: Add support for GPIO chip selects
Date: Thu,  2 Jan 2020 14:38:22 +0100
Message-ID: <20200102133822.29346-7-geert+renesas@glider.be>
References: <20200102133822.29346-1-geert+renesas@glider.be>
Cc: Chris Brandt <chris.brandt@renesas.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102133822.29346-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for GPIO chip selects using GPIO descriptors.  As the RSPI
controller always drives a native chip select when performing a
transfer, at least one native chip select must be left unused.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 2f5a856a93192702..85575d45901cee1b 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -242,6 +242,7 @@ struct spi_ops {
 	u16 mode_bits;
 	u16 flags;
 	u16 fifo_size;
+	u8 num_hw_ss;
 };
 
 /*
@@ -934,7 +935,8 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 		rspi->spcmd |= SPCMD_CPHA;
 
 	/* Configure slave signal to assert */
-	rspi->spcmd |= SPCMD_SSLA(spi->chip_select);
+	rspi->spcmd |= SPCMD_SSLA(spi->cs_gpiod ? rspi->ctlr->unused_native_cs
+						: spi->chip_select);
 
 	/* CMOS output mode and MOSI signal from previous transfer */
 	rspi->sppcr = 0;
@@ -1123,6 +1125,7 @@ static const struct spi_ops rspi_ops = {
 	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP,
 	.flags =		SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,
+	.num_hw_ss =		2,
 };
 
 static const struct spi_ops rspi_rz_ops = {
@@ -1131,6 +1134,7 @@ static const struct spi_ops rspi_rz_ops = {
 	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,	/* 8 for TX, 32 for RX */
+	.num_hw_ss =		1,
 };
 
 static const struct spi_ops qspi_ops = {
@@ -1141,6 +1145,7 @@ static const struct spi_ops qspi_ops = {
 				SPI_RX_DUAL | SPI_RX_QUAD,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		32,
+	.num_hw_ss =		1,
 };
 
 #ifdef CONFIG_OF
@@ -1256,6 +1261,8 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = ops->mode_bits;
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->use_gpio_descriptors = true;
+	ctlr->max_native_cs = rspi->ops->num_hw_ss;
 
 	ret = platform_get_irq_byname_optional(pdev, "rx");
 	if (ret < 0) {
-- 
2.17.1
