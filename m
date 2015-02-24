From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/5] spi: dw: move piece of code out of condition
Date: Tue, 24 Feb 2015 13:32:10 +0200
Message-ID: <1424777534-14246-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1424777534-14246-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424777534-14246-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is no sense to keep a member assignment in the internal structure inside
the condition which reprograms HW. It makes code readability better if kept
outside of the condition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 5a97a62..29157f0 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -494,10 +494,11 @@ static void pump_transfers(unsigned long data)
 			dw_writew(dws, DW_SPI_TXFLTR, txint_level);
 
 		spi_enable_chip(dws, 1);
-		if (cs_change)
-			dws->prev_chip = chip;
 	}
 
+	if (cs_change)
+		dws->prev_chip = chip;
+
 	if (dws->dma_mapped)
 		dws->dma_ops->dma_transfer(dws, cs_change);
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
