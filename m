From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] spi: rockchip: support "sleep" pin configuration
Date: Fri, 16 Dec 2016 16:59:16 -0800
Message-ID: <1481936356-76161-1-git-send-email-briannorris@chromium.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In the pattern of many other devices, support a system-sleep pin
configuration.

Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 7 +++++++
 drivers/spi/spi-rockchip.c                             | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index d2ca153614f9..83da4931d832 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -31,6 +31,10 @@ Optional Properties:
 - rx-sample-delay-ns: nanoseconds to delay after the SCLK edge before sampling
 		Rx data (may need to be fine tuned for high capacitance lines).
 		No delay (0) by default.
+- pinctrl-names: Names for the pin configuration(s); may be "default" or
+		"sleep", where the "sleep" configuration may describe the state
+		the pins should be in during system suspend. See also
+		pinctrl/pinctrl-bindings.txt.
 
 
 Example:
@@ -46,4 +50,7 @@ Example:
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
 		clock-names = "spiclk", "apb_pclk";
+		pinctrl-0 = <&spi1_pins>;
+		pinctrl-1 = <&spi1_sleep>;
+		pinctrl-names = "default", "sleep";
 	};
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0f89c2169c24..acf31f36b898 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -17,6 +17,7 @@
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
@@ -843,6 +844,8 @@ static int rockchip_spi_suspend(struct device *dev)
 		clk_disable_unprepare(rs->apb_pclk);
 	}
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return ret;
 }
 
@@ -852,6 +855,8 @@ static int rockchip_spi_resume(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
+	pinctrl_pm_select_default_state(dev);
+
 	if (!pm_runtime_suspended(dev)) {
 		ret = clk_prepare_enable(rs->apb_pclk);
 		if (ret < 0)
-- 
2.8.0.rc3.226.g39d4020

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
