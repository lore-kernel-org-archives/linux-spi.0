From: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 07/10] mpc52xx_psc_spi: remove code associated with !CONFIG_PPC_MERGE
Date: Fri,  1 Aug 2008 11:44:17 -0500
Message-ID: <1217609060-6381-8-git-send-email-galak@kernel.crashing.org>
References: <1217609060-6381-1-git-send-email-galak@kernel.crashing.org>
 <1217609060-6381-2-git-send-email-galak@kernel.crashing.org>
 <1217609060-6381-3-git-send-email-galak@kernel.crashing.org>
 <1217609060-6381-4-git-send-email-galak@kernel.crashing.org>
 <1217609060-6381-5-git-send-email-galak@kernel.crashing.org>
 <1217609060-6381-6-git-send-email-galak@kernel.crashing.org>
 <1217609060-6381-7-git-send-email-galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755487AbYHAQqt@vger.kernel.org>
In-Reply-To: <1217609060-6381-7-git-send-email-galak@kernel.crashing.org>
CC: dbrownell@users.sourceforge.net
CC: spi-devel-general@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Now that arch/ppc is gone we don't need CONFIG_PPC_MERGE anymore
remove the dead code associated with !CONFIG_PPC_MERGE.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/spi/mpc52xx_psc_spi.c |   55 -----------------------------------------
 1 files changed, 0 insertions(+), 55 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 25eda71..c3a9e5c 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -15,13 +15,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
-
-#if defined(CONFIG_PPC_MERGE)
 #include <linux/of_platform.h>
-#else
-#include <linux/platform_device.h>
-#endif
-
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/io.h>
@@ -471,53 +465,6 @@ static int __exit mpc52xx_psc_spi_do_remove(struct device *dev)
 	return 0;
 }
 
-#if !defined(CONFIG_PPC_MERGE)
-static int __init mpc52xx_psc_spi_probe(struct platform_device *dev)
-{
-	switch(dev->id) {
-	case 1:
-	case 2:
-	case 3:
-	case 6:
-		return mpc52xx_psc_spi_do_probe(&dev->dev,
-			MPC52xx_PA(MPC52xx_PSCx_OFFSET(dev->id)),
-			MPC52xx_PSC_SIZE, platform_get_irq(dev, 0), dev->id);
-	default:
-		return -EINVAL;
-	}
-}
-
-static int __exit mpc52xx_psc_spi_remove(struct platform_device *dev)
-{
-	return mpc52xx_psc_spi_do_remove(&dev->dev);
-}
-
-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:mpc52xx-psc-spi");
-
-static struct platform_driver mpc52xx_psc_spi_platform_driver = {
-	.remove = __exit_p(mpc52xx_psc_spi_remove),
-	.driver = {
-		.name = "mpc52xx-psc-spi",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init mpc52xx_psc_spi_init(void)
-{
-	return platform_driver_probe(&mpc52xx_psc_spi_platform_driver,
-			mpc52xx_psc_spi_probe);
-}
-module_init(mpc52xx_psc_spi_init);
-
-static void __exit mpc52xx_psc_spi_exit(void)
-{
-	platform_driver_unregister(&mpc52xx_psc_spi_platform_driver);
-}
-module_exit(mpc52xx_psc_spi_exit);
-
-#else	/* defined(CONFIG_PPC_MERGE) */
-
 static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
 	const struct of_device_id *match)
 {
@@ -586,8 +533,6 @@ static void __exit mpc52xx_psc_spi_exit(void)
 }
 module_exit(mpc52xx_psc_spi_exit);
 
-#endif	/* defined(CONFIG_PPC_MERGE) */
-
 MODULE_AUTHOR("Dragos Carp");
 MODULE_DESCRIPTION("MPC52xx PSC SPI Driver");
 MODULE_LICENSE("GPL");
-- 
1.5.5.1
