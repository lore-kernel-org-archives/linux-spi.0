From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: fsl-(e)spi: Fix checking return value of
 devm_ioremap_resource
Date: Sun, 30 Aug 2015 18:35:51 +0800
Message-ID: <1440930951.24276.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

devm_ioremap_resource() returns ERR_PTR on error.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
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
1.9.1



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
