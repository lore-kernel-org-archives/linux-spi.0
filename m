From: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH 1/1] generic spidev devices must be registered
Date: Fri,  5 Aug 2016 15:11:53 +0200
Message-ID: <1470402714-10798-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Cc: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:OPEN FIRMWARE AND FLATTENED
	DEVICE TREE BINDINGS), linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
To: unlisted-recipients:; (no To-header on input)
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Adding spidev in the compatible list, let configure spidev from device tree
instead of C source code.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spidev.txt | 16 ++++++++++++++++
 drivers/spi/spidev.c                             |  1 +
 2 files changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spidev.txt

diff --git a/Documentation/devicetree/bindings/spi/spidev.txt b/Documentation/devicetree/bindings/spi/spidev.txt
new file mode 100644
index 0000000..23200f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spidev.txt
@@ -0,0 +1,16 @@
+* SPIDEV
+
+spidev is a device driver to access to SPI devices using normal userspace I/O calls.
+To make an SPI device compatible with this drivers add:
+
+Required properties:
+- compatible : should be "spidev".
+
+Example:
+
+spidev0: spi@0 {
+	compatible = "spidev";
+	reg = <0>;
+	spi-max-frequency = <1000000>;
+	status = "okay";
+};
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2e05046..d780491 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -696,6 +696,7 @@ static struct class *spidev_class;
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
 	{ .compatible = "lineartechnology,ltc2488" },
+	{ .compatible = "spidev" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
