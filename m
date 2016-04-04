From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pic32: Add bindings for PIC32 SPI peripheral" to the spi tree
Date: Mon, 04 Apr 2016 10:05:34 -0700
Message-ID: <E1an7wU-0004WQ-Mb@finisterre>
References: <1457099082-12587-1-git-send-email-purna.mandal@microchip.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457099082-12587-1-git-send-email-purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pic32: Add bindings for PIC32 SPI peripheral

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

>From 120e8989ebac7c7c702e351046c20e9918912aca Mon Sep 17 00:00:00 2001
From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Date: Fri, 1 Apr 2016 16:48:49 +0530
Subject: [PATCH] spi: pic32: Add bindings for PIC32 SPI peripheral

Document the devicetree bindings for the SPI peripheral found
on Microchip PIC32 class devices.

Signed-off-by: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../bindings/spi/microchip,spi-pic32.txt           | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
new file mode 100644
index 000000000000..79de379f4dc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
@@ -0,0 +1,34 @@
+Microchip PIC32 SPI Master controller
+
+Required properties:
+- compatible: Should be "microchip,pic32mzda-spi".
+- reg: Address and length of register space for the device.
+- interrupts: Should contain all three spi interrupts in sequence
+              of <fault-irq>, <receive-irq>, <transmit-irq>.
+- interrupt-names: Should be "fault", "rx", "tx" in order.
+- clocks: Phandle of the clock generating SPI clock on the bus.
+- clock-names: Should be "mck0".
+- cs-gpios: Specifies the gpio pins to be used for chipselects.
+            See: Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+- dmas: Two or more DMA channel specifiers following the convention outlined
+        in Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: Names for the dma channels. There must be at least one channel
+             named "spi-tx" for transmit and named "spi-rx" for receive.
+
+Example:
+
+spi1: spi@1f821000 {
+        compatible = "microchip,pic32mzda-spi";
+        reg = <0x1f821000 0x200>;
+        interrupts = <109 IRQ_TYPE_LEVEL_HIGH>,
+                     <110 IRQ_TYPE_LEVEL_HIGH>,
+                     <111 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "fault", "rx", "tx";
+        clocks = <&PBCLK2>;
+        clock-names = "mck0";
+        cs-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+        dmas = <&dma 134>, <&dma 135>;
+        dma-names = "spi-rx", "spi-tx";
+};
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
