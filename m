From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 6/7] spi/pl022: add support for pm_runtime autosuspend
Date: Tue, 22 Nov 2011 09:25:17 +0100
Message-ID: <1321950317-4849-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

From: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Adds support for configuring the spi bus to use autosuspend for
runtime power management. This can reduce the latency in starting an
spi transfer by not suspending the device immediately following
completion of a transfer. If another transfer then takes place before
the autosuspend timeout, the call to resume the device can return
immediately rather than needing to risk sleeping in order to resume
the device.

Reviewed-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
ChangeLog v1->v2:
- Add Viresh's Reviewed-by
---
 drivers/spi/spi-pl022.c    |   20 ++++++++++++++++++--
 include/linux/amba/pl022.h |    4 ++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 82a929f..13988a3 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1516,7 +1516,13 @@ static void pump_messages(struct work_struct *work)
 			/* nothing more to do - disable spi/ssp and power off */
 			writew((readw(SSP_CR1(pl022->virtbase)) &
 				(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
-			pm_runtime_put(&pl022->adev->dev);
+
+			if (pl022->master_info->autosuspend_delay > 0) {
+				pm_runtime_mark_last_busy(&pl022->adev->dev);
+				pm_runtime_put_autosuspend(&pl022->adev->dev);
+			} else {
+				pm_runtime_put(&pl022->adev->dev);
+			}
 		}
 		pl022->busy = false;
 		spin_unlock_irqrestore(&pl022->queue_lock, flags);
@@ -2247,7 +2253,17 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_dbg(dev, "probe succeeded\n");
 
 	/* let runtime pm put suspend */
-	pm_runtime_put(dev);
+	if (platform_info->autosuspend_delay > 0) {
+		dev_info(&adev->dev,
+			"will use autosuspend for runtime pm, delay %dms\n",
+			platform_info->autosuspend_delay);
+		pm_runtime_set_autosuspend_delay(dev,
+			platform_info->autosuspend_delay);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
+	} else {
+		pm_runtime_put(dev);
+	}
 	return 0;
 
  err_spi_register:
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index 4ce98f5..572f637 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -238,6 +238,9 @@ struct dma_chan;
  * @enable_dma: if true enables DMA driven transfers.
  * @dma_rx_param: parameter to locate an RX DMA channel.
  * @dma_tx_param: parameter to locate a TX DMA channel.
+ * @autosuspend_delay: delay in ms following transfer completion before the
+ *     runtime power management system suspends the device. A setting of 0
+ *     indicates no delay and the device will be suspended immediately.
  */
 struct pl022_ssp_controller {
 	u16 bus_id;
@@ -246,6 +249,7 @@ struct pl022_ssp_controller {
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
+	int autosuspend_delay;
 };
 
 /**
-- 
1.7.3.2


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
