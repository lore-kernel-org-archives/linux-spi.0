From: David Mosberger-Tang <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>
Subject: [PATCH] spi: atmel: Fix DMA-setup for transfers with more than 8 bits per word.
Date: Mon, 19 Oct 2015 14:54:44 -0600
Message-ID: <1445288084-31805-1-git-send-email-davidm@egauge.net>
Cc: David Mosberger-Tang <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The DMA-slave configuration depends on the whether <= 8 or > 8 bits
are transferred per word, so we need to call
atmel_spi_dma_slave_config() with the correct value.

Signed-off-by: David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 04e48e5..855cc56 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -758,7 +758,8 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	*plen = len;
 
-	if (atmel_spi_dma_slave_config(as, &slave_config, 8))
+	if (atmel_spi_dma_slave_config(as, &slave_config,
+				       xfer->bits_per_word))
 		goto err_exit;
 
 	/* Send both scatterlists */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
