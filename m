From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] spi/mpc5121: change annotations for
	probe and remove functions
Date: Mon,  5 Jul 2010 12:17:51 +0200
Message-ID: <1278325071-28809-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
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

Change annotations from __init/__exit to __devinit/__devexit
to get rid of section mismatch warning.

Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/mpc512x_psc_spi.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/mpc512x_psc_spi.c b/drivers/spi/mpc512x_psc_spi.c
index 2534b1e..c8d69fc 100644
--- a/drivers/spi/mpc512x_psc_spi.c
+++ b/drivers/spi/mpc512x_psc_spi.c
@@ -405,9 +405,9 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 }
 
 /* bus_num is used only for the case dev->platform_data == NULL */
-static int __init mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
-					   u32 size, unsigned int irq,
-					   s16 bus_num)
+static int __devinit mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
+					      u32 size, unsigned int irq,
+					      s16 bus_num)
 {
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
 	struct mpc512x_psc_spi *mps;
@@ -490,7 +490,7 @@ free_master:
 	return ret;
 }
 
-static int __exit mpc512x_psc_spi_do_remove(struct device *dev)
+static int __devexit mpc512x_psc_spi_do_remove(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
@@ -505,8 +505,8 @@ static int __exit mpc512x_psc_spi_do_remove(struct device *dev)
 	return 0;
 }
 
-static int __init mpc512x_psc_spi_of_probe(struct of_device *op,
-					   const struct of_device_id *match)
+static int __devinit mpc512x_psc_spi_of_probe(struct of_device *op,
+					      const struct of_device_id *match)
 {
 	const u32 *regaddr_p;
 	u64 regaddr64, size64;
@@ -537,7 +537,7 @@ static int __init mpc512x_psc_spi_of_probe(struct of_device *op,
 				irq_of_parse_and_map(op->dev.of_node, 0), id);
 }
 
-static int __exit mpc512x_psc_spi_of_remove(struct of_device *op)
+static int __devexit mpc512x_psc_spi_of_remove(struct of_device *op)
 {
 	return mpc512x_psc_spi_do_remove(&op->dev);
 }
@@ -551,7 +551,7 @@ MODULE_DEVICE_TABLE(of, mpc512x_psc_spi_of_match);
 
 static struct of_platform_driver mpc512x_psc_spi_of_driver = {
 	.probe = mpc512x_psc_spi_of_probe,
-	.remove = __exit_p(mpc512x_psc_spi_of_remove),
+	.remove = __devexit_p(mpc512x_psc_spi_of_remove),
 	.driver = {
 		.name = "mpc512x-psc-spi",
 		.owner = THIS_MODULE,
-- 
1.7.0.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
