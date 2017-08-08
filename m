From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: qup: Fix QUP version identify method" to the spi tree
Date: Tue, 08 Aug 2017 12:17:54 +0100
Message-ID: <E1df2WI-0006D3-4Q@finisterre>
References: <1500882445-29008-15-git-send-email-varada@codeaurora.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500882445-29008-15-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: Fix QUP version identify method

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4d023737b2efcaac36e4e6bbfdce3a3b377f3946 Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Date: Fri, 28 Jul 2017 12:23:01 +0530
Subject: [PATCH] spi: qup: Fix QUP version identify method

Use of_device_get_match_data to identify QUP version instead
of of_device_is_compatible.

Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-qup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 4c3c938360f4..1364516e87c2 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -1058,9 +1059,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	else if (!ret)
 		master->can_dma = spi_qup_can_dma;
 
-	/* set v1 flag if device is version 1 */
-	if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
-		controller->qup_v1 = 1;
+	controller->qup_v1 = (int)of_device_get_match_data(dev);
 
 	if (!controller->qup_v1)
 		master->set_cs = spi_qup_set_cs;
@@ -1256,7 +1255,7 @@ static int spi_qup_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id spi_qup_dt_match[] = {
-	{ .compatible = "qcom,spi-qup-v1.1.1", },
+	{ .compatible = "qcom,spi-qup-v1.1.1", .data = (void *)1, },
 	{ .compatible = "qcom,spi-qup-v2.1.1", },
 	{ .compatible = "qcom,spi-qup-v2.2.1", },
 	{ }
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
