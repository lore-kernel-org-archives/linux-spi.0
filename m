From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH v2 04/11] spi: spi-ep93xx: get platform resources early in (*probe)
Date: Tue, 2 Jul 2013 10:07:53 -0700
Message-ID: <201307021007.53590.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <spi-devel-general@lists.sourceforge.net>,
	Ryan Mallon <rmallon@gmail.com>, <mika.westerberg@iki.fi>,
	<broonie@kernel.org>, <grant.likely@linaro.org>,
	<hsweeten@visionengravers.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Get the platform resources early in the (*probe) to minimize the number
of goto's in the error path.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Mark Brown <broonie@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
---
 drivers/spi/spi-ep93xx.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index d5e6420..c2660c2 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -991,6 +991,18 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 	info = pdev->dev.platform_data;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq resources\n");
+		return -EBUSY;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "unable to get iomem resource\n");
+		return -ENODEV;
+	}
+
 	master = spi_alloc_master(&pdev->dev, sizeof(*espi));
 	if (!master) {
 		dev_err(&pdev->dev, "failed to allocate spi master\n");
@@ -1027,20 +1039,6 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	espi->min_rate = clk_get_rate(espi->clk) / (254 * 256);
 	espi->pdev = pdev;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		error = -EBUSY;
-		dev_err(&pdev->dev, "failed to get irq resources\n");
-		goto fail_put_clock;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "unable to get iomem resource\n");
-		error = -ENODEV;
-		goto fail_put_clock;
-	}
-
 	espi->sspdr_phys = res->start + SSPDR;
 
 	espi->regs_base = devm_ioremap_resource(&pdev->dev, res);
-- 
1.8.1.4
