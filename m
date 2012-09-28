From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/2] spi: spidev: Add device tree bindings
Date: Fri, 28 Sep 2012 14:50:15 +0200
Message-ID: <1348836616-29783-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1348836616-29783-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348836616-29783-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This will allow to probe spidev from device tree

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spidev.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 830adbe..8ae0660 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -31,6 +31,8 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spidev.h>
@@ -642,10 +644,18 @@ static int __devexit spidev_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id spidev_dt_ids[] = {
+	{ .compatible = "linux,spidev" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, spidev_dt_ids);
+
 static struct spi_driver spidev_spi_driver = {
 	.driver = {
 		.name =		"spidev",
 		.owner =	THIS_MODULE,
+		.of_match_table = of_match_ptr(spidev_dt_ids),
 	},
 	.probe =	spidev_probe,
 	.remove =	__devexit_p(spidev_remove),
-- 
1.7.9.5


------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
