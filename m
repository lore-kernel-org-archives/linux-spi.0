From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm2835aux: spi: add bindings for the bcm2835 auxiliary spi devices" to the spi tree
Date: Wed, 07 Oct 2015 11:43:31 +0100
Message-ID: <E1ZjmC3-000562-R0@finisterre>
References: <1441970527-2403-2-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441970527-2403-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm2835aux: spi: add bindings for the bcm2835 auxiliary spi devices

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

>From 541cf5de027b7e9afe3a8f0ce205d2ccc02ac3fe Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Fri, 11 Sep 2015 11:22:03 +0000
Subject: [PATCH] spi: bcm2835aux: spi: add bindings for the bcm2835 auxiliary
 spi devices

This defines the spi1 and spi2 devices in the device-tree.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../bindings/spi/brcm,bcm2835-aux-spi.txt          | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
new file mode 100644
index 0000000..9887b07
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
@@ -0,0 +1,38 @@
+Broadcom BCM2835 auxiliar SPI1/2 controller
+
+The BCM2835 contains two forms of SPI master controller, one known simply as
+SPI0, and the other known as the "Universal SPI Master"; part of the
+auxiliary block. This binding applies to the SPI1/2 controller.
+
+Required properties:
+- compatible: Should be "brcm,bcm2835-aux-spi".
+- reg: Should contain register location and length for the spi block
+- interrupts: Should contain shared interrupt of the aux block
+- clocks: The clock feeding the SPI controller - needs to
+	  point to the auxiliar clock driver of the bcm2835,
+	  as this clock will enable the output gate for the specific
+	  clock.
+- cs-gpios: the cs-gpios (native cs is NOT supported)
+	    see also spi-bus.txt
+
+Example:
+
+spi1@7e215080 {
+	compatible = "brcm,bcm2835-aux-spi";
+	reg = <0x7e215080 0x40>;
+	interrupts = <1 29>;
+	clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI1>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio 18>, <&gpio 17>, <&gpio 16>;
+};
+
+spi2@7e2150c0 {
+	compatible = "brcm,bcm2835-aux-spi";
+	reg = <0x7e2150c0 0x40>;
+	interrupts = <1 29>;
+	clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI2>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio 43>, <&gpio 44>, <&gpio 45>;
+};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
