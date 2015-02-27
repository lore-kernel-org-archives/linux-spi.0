From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] spi: pl022: Remove dead code
Date: Fri, 27 Feb 2015 16:30:15 +0100
Message-ID: <54F08D87.5060604@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi: pl022: Remove dead code

"flag" variable does nothing, remove it.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0566657..ad78766 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1230,7 +1230,6 @@ static irqreturn_t pl022_interrupt_handler(int irq, void *dev_id)
 	struct pl022 *pl022 = dev_id;
 	struct spi_message *msg = pl022->cur_msg;
 	u16 irq_status = 0;
-	u16 flag = 0;
 
 	if (unlikely(!msg)) {
 		dev_err(&pl022->adev->dev,
@@ -1279,8 +1278,7 @@ static irqreturn_t pl022_interrupt_handler(int irq, void *dev_id)
 
 	readwriter(pl022);
 
-	if ((pl022->tx == pl022->tx_end) && (flag == 0)) {
-		flag = 1;
+	if (pl022->tx == pl022->tx_end) {
 		/* Disable Transmit interrupt, enable receive interrupt */
 		writew((readw(SSP_IMSC(pl022->virtbase)) &
 		       ~SSP_IMSC_MASK_TXIM) | SSP_IMSC_MASK_RXIM,
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
