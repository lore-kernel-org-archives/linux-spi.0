From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/pl022: Unprepare clocks while suspended
Date: Wed, 22 Jan 2014 18:42:34 +0000
Message-ID: <1390416154-3292-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

When the driver was converted to clk_prepare() the suspend path didn't
have any changes made so the clock remains prepared throughout the runtime
of the driver. Unprepare it when suspended so that any savings that can be
made as a result are made.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 2789b452e711..4ec49eae6141 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2296,7 +2296,7 @@ pl022_remove(struct amba_device *adev)
  */
 static void pl022_suspend_resources(struct pl022 *pl022, bool runtime)
 {
-	clk_disable(pl022->clk);
+	clk_disable_unprepare(pl022->clk);
 
 	if (runtime)
 		pinctrl_pm_select_idle_state(&pl022->adev->dev);
@@ -2312,7 +2312,7 @@ static void pl022_resume_resources(struct pl022 *pl022, bool runtime)
 		/* Then let's idle the pins until the next transfer happens */
 		pinctrl_pm_select_idle_state(&pl022->adev->dev);
 
-	clk_enable(pl022->clk);
+	clk_prepare_enable(pl022->clk);
 }
 #endif
 
-- 
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
