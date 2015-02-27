From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] spi: pl022: Remove incorrect TxFIFO full reporting
Date: Fri, 27 Feb 2015 16:30:01 +0100
Message-ID: <54F08D79.6060708@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi: pl022: Remove incorrect TxFIFO full reporting

According to PL022 specification, TNF bit states for "Transmit FIFO Not full".
So the logic here is inverted. But "Receive Overrun Interrupt", which is handled
here, is only triggered on Rx errors. So instead of fixing the if statement,
remove the whole message.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 8f67a46..f68cbf6 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1254,9 +1254,6 @@ static irqreturn_t pl022_interrupt_handler(int irq, void *dev_id)
 		if (readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_RFF)
 			dev_err(&pl022->adev->dev,
 				"RXFIFO is full\n");
-		if (readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_TNF)
-			dev_err(&pl022->adev->dev,
-				"TXFIFO is full\n");
 
 		/*
 		 * Disable and clear interrupts, disable SSP,
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
