From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH 3/9] spi-orion: remove uneeded spi_info
Date: Sun, 10 Jun 2012 12:31:55 +0200
Message-ID: <1339324322-29388-4-git-send-email-andrew@lunn.ch>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, machael-QKn5cuLxLXY@public.gmane.org,
	Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
To: jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>

This was formerly used to store the tclk value. This is now discovered
using the clk API, rather than pass it as platform data.

Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Acked-by: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
---
 drivers/spi/spi-orion.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 547d983..8c3d625 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -39,7 +39,6 @@ struct orion_spi {
 	void __iomem		*base;
 	unsigned int		max_speed;
 	unsigned int		min_speed;
-	struct orion_spi_info	*spi_info;
 	struct clk              *clk;
 };
 
@@ -378,12 +377,9 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct orion_spi *spi;
 	struct resource *r;
-	struct orion_spi_info *spi_info;
 	unsigned long tclk_hz;
 	int status = 0;
 
-	spi_info = pdev->dev.platform_data;
-
 	master = spi_alloc_master(&pdev->dev, sizeof *spi);
 	if (master == NULL) {
 		dev_dbg(&pdev->dev, "master allocation failed\n");
@@ -404,7 +400,6 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 
 	spi = spi_master_get_devdata(master);
 	spi->master = master;
-	spi->spi_info = spi_info;
 
 	spi->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
-- 
1.7.10
