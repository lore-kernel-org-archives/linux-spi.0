From: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 2/2] ARM: ABMA: Disable/Enable interface clock from
	suspend/resume
Date: Wed, 26 Sep 2012 16:54:07 +0530
Message-ID: <1348658647-25975-3-git-send-email-vipulkumar.samar@st.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348658647-25975-1-git-send-email-vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

AMBA devices interface clock is disabled in RTPM suspend/resume hooks
but not in conventional hooks.

This patch adds support to disable/enable clock for conventional
suspend/resume calls.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
---
 drivers/amba/bus.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index b7e7285..ded3d98 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -120,6 +120,7 @@ static int amba_legacy_resume(struct device *dev)
 static int amba_pm_suspend(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	struct amba_device *pcdev = to_amba_device(dev);
 	int ret = 0;
 
 	if (!drv)
@@ -132,16 +133,27 @@ static int amba_pm_suspend(struct device *dev)
 		ret = amba_legacy_suspend(dev, PMSG_SUSPEND);
 	}
 
+	if (!ret)
+		clk_disable(pcdev->pclk);
+
 	return ret;
 }
 
 static int amba_pm_resume(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	struct amba_device *pcdev = to_amba_device(dev);
 	int ret = 0;
 
-	if (!drv)
+	if (!drv) {
 		return 0;
+	} else {
+		ret = clk_enable(pcdev->pclk);
+		if (ret) {
+			dev_err(dev, "Resume: Clk enable failed");
+			return ret;
+		}
+	}
 
 	if (drv->pm) {
 		if (drv->pm->resume)
@@ -165,6 +177,7 @@ static int amba_pm_resume(struct device *dev)
 static int amba_pm_freeze(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	struct amba_device *pcdev = to_amba_device(dev);
 	int ret = 0;
 
 	if (!drv)
@@ -177,16 +190,27 @@ static int amba_pm_freeze(struct device *dev)
 		ret = amba_legacy_suspend(dev, PMSG_FREEZE);
 	}
 
+	if (!ret)
+		clk_disable(pcdev->pclk);
+
 	return ret;
 }
 
 static int amba_pm_thaw(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	struct amba_device *pcdev = to_amba_device(dev);
 	int ret = 0;
 
-	if (!drv)
+	if (!drv) {
 		return 0;
+	} else {
+		ret = clk_enable(pcdev->pclk);
+		if (ret) {
+			dev_err(dev, "Thaw: Clk enable failed");
+			return ret;
+		}
+	}
 
 	if (drv->pm) {
 		if (drv->pm->thaw)
@@ -201,6 +225,7 @@ static int amba_pm_thaw(struct device *dev)
 static int amba_pm_poweroff(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	struct amba_device *pcdev = to_amba_device(dev);
 	int ret = 0;
 
 	if (!drv)
@@ -213,16 +238,27 @@ static int amba_pm_poweroff(struct device *dev)
 		ret = amba_legacy_suspend(dev, PMSG_HIBERNATE);
 	}
 
+	if (!ret)
+		clk_disable(pcdev->pclk);
+
 	return ret;
 }
 
 static int amba_pm_restore(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	struct amba_device *pcdev = to_amba_device(dev);
 	int ret = 0;
 
-	if (!drv)
+	if (!drv) {
 		return 0;
+	} else {
+		ret = clk_enable(pcdev->pclk);
+		if (ret) {
+			dev_err(dev, "Restore: Clk enable failed");
+			return ret;
+		}
+	}
 
 	if (drv->pm) {
 		if (drv->pm->restore)
-- 
1.7.10


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
