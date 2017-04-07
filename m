From: Bastian Stender <bst-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: orion: add LSB support
Date: Fri,  7 Apr 2017 15:52:33 +0200
Message-ID: <20170407135233.28028-1-bst@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        Bastian Stender <bst-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The orion spi driver currently only supports the normal (i.e. MSB) mode.
This patch adds LSB first mode.

Also correct the comment about supported SPI modes that was left over by
b15d5d7004e2 ("spi/orion: Add SPI_CHPA and SPI_CPOL support to kirkwood
driver.").

Signed-off-by: Bastian Stender <bst-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-orion.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 6b001c4a5640..be2e87ee8b31 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -39,6 +39,8 @@
 
 #define ORION_SPI_IF_CTRL_REG		0x00
 #define ORION_SPI_IF_CONFIG_REG		0x04
+#define ORION_SPI_IF_RXLSBF		BIT(14)
+#define ORION_SPI_IF_TXLSBF		BIT(13)
 #define ORION_SPI_DATA_OUT_REG		0x08
 #define ORION_SPI_DATA_IN_REG		0x0c
 #define ORION_SPI_INT_CAUSE_REG		0x10
@@ -234,6 +236,11 @@ orion_spi_mode_set(struct spi_device *spi)
 		reg |= ORION_SPI_MODE_CPOL;
 	if (spi->mode & SPI_CPHA)
 		reg |= ORION_SPI_MODE_CPHA;
+	if (spi->mode & SPI_LSB_FIRST)
+		reg |= ORION_SPI_IF_RXLSBF | ORION_SPI_IF_TXLSBF;
+	else
+		reg &= ~(ORION_SPI_IF_RXLSBF | ORION_SPI_IF_TXLSBF);
+
 	writel(reg, spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
 }
 
@@ -591,8 +598,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 			master->bus_num = cell_index;
 	}
 
-	/* we support only mode 0, and no options */
-	master->mode_bits = SPI_CPHA | SPI_CPOL;
+	/* we support all 4 SPI modes and LSB first option */
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
 	master->set_cs = orion_spi_set_cs;
 	master->transfer_one = orion_spi_transfer_one;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
