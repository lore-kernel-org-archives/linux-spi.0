From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] spi: rspi: Add support for LSB-first word order
Date: Tue, 18 Feb 2020 11:58:09 +0100
Message-ID: <20200218105810.902-3-geert+renesas@glider.be>
References: <20200218105810.902-1-geert+renesas@glider.be>
Cc: Hoan Nguyen An <na-hoan@jinso.co.jp>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200218105810.902-1-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

All RSPI variants support selecting the word order.
Advertize support for LSB-first order, and act upon the flag being set.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7a1e6d524f34a416..aef05f2ac749c21d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -933,6 +933,8 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 		rspi->spcmd |= SPCMD_CPOL;
 	if (spi->mode & SPI_CPHA)
 		rspi->spcmd |= SPCMD_CPHA;
+	if (spi->mode & SPI_LSB_FIRST)
+		rspi->spcmd |= SPCMD_LSBF;
 
 	/* Configure slave signal to assert */
 	rspi->spcmd |= SPCMD_SSLA(spi->cs_gpiod ? rspi->ctlr->unused_native_cs
@@ -1255,7 +1257,8 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one = ops->transfer_one;
 	ctlr->prepare_message = rspi_prepare_message;
 	ctlr->unprepare_message = rspi_unprepare_message;
-	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LOOP | ops->extra_mode_bits;
+	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_LOOP |
+			  ops->extra_mode_bits;
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->use_gpio_descriptors = true;
-- 
2.17.1
