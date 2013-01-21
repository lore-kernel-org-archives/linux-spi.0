From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 25/33] spi: Convert to devm_ioremap_resource()
Date: Mon, 21 Jan 2013 11:09:18 +0100
Message-ID: <1358762966-20791-26-git-send-email-thierry.reding@avionic-design.de>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general@lists.sourceforge.net
---
 drivers/spi/spi-ep93xx.c         | 7 +++----
 drivers/spi/spi-mxs.c            | 6 +++---
 drivers/spi/spi-omap2-mcspi.c    | 7 +++----
 drivers/spi/spi-s3c64xx.c        | 7 +++----
 drivers/spi/spi-sirf.c           | 7 +++----
 drivers/spi/spi-tegra20-sflash.c | 8 +++-----
 drivers/spi/spi-tegra20-slink.c  | 8 +++-----
 7 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index acb1e19..2e31f32 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -1085,10 +1085,9 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 	espi->sspdr_phys = res->start + SSPDR;
 
-	espi->regs_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!espi->regs_base) {
-		dev_err(&pdev->dev, "failed to map resources\n");
-		error = -ENODEV;
+	espi->regs_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(espi->regs_base)) {
+		error = PTR_ERR(espi->regs_base);
 		goto fail_put_clock;
 	}
 
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index a3ede24..b735988 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -538,9 +538,9 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (!iores || irq_err < 0 || irq_dma < 0)
 		return -EINVAL;
 
-	base = devm_request_and_ioremap(&pdev->dev, iores);
-	if (!base)
-		return -EADDRNOTAVAIL;
+	base = devm_ioremap_resource(&pdev->dev, iores);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl))
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index b610f52..71a9482 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1204,10 +1204,9 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	r->end += regs_offset;
 	mcspi->phys = r->start;
 
-	mcspi->base = devm_request_and_ioremap(&pdev->dev, r);
-	if (!mcspi->base) {
-		dev_dbg(&pdev->dev, "can't ioremap MCSPI\n");
-		status = -ENOMEM;
+	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(mcspi->base)) {
+		status = PTR_ERR(mcspi->base);
 		goto free_master;
 	}
 
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ad93231..3d4a7c4 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1276,10 +1276,9 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
-	sdd->regs = devm_request_and_ioremap(&pdev->dev, mem_res);
-	if (sdd->regs == NULL) {
-		dev_err(&pdev->dev, "Unable to remap IO\n");
-		ret = -ENXIO;
+	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
+	if (IS_ERR(sdd->regs)) {
+		ret = PTR_ERR(sdd->regs);
 		goto err1;
 	}
 
diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index e0f43a5..78c8842 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -535,10 +535,9 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 		}
 	}
 
-	sspi->base = devm_request_and_ioremap(&pdev->dev, mem_res);
-	if (!sspi->base) {
-		dev_err(&pdev->dev, "IO remap failed!\n");
-		ret = -ENOMEM;
+	sspi->base = devm_ioremap_resource(&pdev->dev, mem_res);
+	if (IS_ERR(sspi->base)) {
+		ret = PTR_ERR(sspi->base);
 		goto free_master;
 	}
 
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 448a8cc..69c9d23 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -508,11 +508,9 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto exit_free_master;
 	}
-	tsd->base = devm_request_and_ioremap(&pdev->dev, r);
-	if (!tsd->base) {
-		dev_err(&pdev->dev,
-			"Cannot request memregion/iomap dma address\n");
-		ret = -EADDRNOTAVAIL;
+	tsd->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(tsd->base)) {
+		ret = PTR_ERR(tsd->base);
 		goto exit_free_master;
 	}
 
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 651167f..96bd6c2 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1172,11 +1172,9 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 	tspi->phys = r->start;
-	tspi->base = devm_request_and_ioremap(&pdev->dev, r);
-	if (!tspi->base) {
-		dev_err(&pdev->dev,
-			"Cannot request memregion/iomap dma address\n");
-		ret = -EADDRNOTAVAIL;
+	tspi->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(tspi->base)) {
+		ret = PTR_ERR(tspi->base);
 		goto exit_free_master;
 	}
 
-- 
1.8.1.1
