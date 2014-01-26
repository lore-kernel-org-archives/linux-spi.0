From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v2 4/5] spi: dw: document device tree binding
Date: Sun, 26 Jan 2014 10:14:35 +0200
Message-ID: <211f8d2101fff1790526f7dff766d0d9efff9280.1390723880.git.baruch@tkos.co.il>
References: <cover.1390723880.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1390723880.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-dw.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-dw.txt b/Documentation/devicetree/bindings/spi/spi-dw.txt
new file mode 100644
index 000000000000..7b63ed601990
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-dw.txt
@@ -0,0 +1,24 @@
+Synopsys DesignWare SPI master
+
+Required properties:
+- compatible: should be "snps,designware-spi"
+- #address-cells: see spi-bus.txt
+- #size-cells: see spi-bus.txt
+- reg: address and length of the spi master registers
+- interrupts: should contain one interrupt
+- clocks: spi clock phandle
+- num-cs: see spi-bus.txt
+
+Optional properties:
+- cs-gpios: see spi-bus.txt
+
+Example:
+
+spi: spi@4020a000 {
+	compatible = "snps,designware-spi";
+	interrupts = <11 1>;
+	reg = <0x4020a000 0x1000>;
+	clocks = <&pclk>;
+	num-cs = <2>;
+	cs-gpios = <&banka 0 0>;
+};
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
