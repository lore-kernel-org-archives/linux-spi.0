From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: img-spfi: check for max speed supported by the spfi block" to the spi tree
Date: Tue, 07 Jul 2015 14:58:51 +0100
Message-ID: <E1ZCTOd-0005oR-Hx@finisterre>
References: <1434630432-10392-1-git-send-email-sifan.naeem@imgtec.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434630432-10392-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: img-spfi: check for max speed supported by the spfi block

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

>From 93e3a9e9993ef018522b7005d97d8124b7e73385 Mon Sep 17 00:00:00 2001
From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Date: Thu, 18 Jun 2015 13:27:12 +0100
Subject: [PATCH] spi: img-spfi: check for max speed supported by the spfi
 block

Maximum speed supported by spfi is limited to 1/4 of the spfi clock.

But in some SoCs the maximum speed supported by the spfi block can
be limited to less than 1/4 of the spfi clock. In such cases we have
to define the limit in the device tree so that the driver can pick
it up.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-img-spfi.txt |  1 +
 drivers/spi/spi-img-spfi.c                             | 14 ++++++++++++++
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
index 788e2b1..f31d792 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -546,6 +546,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	struct img_spfi *spfi;
 	struct resource *res;
 	int ret;
+	u32 max_speed_hz;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spfi));
 	if (!master)
@@ -610,6 +611,19 @@ static int img_spfi_probe(struct platform_device *pdev)
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
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
