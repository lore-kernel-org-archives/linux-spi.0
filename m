From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: sirf: add missed devicetree binding document
Date: Sun, 11 Jan 2015 21:58:55 +0800
Message-ID: <1420984735-3842-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-sirf.txt | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sirf.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sirf.txt b/Documentation/devicetree/bindings/spi/spi-sirf.txt
new file mode 100644
index 0000000..4c7adb8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sirf.txt
@@ -0,0 +1,41 @@
+* CSR SiRFprimaII Serial Peripheral Interface
+
+Required properties:
+- compatible : Should be "sirf,prima2-spi"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain SPI interrupt
+- resets: phandle to the reset controller asserting this device in
+          reset
+  See ../reset/reset.txt for details.
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx
+  - tx
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+
+- #address-cells: Number of cells required to define a chip select
+                  address on the SPI bus. Should be set to 1.
+- #size-cells:    Should be zero.
+
+Optional properties:
+- spi-max-frequency: Specifies maximum SPI clock frequency,
+                     Units - Hz. Definition as per
+                     Documentation/devicetree/bindings/spi/spi-bus.txt
+- cs-gpios:     should specify GPIOs used for chipselects.
+
+Example:
+
+spi0: spi@b00d0000 {
+	compatible = "sirf,prima2-spi";
+	reg = <0xb00d0000 0x10000>;
+	interrupts = <15>;
+	dmas = <&dmac1 9>,
+		<&dmac1 4>;
+	dma-names = "rx", "tx";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&clks 19>;
+	resets = <&rstc 26>;
+};
-- 
2.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
