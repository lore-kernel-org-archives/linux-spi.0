From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCH 1/2] spi: dw: Initialize of_node to discover DT node children
Date: Tue, 7 Oct 2014 14:48:16 -0500
Message-ID: <1412711297-31857-2-git-send-email-tthayer@opensource.altera.com>
References: <1412711297-31857-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	<tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <jkosina-AlSwsSmVLrQ@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412711297-31857-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

1. The of_node element must be initialized to enable discovery of node
children. The discovery takes place in the of_register_spi_devices() function.
2. Grabbing the bus-num from the device tree.
3. Update the SOCFPGA configuration.

Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
---
 arch/arm/configs/socfpga_defconfig |    1 +
 drivers/spi/spi-dw-mmio.c          |    5 ++++-
 drivers/spi/spi-dw.c               |    3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index d7a5855..54f3540 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -52,6 +52,7 @@ CONFIG_CAN_C_CAN_PLATFORM=y
 CONFIG_CAN_DEBUG_DEVICES=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 21ce0e3..b8483057 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -82,7 +82,10 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	dws->num_cs = num_cs;
 
 	if (pdev->dev.of_node) {
-		int i;
+		int i, prop;
+
+		if (!of_property_read_u32(pdev->dev.of_node, "bus-num", &prop))
+			dws->bus_num = prop;
 
 		for (i = 0; i < dws->num_cs; i++) {
 			int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 0dd0623..d8be9f9 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -671,6 +671,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->cleanup = dw_spi_cleanup;
 	master->transfer_one_message = dw_spi_transfer_one_message;
 	master->max_speed_hz = dws->max_freq;
+#if defined(CONFIG_OF)
+	master->dev.of_node = dev->of_node;
+#endif
 
 	/* Basic HW init */
 	spi_hw_init(dws);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
