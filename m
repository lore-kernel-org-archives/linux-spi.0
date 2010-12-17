From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: mpc52xx-psc-spi: move probe/remove to proper sections
Date: Fri, 17 Dec 2010 15:44:00 +0100
Message-ID: <1292597040-28223-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Probe/remove should be in __devinit/__devexit. Found by a section-mismatch
warning. Also, copy do_remove() over to remove().

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/mpc52xx_psc_spi.c |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 983fbbf..8a904c1 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -363,7 +363,7 @@ static irqreturn_t mpc52xx_psc_spi_isr(int irq, void *dev_id)
 }
 
 /* bus_num is used only for the case dev->platform_data == NULL */
-static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
+static int __devinit mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 				u32 size, unsigned int irq, s16 bus_num)
 {
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
@@ -450,22 +450,7 @@ free_master:
 	return ret;
 }
 
-static int __exit mpc52xx_psc_spi_do_remove(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
-
-	flush_workqueue(mps->workqueue);
-	destroy_workqueue(mps->workqueue);
-	spi_unregister_master(master);
-	free_irq(mps->irq, mps);
-	if (mps->psc)
-		iounmap(mps->psc);
-
-	return 0;
-}
-
-static int __init mpc52xx_psc_spi_of_probe(struct platform_device *op,
+static int __devinit mpc52xx_psc_spi_of_probe(struct platform_device *op,
 	const struct of_device_id *match)
 {
 	const u32 *regaddr_p;
@@ -495,9 +480,19 @@ static int __init mpc52xx_psc_spi_of_probe(struct platform_device *op,
 				irq_of_parse_and_map(op->dev.of_node, 0), id);
 }
 
-static int __exit mpc52xx_psc_spi_of_remove(struct platform_device *op)
+static int __devexit mpc52xx_psc_spi_of_remove(struct platform_device *op)
 {
-	return mpc52xx_psc_spi_do_remove(&op->dev);
+	struct spi_master *master = dev_get_drvdata(&op->dev);
+	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
+
+	flush_workqueue(mps->workqueue);
+	destroy_workqueue(mps->workqueue);
+	spi_unregister_master(master);
+	free_irq(mps->irq, mps);
+	if (mps->psc)
+		iounmap(mps->psc);
+
+	return 0;
 }
 
 static const struct of_device_id mpc52xx_psc_spi_of_match[] = {
@@ -510,7 +505,7 @@ MODULE_DEVICE_TABLE(of, mpc52xx_psc_spi_of_match);
 
 static struct of_platform_driver mpc52xx_psc_spi_of_driver = {
 	.probe = mpc52xx_psc_spi_of_probe,
-	.remove = __exit_p(mpc52xx_psc_spi_of_remove),
+	.remove = __devexit_p(mpc52xx_psc_spi_of_remove),
 	.driver = {
 		.name = "mpc52xx-psc-spi",
 		.owner = THIS_MODULE,
-- 
1.7.2.3


------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
