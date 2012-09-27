From: Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH V2] spi/pl022: Simplify use of runtime pm
Date: Thu, 27 Sep 2012 17:06:36 +0200
Message-ID: <1348758396-25276-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
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

From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

In probe the pm_runtime_resume is not needed since the amba bus
has already set the device in "resumed" state by using
pm_runtime_set_active.

Additionally more simplifications is done in probe by removing
pm_runtime_put_autosuspend. pm_runtime_put_autosuspend does in
probe functions have same effect as doing pm_runtime_put. This
due to upper layer in driver core is preventing the device from
being runtime suspended by a pm_runtime_get*.

Finally, removing pm_runtime_disable from the remove function
can be done since it is already handled by the amba bus.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

V2: Clearification added in commit message

---
 drivers/spi/spi-pl022.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f8568b4..e51a026 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2188,8 +2188,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
 	       adev->res.start, pl022->virtbase);
 
-	pm_runtime_resume(dev);
-
 	pl022->clk = clk_get(&adev->dev, NULL);
 	if (IS_ERR(pl022->clk)) {
 		status = PTR_ERR(pl022->clk);
@@ -2250,10 +2248,9 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		pm_runtime_set_autosuspend_delay(dev,
 			platform_info->autosuspend_delay);
 		pm_runtime_use_autosuspend(dev);
-		pm_runtime_put_autosuspend(dev);
-	} else {
-		pm_runtime_put(dev);
 	}
+	pm_runtime_put(dev);
+
 	return 0;
 
  err_spi_register:
@@ -2302,7 +2299,6 @@ pl022_remove(struct amba_device *adev)
 	clk_disable(pl022->clk);
 	clk_unprepare(pl022->clk);
 	clk_put(pl022->clk);
-	pm_runtime_disable(&adev->dev);
 	iounmap(pl022->virtbase);
 	amba_release_regions(adev);
 	tasklet_disable(&pl022->pump_transfers);
-- 
1.7.10


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://ad.doubleclick.net/clk;258768047;13503038;j?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
