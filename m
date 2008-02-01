From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.24-git] spi: remove more dev->power.power_state usage
Date: Fri, 1 Feb 2008 13:03:15 -0800
Message-ID: <200802011303.15859.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759337AbYBAVNK@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Remove some more references to dev->power.power_state.  That field
is overdue for removal, but we can't do that while it's still
referenced in the kernel.  The only reason to update it was to make
the /sys/devices/.../power/state files (now removed) work better.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/spi/pxa2xx_spi.c |   17 -----------------
 drivers/spi/spi_imx.c    |   11 -----------
 2 files changed, 28 deletions(-)

--- at91.orig/drivers/spi/pxa2xx_spi.c	2008-02-01 12:27:39.000000000 -0800
+++ at91/drivers/spi/pxa2xx_spi.c	2008-02-01 12:28:11.000000000 -0800
@@ -1526,17 +1526,6 @@ static void pxa2xx_spi_shutdown(struct p
 }
 
 #ifdef CONFIG_PM
-static int suspend_devices(struct device *dev, void *pm_message)
-{
-	pm_message_t *state = pm_message;
-
-	if (dev->power.power_state.event != state->event) {
-		dev_warn(dev, "pm state does not match request\n");
-		return -1;
-	}
-
-	return 0;
-}
 
 static int pxa2xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
 {
@@ -1544,12 +1533,6 @@ static int pxa2xx_spi_suspend(struct pla
 	struct ssp_device *ssp = drv_data->ssp;
 	int status = 0;
 
-	/* Check all childern for current power state */
-	if (device_for_each_child(&pdev->dev, &state, suspend_devices) != 0) {
-		dev_warn(&pdev->dev, "suspend aborted\n");
-		return -1;
-	}
-
 	status = stop_queue(drv_data);
 	if (status != 0)
 		return status;
--- at91.orig/drivers/spi/spi_imx.c	2008-02-01 12:27:39.000000000 -0800
+++ at91/drivers/spi/spi_imx.c	2008-02-01 12:28:30.000000000 -0800
@@ -1686,17 +1686,6 @@ static void spi_imx_shutdown(struct plat
 }
 
 #ifdef CONFIG_PM
-static int suspend_devices(struct device *dev, void *pm_message)
-{
-	pm_message_t *state = pm_message;
-
-	if (dev->power.power_state.event != state->event) {
-		dev_warn(dev, "pm state does not match request\n");
-		return -1;
-	}
-
-	return 0;
-}
 
 static int spi_imx_suspend(struct platform_device *pdev, pm_message_t state)
 {
