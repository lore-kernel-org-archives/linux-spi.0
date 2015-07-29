From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH] spi: Fix regression in spi-bitbang-txrx.h
Date: Wed, 29 Jul 2015 09:32:02 +0200
Message-ID: <1438155122-2923-1-git-send-email-larper@axis.com>
Cc: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch fixes a regression introduced by commit 232a5adc5199 ("spi:
bitbang: only toggle bitchanges"). The attempt to optimize writes of
consecutive bit patterns broke most of the combinations of word size
and SPI modes due to selecting the wrong bit as the MSB value.

Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
---
 drivers/spi/spi-bitbang-txrx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index 06b34e5..47bb9b89 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -49,7 +49,7 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
 
-	bool oldbit = !(word & 1);
+	u32 oldbit = (!(word & (1<<(bits-1)))) << 31;
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
@@ -81,7 +81,7 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
 
-	bool oldbit = !(word & (1 << 31));
+	u32 oldbit = (!(word & (1<<(bits-1)))) << 31;
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
