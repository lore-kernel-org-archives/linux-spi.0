From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: orion: Convert to let spi core validate
 xfer->bits_per_word
Date: Tue, 11 Feb 2014 20:51:36 +0800
Message-ID: <1392123096.1351.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set bits_per_word_mask so spi core will reject transfers that attempt to use
an unsupported bits_per_word value.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-orion.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 95e29b6..2deddb3 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -74,23 +74,6 @@ orion_spi_clrbits(struct orion_spi *orion_spi, u32 reg, u32 mask)
 	writel(val, reg_addr);
 }
 
-static int orion_spi_set_transfer_size(struct orion_spi *orion_spi, int size)
-{
-	if (size == 16) {
-		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
-				  ORION_SPI_IF_8_16_BIT_MODE);
-	} else if (size == 8) {
-		orion_spi_clrbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
-				  ORION_SPI_IF_8_16_BIT_MODE);
-	} else {
-		pr_debug("Bad bits per word value %d (only 8 or 16 are allowed).\n",
-			size);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int speed)
 {
 	u32 tclk_hz;
@@ -169,7 +152,14 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if (rc)
 		return rc;
 
-	return orion_spi_set_transfer_size(orion_spi, bits_per_word);
+	if (bits_per_word == 16)
+		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
+				  ORION_SPI_IF_8_16_BIT_MODE);
+	else
+		orion_spi_clrbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
+				  ORION_SPI_IF_8_16_BIT_MODE);
+
+	return 0;
 }
 
 static void orion_spi_set_cs(struct orion_spi *orion_spi, int enable)
@@ -425,6 +415,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	master->setup = orion_spi_setup;
 	master->transfer_one_message = orion_spi_transfer_one_message;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
+	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 
 	platform_set_drvdata(pdev, master);
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
