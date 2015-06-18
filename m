From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] spi: img-spfi: check for max speed supported by the spfi block
Date: Thu, 18 Jun 2015 13:27:12 +0100
Message-ID: <1434630432-10392-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Maximum speed supported by spfi is limited to 1/4 of the spfi clock.

But in some SoCs the maximum speed supported by the spfi block can
be limited to less than 1/4 of the spfi clock. In such cases we have
to define the limit in the device tree so that the driver can pick
it up.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 changes from v1: coding style fix.
 .../devicetree/bindings/spi/spi-img-spfi.txt       |    1 +
 drivers/spi/spi-img-spfi.c                         |   14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-img-spfi.txt b/Documentation/devicetree/bindings/spi/spi-img-spfi.txt
index e02fbf1..494db60 100644
--- a/Documentation/devicetree/bindings/spi/spi-img-spfi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-img-spfi.txt
@@ -21,6 +21,7 @@ Required properties:
 Optional properties:
 - img,supports-quad-mode: Should be set if the interface supports quad mode
   SPI transfers.
+- spfi-max-frequency: Maximum speed supported by the spfi block.
 
 Example:
 
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index acce90a..00f1ac3 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -548,6 +548,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	struct img_spfi *spfi;
 	struct resource *res;
 	int ret;
+	u32 max_speed_hz;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spfi));
 	if (!master)
@@ -612,6 +613,19 @@ static int img_spfi_probe(struct platform_device *pdev)
 	master->max_speed_hz = clk_get_rate(spfi->spfi_clk) / 4;
 	master->min_speed_hz = clk_get_rate(spfi->spfi_clk) / 512;
 
+	/*
+	 * Maximum speed supported by spfi is limited to the lower value
+	 * between 1/4 of the SPFI clock or to "spfi-max-frequency"
+	 * defined in the device tree.
+	 * If no value is defined in the device tree assume the maximum
+	 * speed supported to be 1/4 of the SPFI clock.
+	 */
+	if (!of_property_read_u32(spfi->dev->of_node, "spfi-max-frequency",
+				  &max_speed_hz)) {
+		if (master->max_speed_hz > max_speed_hz)
+			master->max_speed_hz = max_speed_hz;
+	}
+
 	master->setup = img_spfi_setup;
 	master->cleanup = img_spfi_cleanup;
 	master->transfer_one = img_spfi_transfer_one;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
