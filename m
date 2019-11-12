From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] spi: wire up wakeup-source/wakeirq handling
Date: Mon, 11 Nov 2019 21:54:11 -0800
Message-ID: <20191112055412.192675-3-dmitry.torokhov@gmail.com>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Many SPI drivers need to configure their devices for waking up the
system. Instead of forcing them to reimplement wakeup handling, let's
mirror what I2C core is doing and handle "wakeup-source" device property
in SPI core.

Also, let's allow naming device's interrupt lines as "irq" and "wakeup"
and automatically configure the right one as wakeirq when device is
supposed to be a wakeup source.

Implementing this is very helpful for drivers that use both I2C and SPI
for transport, such as tsc2004/tsc2005.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

 drivers/spi/spi.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 50769a8475d66..baa7aac300d9f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -22,6 +22,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/property.h>
 #include <linux/export.h>
 #include <linux/sched/rt.h>
@@ -394,13 +395,37 @@ static int spi_drv_probe(struct device *dev)
 		return ret;
 
 	if (dev->of_node) {
-		spi->irq = of_irq_get(dev->of_node, 0);
+		spi->irq = of_irq_get_byname(dev->of_node, "irq");
+		if (spi->irq == -EINVAL || spi->irq == -ENODATA)
+			spi->irq = of_irq_get(dev->of_node, 0);
 		if (spi->irq == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		if (spi->irq < 0)
 			spi->irq = 0;
 	}
 
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		int wakeirq = -ENOENT;
+
+		if (dev->of_node) {
+			wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
+			if (wakeirq == -EPROBE_DEFER)
+				return wakeirq;
+		}
+
+		device_init_wakeup(dev, true);
+
+		if (wakeirq > 0 && wakeirq != spi->irq)
+			ret = dev_pm_set_dedicated_wake_irq(dev, wakeirq);
+		else if (spi->irq > 0)
+			ret = dev_pm_set_wake_irq(dev, spi->irq);
+		else
+			ret = 0;
+
+		if (ret)
+			dev_warn(dev, "failed to set up wakeup irq: %d\n", ret);
+	}
+
 	ret = dev_pm_domain_attach(dev, true);
 	if (ret)
 		return ret;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
