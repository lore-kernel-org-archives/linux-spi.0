From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Convert to using %pOF instead of full_name" to the spi tree
Date: Wed, 19 Jul 2017 12:27:44 +0100
Message-ID: <E1dXn8q-0002lu-M1@debutante>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Convert to using %pOF instead of full_name

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

>From 25c56c88a4627e7fdbfa12a4c20c75e2ccb366d1 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Tue, 18 Jul 2017 16:43:31 -0500
Subject: [PATCH] spi: Convert to using %pOF instead of full_name

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-orion.c |  4 ++--
 drivers/spi/spi.c       | 27 +++++++++++----------------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 28fc9f161b9d..4b6dd73b80da 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -669,8 +669,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 		status = of_property_read_u32(np, "reg", &cs);
 		if (status) {
 			dev_err(&pdev->dev,
-				"%s has no valid 'reg' property (%d)\n",
-				np->full_name, status);
+				"%pOF has no valid 'reg' property (%d)\n",
+				np, status);
 			status = 0;
 			continue;
 		}
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4fcbb0aa71d3..0725c78b0de6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1583,8 +1583,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 
 	if (spi_controller_is_slave(ctlr)) {
 		if (strcmp(nc->name, "slave")) {
-			dev_err(&ctlr->dev, "%s is not called 'slave'\n",
-				nc->full_name);
+			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
+				nc);
 			return -EINVAL;
 		}
 		return 0;
@@ -1593,8 +1593,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device address */
 	rc = of_property_read_u32(nc, "reg", &value);
 	if (rc) {
-		dev_err(&ctlr->dev, "%s has no valid 'reg' property (%d)\n",
-			nc->full_name, rc);
+		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
+			nc, rc);
 		return rc;
 	}
 	spi->chip_select = value;
@@ -1603,8 +1603,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	rc = of_property_read_u32(nc, "spi-max-frequency", &value);
 	if (rc) {
 		dev_err(&ctlr->dev,
-			"%s has no valid 'spi-max-frequency' property (%d)\n",
-			nc->full_name, rc);
+			"%pOF has no valid 'spi-max-frequency' property (%d)\n", nc, rc);
 		return rc;
 	}
 	spi->max_speed_hz = value;
@@ -1621,8 +1620,7 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 	/* Alloc an spi_device */
 	spi = spi_alloc_device(ctlr);
 	if (!spi) {
-		dev_err(&ctlr->dev, "spi_device alloc error for %s\n",
-			nc->full_name);
+		dev_err(&ctlr->dev, "spi_device alloc error for %pOF\n", nc);
 		rc = -ENOMEM;
 		goto err_out;
 	}
@@ -1631,8 +1629,7 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 	rc = of_modalias_node(nc, spi->modalias,
 				sizeof(spi->modalias));
 	if (rc < 0) {
-		dev_err(&ctlr->dev, "cannot find modalias for %s\n",
-			nc->full_name);
+		dev_err(&ctlr->dev, "cannot find modalias for %pOF\n", nc);
 		goto err_out;
 	}
 
@@ -1647,8 +1644,7 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 	/* Register the new device */
 	rc = spi_add_device(spi);
 	if (rc) {
-		dev_err(&ctlr->dev, "spi_device register error %s\n",
-			nc->full_name);
+		dev_err(&ctlr->dev, "spi_device register error %pOF\n", nc);
 		goto err_of_node_put;
 	}
 
@@ -1682,8 +1678,7 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
 		spi = of_register_spi_device(ctlr, nc);
 		if (IS_ERR(spi)) {
 			dev_warn(&ctlr->dev,
-				 "Failed to create SPI device for %s\n",
-				 nc->full_name);
+				 "Failed to create SPI device for %pOF\n", nc);
 			of_node_clear_flag(nc, OF_POPULATED);
 		}
 	}
@@ -3311,8 +3306,8 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		put_device(&ctlr->dev);
 
 		if (IS_ERR(spi)) {
-			pr_err("%s: failed to create for '%s'\n",
-					__func__, rd->dn->full_name);
+			pr_err("%s: failed to create for '%pOF'\n",
+					__func__, rd->dn);
 			of_node_clear_flag(rd->dn, OF_POPULATED);
 			return notifier_from_errno(PTR_ERR(spi));
 		}
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
