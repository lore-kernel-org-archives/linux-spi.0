From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [RESEND PATCH] spi: atmel: Fix DMA-setup for transfers with more than 8 bits per word
Date: Tue, 20 Oct 2015 14:26:47 +0200
Message-ID: <1445344007-18706-1-git-send-email-nicolas.ferre@atmel.com>
References: <1445288084-31805-1-git-send-email-davidm@egauge.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445288084-31805-1-git-send-email-davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: David Mosberger-Tang <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>

The DMA-slave configuration depends on the whether <= 8 or > 8 bits
are transferred per word, so we need to call
atmel_spi_dma_slave_config() with the correct value.

Signed-off-by: David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>
Signed-off-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 1cc1f1e0d17f..0b6e5ecbc752 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -773,7 +773,8 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	*plen = len;
 
-	if (atmel_spi_dma_slave_config(as, &slave_config, 8))
+	if (atmel_spi_dma_slave_config(as, &slave_config,
+				       xfer->bits_per_word))
 		goto err_exit;
 
 	/* Send both scatterlists */
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
