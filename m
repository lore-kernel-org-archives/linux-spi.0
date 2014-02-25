From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: atmel: Let spi core handle validating transfer length
Date: Tue, 25 Feb 2014 19:57:19 +0800
Message-ID: <1393329439.6723.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi core will handle validating transfer length since commit 4d94bd21b333
"spi: core: Validate length of the transfers in message".
So remove the same checking in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c3ed7ed..878fe93 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1079,14 +1079,6 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		}
 	}
 
-	if (xfer->bits_per_word > 8) {
-		if (xfer->len % 2) {
-			dev_dbg(&spi->dev,
-			"buffer len should be 16 bits aligned\n");
-			return -EINVAL;
-		}
-	}
-
 	/*
 	 * DMA map early, for performance (empties dcache ASAP) and
 	 * better fault reporting.
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
