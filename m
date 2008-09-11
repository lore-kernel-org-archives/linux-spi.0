From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.27-rc6+mm] pxa2xx_spi: minor cleanup
Date: Thu, 11 Sep 2008 14:25:33 -0700
Message-ID: <200809111425.34178.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Minor fixes: remove redundant local variable initialization,
fix "can not" to what I _think_ is a preferred spelling,
output IRQ number if requesting it failed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Clearly not essential for 2.6.27 

 drivers/spi/pxa2xx_spi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1407,9 +1407,9 @@ static int __init pxa2xx_spi_probe(struc
 	struct device *dev = &pdev->dev;
 	struct pxa2xx_spi_master *platform_info;
 	struct spi_master *master;
-	struct driver_data *drv_data = NULL;
+	struct driver_data *drv_data;
 	struct ssp_device *ssp;
-	int status = 0;
+	int status;
 
 	platform_info = dev->platform_data;
 
@@ -1422,7 +1422,7 @@ static int __init pxa2xx_spi_probe(struc
 	/* Allocate master with space for drv_data and null dma buffer */
 	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
 	if (!master) {
-		dev_err(&pdev->dev, "can not alloc spi_master\n");
+		dev_err(&pdev->dev, "cannot alloc spi_master\n");
 		ssp_free(ssp);
 		return -ENOMEM;
 	}
@@ -1458,7 +1458,7 @@ static int __init pxa2xx_spi_probe(struc
 
 	status = request_irq(ssp->irq, ssp_int, 0, dev->bus_id, drv_data);
 	if (status < 0) {
-		dev_err(&pdev->dev, "can not get IRQ\n");
+		dev_err(&pdev->dev, "cannot get IRQ %d\n", ssp->irq);
 		goto out_error_master_alloc;
 	}
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
