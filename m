From: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2] spi: bitbang: only toggle bitchanges
Date: Tue, 31 Mar 2015 16:35:01 +0200
Message-ID: <1427812501-7194-1-git-send-email-m.grzeschik@pengutronix.de>
References: <20150331141321.GR2869@sirena.org.uk>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150331141321.GR2869-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The current implementation of bitbang_txrx_be_cpha0 and
bitbang_txrx_be_cpha1 always call setmosi. That runs into several
unnecessary calls into the gpiolib when the level of the GPIO actually
has not to be changed.

This patch changes the routines to remember the last GPIO level
and only calls setmosi if an change has to be made. This
way it improves the transfer throughput.

Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
v2: added missing braces

 drivers/spi/spi-bitbang-txrx.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index c616e41..06b34e5 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -49,12 +49,17 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
 
+	bool oldbit = !(word & 1);
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on trailing edge */
-		if ((flags & SPI_MASTER_NO_TX) == 0)
-			setmosi(spi, word & (1 << 31));
+		if ((flags & SPI_MASTER_NO_TX) == 0) {
+			if ((word & (1 << 31)) != oldbit) {
+				setmosi(spi, word & (1 << 31));
+				oldbit = word & (1 << 31);
+			}
+		}
 		spidelay(nsecs);	/* T(setup) */
 
 		setsck(spi, !cpol);
@@ -76,13 +81,18 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
 
+	bool oldbit = !(word & (1 << 31));
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on leading edge */
 		setsck(spi, !cpol);
-		if ((flags & SPI_MASTER_NO_TX) == 0)
-			setmosi(spi, word & (1 << 31));
+		if ((flags & SPI_MASTER_NO_TX) == 0) {
+			if ((word & (1 << 31)) != oldbit) {
+				setmosi(spi, word & (1 << 31));
+				oldbit = word & (1 << 31);
+			}
+		}
 		spidelay(nsecs); /* T(setup) */
 
 		setsck(spi, cpol);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
