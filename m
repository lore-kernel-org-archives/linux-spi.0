From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/10] spi: fsl-espi: remove remaining usage of struct
 fsl_spi_platform_data
Date: Sun, 13 Nov 2016 14:36:39 +0100
Message-ID: <75bd88e0-e1bf-9729-6cd0-e88633d940e6@gmail.com>
References: <882d05f1-a963-c03a-38ae-2dd701f561a6@gmail.com>
 <46d0ab77-d645-1db3-cca4-99b1b04d599c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <46d0ab77-d645-1db3-cca4-99b1b04d599c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use master->num_chipselect directly instead of pdata->max_chipselect.
In this context let of_fsl_espi_get_chipselects return max_chipselect.

This change allows us to get rid of struct fsl_spi_platform_data
completely in the fsl-espi driver.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index e5d7164..29cd4e0 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -573,9 +573,8 @@ static size_t fsl_espi_max_message_size(struct spi_device *spi)
 }
 
 static int fsl_espi_probe(struct device *dev, struct resource *mem,
-			  unsigned int irq)
+			  unsigned int irq, unsigned int num_cs)
 {
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct spi_master *master;
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct device_node *nc;
@@ -597,6 +596,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	master->transfer_one_message = fsl_espi_do_one_msg;
 	master->auto_runtime_pm = true;
 	master->max_message_size = fsl_espi_max_message_size;
+	master->num_chipselect = num_cs;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	spin_lock_init(&mpc8xxx_spi->lock);
@@ -636,7 +636,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	for_each_available_child_of_node(master->dev.of_node, nc) {
 		/* get chip select */
 		ret = of_property_read_u32(nc, "reg", &cs);
-		if (ret || cs >= pdata->max_chipselect)
+		if (ret || cs >= num_cs)
 			continue;
 
 		csmode = CSMODE_INIT_VAL;
@@ -695,19 +695,16 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 static int of_fsl_espi_get_chipselects(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	u32 num_cs;
 	int ret;
 
 	ret = of_property_read_u32(np, "fsl,espi-num-chipselects", &num_cs);
 	if (ret) {
 		dev_err(dev, "No 'fsl,espi-num-chipselects' property\n");
-		return -EINVAL;
+		return 0;
 	}
 
-	pdata->max_chipselect = num_cs;
-
-	return 0;
+	return num_cs;
 }
 
 static int of_fsl_espi_probe(struct platform_device *ofdev)
@@ -715,16 +712,16 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
 	struct resource mem;
-	unsigned int irq;
+	unsigned int irq, num_cs;
 	int ret;
 
 	ret = of_mpc8xxx_spi_probe(ofdev);
 	if (ret)
 		return ret;
 
-	ret = of_fsl_espi_get_chipselects(dev);
-	if (ret)
-		return ret;
+	num_cs = of_fsl_espi_get_chipselects(dev);
+	if (!num_cs)
+		return -EINVAL;
 
 	ret = of_address_to_resource(np, 0, &mem);
 	if (ret)
@@ -734,7 +731,7 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 	if (!irq)
 		return -EINVAL;
 
-	return fsl_espi_probe(dev, &mem, irq);
+	return fsl_espi_probe(dev, &mem, irq, num_cs);
 }
 
 static int of_fsl_espi_remove(struct platform_device *dev)
@@ -765,7 +762,6 @@ static int of_fsl_espi_suspend(struct device *dev)
 
 static int of_fsl_espi_resume(struct device *dev)
 {
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	u32 regval;
@@ -780,7 +776,7 @@ static int of_fsl_espi_resume(struct device *dev)
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIE, 0xffffffff);
 
 	/* Init eSPI CS mode register */
-	for (i = 0; i < pdata->max_chipselect; i++)
+	for (i = 0; i < master->num_chipselect; i++)
 		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(i),
 				      CSMODE_INIT_VAL);
 
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
