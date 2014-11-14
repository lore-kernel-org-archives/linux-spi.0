From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH V3 1/2] spi: Add binding document for IMG SPFI controller
Date: Fri, 14 Nov 2014 10:48:31 -0800
Message-ID: <1415990912-31744-2-git-send-email-abrestic@chromium.org>
References: <1415990912-31744-1-git-send-email-abrestic@chromium.org>
Cc: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Ezequiel Garcia <Ezequiel.Garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415990912-31744-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Synchronous Peripheral Flash Interface (SPFI) controller found
on IMG SoCs supports single, dual, and (optionally) quad mode SPI
transfers.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
No changes from v2.
Changes from v1:
 - spi-img.txt -> spi-img-spfi.txt
 - fixed commit subject
---
 .../devicetree/bindings/spi/spi-img-spfi.txt       | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-img-spfi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-img-spfi.txt b/Documentation/devicetree/bindings/spi/spi-img-spfi.txt
new file mode 100644
index 0000000..c7dd50f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-img-spfi.txt
@@ -0,0 +1,37 @@
+IMG Synchronous Peripheral Flash Interface (SPFI) controller
+
+Required properties:
+- compatible: Must be "img,spfi".
+- reg: Must contain the base address and length of the SPFI registers.
+- interrupts: Must contain the SPFI interrupt.
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clock/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - spfi: SPI operating clock
+  - sys: SPI system interface clock
+- dmas: Must contain an entry for each entry in dma-names.
+  See ../dma/dma.txt for details.
+- dma-names: Must include the following entries:
+  - rx
+  - tx
+- #address-cells: Must be 1.
+- #size-cells: Must be 0.
+
+Optional properties:
+- img,supports-quad-mode: Should be set if the interface supports quad mode
+  SPI transfers.
+
+Example:
+
+spi@18100f00 {
+	compatible = "img,spfi";
+	reg = <0x18100f00 0x100>;
+	interrupts = <GIC_SHARED 22 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&spi_clk>, <&system_clk>;
+	clock-names = "spfi", "sys";
+	dmas = <&mdc 9 0xffffffff 0>, <&mdc 10 0xffffffff 0>;
+	dma-names = "rx", "tx";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
2.1.0.rc2.206.gedb03e5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
