From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-(e)spi: Fix checking return value of devm_ioremap_resource" to the spi tree
Date: Sun, 30 Aug 2015 12:27:07 +0100
Message-ID: <E1ZW0lP-0008Qf-6b@finisterre>
References: <1440930951.24276.1.camel@ingics.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440930951.24276.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-(e)spi: Fix checking return value of devm_ioremap_resource

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

>From 37c5db7938093cada165146ee99bd57c97baf6a3 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Sun, 30 Aug 2015 18:35:51 +0800
Subject: [PATCH] spi: fsl-(e)spi: Fix checking return value of
 devm_ioremap_resource

devm_ioremap_resource() returns ERR_PTR on error.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 4 ++--
 drivers/spi/spi-fsl-spi.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index db82c87..c27124a 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -674,8 +674,8 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
 	mpc8xxx_spi->reg_base = devm_ioremap_resource(dev, mem);
-	if (!mpc8xxx_spi->reg_base) {
-		ret = -ENOMEM;
+	if (IS_ERR(mpc8xxx_spi->reg_base)) {
+		ret = PTR_ERR(mpc8xxx_spi->reg_base);
 		goto err_probe;
 	}
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 17a9a87..8b290d9 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -633,8 +633,8 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 		goto err_cpm_init;
 
 	mpc8xxx_spi->reg_base = devm_ioremap_resource(dev, mem);
-	if (mpc8xxx_spi->reg_base == NULL) {
-		ret = -ENOMEM;
+	if (IS_ERR(mpc8xxx_spi->reg_base)) {
+		ret = PTR_ERR(mpc8xxx_spi->reg_base);
 		goto err_probe;
 	}
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
