From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: axi: Add bindings documentation for Analog Devices axi-spi-engine" to the spi tree
Date: Fri, 05 Feb 2016 18:13:24 +0000
Message-ID: <E1aRksm-0002mD-5E@debutante>
References: <1454602410-14049-1-git-send-email-lars@metafoo.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454602410-14049-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: axi: Add bindings documentation for Analog Devices axi-spi-engine

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

>From 2ec3b6287b12a7131c28cd9408b368cd451bdc48 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Date: Thu, 4 Feb 2016 17:13:29 +0100
Subject: [PATCH] spi: axi: Add bindings documentation for Analog Devices
 axi-spi-engine

Add the devicetree bindings documentation for the Analog Devices
axi-spi-engine SPI master peripheral. This is a soft-peripheral used in
FPGAs.

The external interfaces of the peripheral are:
	* A memory mapped register map which is used to configure the
	  peripheral.
	* One interrupt.
	* Two clocks, one for the memory mapped register interface and one
	  for the SPI bus.
	* A SPI master interface to which the slave devices are connected.

These interfaces are described by the devicetree bindings accordingly.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/adi,axi-spi-engine.txt | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt
new file mode 100644
index 000000000000..8a18d71e6879
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt
@@ -0,0 +1,31 @@
+Analog Devices AXI SPI Engine controller Device Tree Bindings
+
+Required properties:
+- compatible		: Must be "adi,axi-spi-engine-1.00.a""
+- reg			: Physical base address and size of the register map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- clock-names		: List of input clock names - "s_axi_aclk", "spi_clk"
+- clocks		: Clock phandles and specifiers (See clock bindings for
+			  details on clock-names and clocks).
+- #address-cells	: Must be <1>
+- #size-cells		: Must be <0>
+
+Optional subnodes:
+	Subnodes are use to represent the SPI slave devices connected to the SPI
+	master. They follow the generic SPI bindings as outlined in spi-bus.txt.
+
+Example:
+
+    spi@@44a00000 {
+		compatible = "adi,axi-spi-engine-1.00.a";
+		reg = <0x44a00000 0x1000>;
+		interrupts = <0 56 4>;
+		clocks = <&clkc 15 &clkc 15>;
+		clock-names = "s_axi_aclk", "spi_clk";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* SPI devices */
+    };
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
