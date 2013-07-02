From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH v2 05/11] spi: spi-ep93xx: use devm_clk_get()
Date: Tue, 2 Jul 2013 10:08:21 -0700
Message-ID: <201307021008.22347.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mika.westerberg-X3B1VOXEql0@public.gmane.org,
	hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
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

Use devm_clk_get() so that the clk_put() happens automatically when
the last reference to this driver is dropped.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index c2660c2..c1a610e 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -1021,7 +1021,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 	espi = spi_master_get_devdata(master);
 
-	espi->clk = clk_get(&pdev->dev, NULL);
+	espi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(espi->clk)) {
 		dev_err(&pdev->dev, "unable to get spi clock\n");
 		error = PTR_ERR(espi->clk);
@@ -1044,14 +1044,14 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	espi->regs_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(espi->regs_base)) {
 		error = PTR_ERR(espi->regs_base);
-		goto fail_put_clock;
+		goto fail_release_master;
 	}
 
 	error = devm_request_irq(&pdev->dev, irq, ep93xx_spi_interrupt,
 				0, "ep93xx-spi", espi);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-		goto fail_put_clock;
+		goto fail_release_master;
 	}
 
 	if (info->use_dma && ep93xx_spi_setup_dma(espi))
@@ -1085,8 +1085,6 @@ fail_free_queue:
 	destroy_workqueue(espi->wq);
 fail_free_dma:
 	ep93xx_spi_release_dma(espi);
-fail_put_clock:
-	clk_put(espi->clk);
 fail_release_master:
 	spi_master_put(master);
 
@@ -1122,7 +1120,6 @@ static int ep93xx_spi_remove(struct platform_device *pdev)
 	spin_unlock_irq(&espi->lock);
 
 	ep93xx_spi_release_dma(espi);
-	clk_put(espi->clk);
 
 	spi_unregister_master(master);
 	return 0;
-- 
1.8.1.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
