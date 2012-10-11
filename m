From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] spi/pl022: add IDLE state pin management
Date: Thu, 11 Oct 2012 14:03:51 +0200
Message-ID: <1349957031-23867-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

From: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

This commit allow to put pins in IDLE state in
runtime_suspend and in SLEEP state in suspend, corresponding
to defined semantics in <linux/pinctrl/pinctrl-state.h>.

To do this, just add a boolean parameter runtime
to pl022_resume_resources/pl022_suspend_resources which
indicates if it's called from PM_RUNTIME callbacks or not.

Signed-off-by: Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 51329b2..1361868 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -371,6 +371,7 @@ struct pl022 {
 	/* Two optional pin states - default & sleep */
 	struct pinctrl			*pinctrl;
 	struct pinctrl_state		*pins_default;
+	struct pinctrl_state		*pins_idle;
 	struct pinctrl_state		*pins_sleep;
 	struct spi_master		*master;
 	struct pl022_ssp_controller	*master_info;
@@ -2116,6 +2117,11 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	} else
 		dev_err(dev, "could not get default pinstate\n");
 
+	pl022->pins_idle = pinctrl_lookup_state(pl022->pinctrl,
+					      PINCTRL_STATE_IDLE);
+	if (IS_ERR(pl022->pins_idle))
+		dev_dbg(dev, "could not get idle pinstate\n");
+
 	pl022->pins_sleep = pinctrl_lookup_state(pl022->pinctrl,
 					       PINCTRL_STATE_SLEEP);
 	if (IS_ERR(pl022->pins_sleep))
@@ -2302,35 +2308,47 @@ pl022_remove(struct amba_device *adev)
  * the runtime counterparts to handle external resources like
  * clocks, pins and regulators when going to sleep.
  */
-static void pl022_suspend_resources(struct pl022 *pl022)
+static void pl022_suspend_resources(struct pl022 *pl022, bool runtime)
 {
 	int ret;
+	struct pinctrl_state *pins_state;
 
 	clk_disable(pl022->clk);
 
+	pins_state = runtime ? pl022->pins_idle : pl022->pins_sleep;
 	/* Optionally let pins go into sleep states */
-	if (!IS_ERR(pl022->pins_sleep)) {
-		ret = pinctrl_select_state(pl022->pinctrl,
-					   pl022->pins_sleep);
+	if (!IS_ERR(pins_state)) {
+		ret = pinctrl_select_state(pl022->pinctrl, pins_state);
 		if (ret)
-			dev_err(&pl022->adev->dev,
-				"could not set pins to sleep state\n");
+			dev_err(&pl022->adev->dev, "could not set %s pins\n",
+				runtime ? "idle" : "sleep");
 	}
 }
 
-static void pl022_resume_resources(struct pl022 *pl022)
+static void pl022_resume_resources(struct pl022 *pl022, bool runtime)
 {
 	int ret;
 
 	/* Optionaly enable pins to be muxed in and configured */
+	/* First go to the default state */
 	if (!IS_ERR(pl022->pins_default)) {
-		ret = pinctrl_select_state(pl022->pinctrl,
-					   pl022->pins_default);
+		ret = pinctrl_select_state(pl022->pinctrl, pl022->pins_default);
 		if (ret)
 			dev_err(&pl022->adev->dev,
 				"could not set default pins\n");
 	}
 
+	if (!runtime) {
+		/* Then let's idle the pins until the next transfer happens */
+		if (!IS_ERR(pl022->pins_idle)) {
+			ret = pinctrl_select_state(pl022->pinctrl,
+					pl022->pins_idle);
+		if (ret)
+			dev_err(&pl022->adev->dev,
+				"could not set idle pins\n");
+		}
+	}
+
 	clk_enable(pl022->clk);
 }
 #endif
@@ -2348,7 +2366,7 @@ static int pl022_suspend(struct device *dev)
 	}
 
 	pm_runtime_get_sync(dev);
-	pl022_suspend_resources(pl022);
+	pl022_suspend_resources(pl022, false);
 
 	dev_dbg(dev, "suspended\n");
 	return 0;
@@ -2359,7 +2377,7 @@ static int pl022_resume(struct device *dev)
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 	int ret;
 
-	pl022_resume_resources(pl022);
+	pl022_resume_resources(pl022, false);
 	pm_runtime_put(dev);
 
 	/* Start the queue running */
@@ -2378,7 +2396,7 @@ static int pl022_runtime_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 
-	pl022_suspend_resources(pl022);
+	pl022_suspend_resources(pl022, true);
 	return 0;
 }
 
@@ -2386,7 +2404,7 @@ static int pl022_runtime_resume(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 
-	pl022_resume_resources(pl022);
+	pl022_resume_resources(pl022, true);
 	return 0;
 }
 #endif
-- 
1.7.11.3


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
