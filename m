From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/2] spi: rspi: Factor out handling of common mode bits
Date: Tue, 18 Feb 2020 11:58:08 +0100
Message-ID: <20200218105810.902-2-geert+renesas@glider.be>
References: <20200218105810.902-1-geert+renesas@glider.be>
Cc: Hoan Nguyen An <na-hoan-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200218105810.902-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Basic SPI features like clock phase/polarity and loopback mode are
common to all RSPI variants.  Factor them out to reduce duplication.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 85575d45901cee1b..7a1e6d524f34a416 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -239,7 +239,7 @@ struct spi_ops {
 	int (*set_config_register)(struct rspi_data *rspi, int access_size);
 	int (*transfer_one)(struct spi_controller *ctlr,
 			    struct spi_device *spi, struct spi_transfer *xfer);
-	u16 mode_bits;
+	u16 extra_mode_bits;
 	u16 flags;
 	u16 fifo_size;
 	u8 num_hw_ss;
@@ -1122,7 +1122,6 @@ static int rspi_remove(struct platform_device *pdev)
 static const struct spi_ops rspi_ops = {
 	.set_config_register =	rspi_set_config_register,
 	.transfer_one =		rspi_transfer_one,
-	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP,
 	.flags =		SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,
 	.num_hw_ss =		2,
@@ -1131,7 +1130,6 @@ static const struct spi_ops rspi_ops = {
 static const struct spi_ops rspi_rz_ops = {
 	.set_config_register =	rspi_rz_set_config_register,
 	.transfer_one =		rspi_rz_transfer_one,
-	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,	/* 8 for TX, 32 for RX */
 	.num_hw_ss =		1,
@@ -1140,8 +1138,7 @@ static const struct spi_ops rspi_rz_ops = {
 static const struct spi_ops qspi_ops = {
 	.set_config_register =	qspi_set_config_register,
 	.transfer_one =		qspi_transfer_one,
-	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP |
-				SPI_TX_DUAL | SPI_TX_QUAD |
+	.extra_mode_bits =	SPI_TX_DUAL | SPI_TX_QUAD |
 				SPI_RX_DUAL | SPI_RX_QUAD,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		32,
@@ -1258,7 +1255,7 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one = ops->transfer_one;
 	ctlr->prepare_message = rspi_prepare_message;
 	ctlr->unprepare_message = rspi_unprepare_message;
-	ctlr->mode_bits = ops->mode_bits;
+	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LOOP | ops->extra_mode_bits;
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->use_gpio_descriptors = true;
-- 
2.17.1
