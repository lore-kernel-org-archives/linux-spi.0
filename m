From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: atmel: print version only after successful registration" to the spi tree
Date: Tue, 06 Jun 2017 20:07:08 +0100
Message-ID: <E1dIJoq-0007We-Sx@debutante>
References: <0ddb655ce326344aa32334e343ed4f0ba2996f72.1496122410.git.baruch@tkos.co.il>
Cc: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0ddb655ce326344aa32334e343ed4f0ba2996f72.1496122410.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: atmel: print version only after successful registration

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6aba9c65649e5ef137bce7a958c0749f13af88a1 Mon Sep 17 00:00:00 2001
From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Date: Tue, 30 May 2017 08:33:30 +0300
Subject: [PATCH] spi: atmel: print version only after successful registration

Don't print the version at the beginning of atmel_spi_probe(). This avoids
spamming the log whenever a deferred probe runs.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
