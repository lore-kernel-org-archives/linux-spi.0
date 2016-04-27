From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: pic32: Fix checking return value of
 devm_ioremap_resource
Date: Wed, 27 Apr 2016 16:19:26 +0800
Message-ID: <1461745166.12751.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

devm_ioremap_resource() returns ERR_PTR on error.
Also remove the redundant dev_err message, the implementation of
devm_ioremap_resource() already print error messages on error paths.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-pic32.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 4eeb8a8..73db87f 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -711,10 +711,9 @@ static int pic32_spi_hw_probe(struct platform_device *pdev,
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pic32s->regs = devm_ioremap_resource(&pdev->dev, mem);
-	if (!pic32s->regs) {
-		dev_err(&pdev->dev, "ioremap() failed\n");
-		return -ENOMEM;
-	}
+	if (IS_ERR(pic32s->regs))
+		return PTR_ERR(pic32s->regs);
+
 	pic32s->dma_base = mem->start;
 
 	/* get irq resources: err-irq, rx-irq, tx-irq */
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
