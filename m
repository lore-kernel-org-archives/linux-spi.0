From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pl022: don't use uninitialized variable" to the spi tree
Date: Thu, 06 Apr 2017 11:58:31 +0100
Message-ID: <E1cw57X-00050x-Id@debutante>
References: <1491466583-6121-1-git-send-email-rabin.vincent@axis.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491466583-6121-1-git-send-email-rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pl022: don't use uninitialized variable

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

>From 849794c50b24b93676b939028c811d6e116ef335 Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>
Date: Thu, 6 Apr 2017 10:16:23 +0200
Subject: [PATCH] spi: pl022: don't use uninitialized variable

The num-cs property is a required property according to the binding
documentation.  However, if it is not present, the driver currently
simply uses random junk from the stack for the num-cs since the variable
whose pointer is passed to of_property_read_u32() is not initialized.

Signed-off-by: Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f7f7ba17b40e..2f76e022cc59 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2074,7 +2074,7 @@ pl022_platform_data_dt_get(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct pl022_ssp_controller *pd;
-	u32 tmp;
+	u32 tmp = 0;
 
 	if (!np) {
 		dev_err(dev, "no dt node defined\n");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
