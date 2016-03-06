From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [RESEND PATCH v2 1/2] dt/bindings: Add bindings for PIC32 SPI peripheral
Date: Sun, 6 Mar 2016 10:05:26 +0530
Message-ID: <1457238927-16120-1-git-send-email-purna.mandal@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	Joshua Henderson <digitalpeer-icZdIMMiY0PM6KjX8ROVJw@public.gmane.org>,
	Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

---

Changes in v2:
 - fix indentation
 - add space after comma
 - moved 'cs-gpios' section under 'required' properties.

 .../bindings/spi/microchip,spi-pic32.txt           | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
new file mode 100644
index 0000000..79de379f
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
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
