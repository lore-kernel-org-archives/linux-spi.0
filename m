From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH v2] spi/pl022: get/put resources on suspend/resume
Date: Wed, 26 Sep 2012 18:06:22 +0200
Message-ID: <1348675582-11538-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
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

This factors out the resource handling in runtime
suspend/resume and also calls it from the ordinary suspend
and resume hooks.

The semantics require that ordinary PM op suspend is called
with runtime PM in resumed mode, so that ordinary suspend
can assume that it will e.g. decrease the clock reference
counter to 0, runtime resume having previously increased it
to 1.

Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
ChangeLog v1->v2:
- Add more #ifdef for the case where we have neither normal
  PM nor runtime PM.
---
 drivers/spi/spi-pl022.c | 66 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 15737bc..9194641 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2300,6 +2300,45 @@ pl022_remove(struct amba_device *adev)
 	return 0;
 }
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_PM_RUNTIME)
+/*
+ * These two functions are used from both suspend/resume and
+ * the runtime counterparts to handle external resources like
+ * clocks, pins and regulators when going to sleep.
+ */
+static void pl022_suspend_resources(struct pl022 *pl022)
+{
+	int ret;
+
+	clk_disable(pl022->clk);
+
+	/* Optionally let pins go into sleep states */
+	if (!IS_ERR(pl022->pins_sleep)) {
+		ret = pinctrl_select_state(pl022->pinctrl,
+					   pl022->pins_sleep);
+		if (ret)
+			dev_err(&pl022->adev->dev,
+				"could not set pins to sleep state\n");
+	}
+}
+
+static void pl022_resume_resources(struct pl022 *pl022)
+{
+	int ret;
+
+	/* Optionaly enable pins to be muxed in and configured */
+	if (!IS_ERR(pl022->pins_default)) {
+		ret = pinctrl_select_state(pl022->pinctrl,
+					   pl022->pins_default);
+		if (ret)
+			dev_err(&pl022->adev->dev,
+				"could not set default pins\n");
+	}
+
+	clk_enable(pl022->clk);
+}
+#endif
+
 #ifdef CONFIG_SUSPEND
 static int pl022_suspend(struct device *dev)
 {
@@ -2311,6 +2350,7 @@ static int pl022_suspend(struct device *dev)
 		dev_warn(dev, "cannot suspend master\n");
 		return ret;
 	}
+	pl022_suspend_resources(pl022);
 
 	dev_dbg(dev, "suspended\n");
 	return 0;
@@ -2321,6 +2361,8 @@ static int pl022_resume(struct device *dev)
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 	int ret;
 
+	pl022_resume_resources(pl022);
+
 	/* Start the queue running */
 	ret = spi_master_resume(pl022->master);
 	if (ret)
@@ -2336,36 +2378,16 @@ static int pl022_resume(struct device *dev)
 static int pl022_runtime_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
-	int status = 0;
-
-	clk_disable(pl022->clk);
-
-	/* Optionally let pins go into sleep states */
-	if (!IS_ERR(pl022->pins_sleep)) {
-		status = pinctrl_select_state(pl022->pinctrl,
-				pl022->pins_sleep);
-		if (status)
-			dev_err(dev, "could not set pins to sleep state\n");
-	}
 
+	pl022_suspend_resources(pl022);
 	return 0;
 }
 
 static int pl022_runtime_resume(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
-	int status = 0;
-
-	/* Optionaly enable pins to be muxed in and configured */
-	if (!IS_ERR(pl022->pins_default)) {
-		status = pinctrl_select_state(pl022->pinctrl,
-				pl022->pins_default);
-		if (status)
-			dev_err(dev, "could not set default pins\n");
-	}
-
-	clk_enable(pl022->clk);
 
+	pl022_resume_resources(pl022);
 	return 0;
 }
 #endif
-- 
1.7.11.3


------------------------------------------------------------------------------
How fast is your code?
3 out of 4 devs don\\\'t know how their code performs in production.
Find out how slow your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219672;13503038;z?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
