From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 2/4] spi/pl022: support runtime PM
Date: Thu, 16 Jun 2011 10:14:40 +0200
Message-ID: <1308212080-22516-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

From: Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Insert notifiers for the runtime PM API. With this the runtime
PM layer kicks in to action where used.

Signed-off-by: Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Jonas Aberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
[Rebased to Linux 3.0-rc3, edit description]
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index ac7c727..48fa8b0 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -40,6 +40,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
+#include <linux/pm_runtime.h>
 
 /*
  * This macro is used to define some register default values.
@@ -517,6 +518,7 @@ static void giveback(struct pl022 *pl022)
 	clk_disable(pl022->clk);
 	amba_pclk_disable(pl022->adev);
 	amba_vcore_disable(pl022->adev);
+	pm_runtime_put(&pl022->adev->dev);
 }
 
 /**
@@ -1542,6 +1544,7 @@ static void pump_messages(struct work_struct *work)
 	 * and core will be disabled when giveback() is called in each method
 	 * (poll/interrupt/DMA)
 	 */
+	pm_runtime_get_sync(&pl022->adev->dev);
 	amba_vcore_enable(pl022->adev);
 	amba_pclk_enable(pl022->adev);
 	clk_enable(pl022->clk);
@@ -2143,6 +2146,8 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
 	       adev->res.start, pl022->virtbase);
+	pm_runtime_enable(dev);
+	pm_runtime_resume(dev);
 
 	pl022->clk = clk_get(&adev->dev, NULL);
 	if (IS_ERR(pl022->clk)) {
@@ -2204,6 +2209,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	destroy_queue(pl022);
 	pl022_dma_remove(pl022);
 	free_irq(adev->irq[0], pl022);
+	pm_runtime_disable(&adev->dev);
  err_no_irq:
 	clk_put(pl022->clk);
  err_no_clk:
-- 
1.7.3.2


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
