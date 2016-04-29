From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pic32: Fix checking return value of devm_ioremap_resource" to the spi tree
Date: Fri, 29 Apr 2016 12:34:39 +0100
Message-ID: <E1aw6gx-0004C3-5D@debutante>
References: <1461745166.12751.0.camel@ingics.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461745166.12751.0.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pic32: Fix checking return value of devm_ioremap_resource

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

>From 866e48b0994c6338e6aa4ae7c413b5888ab432d1 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Wed, 27 Apr 2016 16:19:26 +0800
Subject: [PATCH] spi: pic32: Fix checking return value of
 devm_ioremap_resource

devm_ioremap_resource() returns ERR_PTR on error.
Also remove the redundant dev_err message, the implementation of
devm_ioremap_resource() already print error messages on error paths.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pic32.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 4eeb8a85b030..73db87f805a1 100644
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
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
