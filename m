From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.28-rc6] spi: fix spi_imx probe
	oopsing
Date: Sat, 22 Nov 2008 11:53:51 -0800
Message-ID: <200811221153.51816.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Julien Boibessot <julien.boibessot-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Julien Boibessot <julien.boibessot-GANU6spQydw@public.gmane.org>

Corrects spi_imx driver oops during initialization/probing:
can't use drv_data before it's allocated.

Signed-off-by: Julien Boibessot <julien.boibessot-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_imx.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -1456,7 +1456,7 @@ static int __init spi_imx_probe(struct p
 	struct device *dev = &pdev->dev;
 	struct spi_imx_master *platform_info;
 	struct spi_master *master;
-	struct driver_data *drv_data = NULL;
+	struct driver_data *drv_data;
 	struct resource *res;
 	int irq, status = 0;
 
@@ -1467,14 +1467,6 @@ static int __init spi_imx_probe(struct p
 		goto err_no_pdata;
 	}
 
-	drv_data->clk = clk_get(&pdev->dev, "perclk2");
-	if (IS_ERR(drv_data->clk)) {
-		dev_err(&pdev->dev, "probe - cannot get get\n");
-		status = PTR_ERR(drv_data->clk);
-		goto err_no_clk;
-	}
-	clk_enable(drv_data->clk);
-
 	/* Allocate master with space for drv_data */
 	master = spi_alloc_master(dev, sizeof(struct driver_data));
 	if (!master) {
@@ -1495,6 +1487,14 @@ static int __init spi_imx_probe(struct p
 
 	drv_data->dummy_dma_buf = SPI_DUMMY_u32;
 
+	drv_data->clk = clk_get(&pdev->dev, "perclk2");
+	if (IS_ERR(drv_data->clk)) {
+		dev_err(&pdev->dev, "probe - cannot get clock\n");
+		status = PTR_ERR(drv_data->clk);
+		goto err_no_clk;
+	}
+	clk_enable(drv_data->clk);
+
 	/* Find and map resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1630,12 +1630,13 @@ err_no_iomap:
 	kfree(drv_data->ioarea);
 
 err_no_iores:
-	spi_master_put(master);
-
-err_no_pdata:
 	clk_disable(drv_data->clk);
 	clk_put(drv_data->clk);
+
 err_no_clk:
+	spi_master_put(master);
+
+err_no_pdata:
 err_no_mem:
 	return status;
 }


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
