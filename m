From: Heiner Kallweit <heiner.kallweit-S0/GAf8tV78@public.gmane.org>
Subject: [PATCH 3/4] spi: fsl-espi: improve return value handling in
 fsl_espi_probe
Date: Sat, 17 Sep 2016 15:43:31 +0200
Message-ID: <dc06d27a-09ed-7720-d86f-9d20134557af@web.de>
References: <1d67ce99-42ea-c816-da35-e64575cca8ff@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1d67ce99-42ea-c816-da35-e64575cca8ff-S0/GAf8tV78@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The return value of fsl_espi_probe (currently struct spi_master *)
is just used for checking whether an error occurred.
Change the return value type to int and simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index dee3f82..7451585 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -538,8 +538,8 @@ static size_t fsl_espi_max_message_size(struct spi_device *spi)
 	return SPCOM_TRANLEN_MAX;
 }
 
-static struct spi_master * fsl_espi_probe(struct device *dev,
-		struct resource *mem, unsigned int irq)
+static int fsl_espi_probe(struct device *dev, struct resource *mem,
+			  unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct spi_master *master;
@@ -547,13 +547,11 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	struct device_node *nc;
 	const __be32 *prop;
 	u32 regval, csmode;
-	int i, len, ret = 0;
+	int i, len, ret;
 
 	master = spi_alloc_master(dev, sizeof(struct mpc8xxx_spi));
-	if (!master) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!master)
+		return -ENOMEM;
 
 	dev_set_drvdata(dev, master);
 
@@ -647,7 +645,7 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	return master;
+	return 0;
 
 err_pm:
 	pm_runtime_put_noidle(dev);
@@ -655,8 +653,7 @@ err_pm:
 	pm_runtime_set_suspended(dev);
 err_probe:
 	spi_master_put(master);
-err:
-	return ERR_PTR(ret);
+	return ret;
 }
 
 static int of_fsl_espi_get_chipselects(struct device *dev)
@@ -682,7 +679,6 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
-	struct spi_master *master;
 	struct resource mem;
 	unsigned int irq;
 	int ret;
@@ -703,11 +699,7 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 	if (!irq)
 		return -EINVAL;
 
-	master = fsl_espi_probe(dev, &mem, irq);
-	if (IS_ERR(master))
-		return PTR_ERR(master);
-
-	return 0;
+	return fsl_espi_probe(dev, &mem, irq);
 }
 
 static int of_fsl_espi_remove(struct platform_device *dev)
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
