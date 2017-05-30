From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH] spi: atmel: print version only after successful registration
Date: Tue, 30 May 2017 08:33:30 +0300
Message-ID: <0ddb655ce326344aa32334e343ed4f0ba2996f72.1496122410.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Don't print the version at the beginning of atmel_spi_probe(). This avoids
spamming the log whenever a deferred probe runs.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 1eb83c9613d5..4e5e51fe6f73 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1422,7 +1422,6 @@ static void atmel_get_caps(struct atmel_spi *as)
 	unsigned int version;
 
 	version = atmel_get_version(as);
-	dev_info(&as->pdev->dev, "version: 0x%x\n", version);
 
 	as->caps.is_spi2 = version > 0x121;
 	as->caps.has_wdrbt = version >= 0x210;
@@ -1609,8 +1608,9 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		goto out_free_dma;
 
 	/* go! */
-	dev_info(&pdev->dev, "Atmel SPI Controller at 0x%08lx (irq %d)\n",
-			(unsigned long)regs->start, irq);
+	dev_info(&pdev->dev, "Atmel SPI Controller version 0x%x at 0x%08lx (irq %d)\n",
+			atmel_get_version(as), (unsigned long)regs->start,
+			irq);
 
 	return 0;
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
