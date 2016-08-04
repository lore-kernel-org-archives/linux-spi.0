From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: [PATCH v5 1/2] of: add J-Core SPI master bindings
Date: Thu, 04 Aug 2016 04:30:37 +0000
Message-ID: <bc53c38fe100bd17b278dfb214eefea323a3ac4a.147018b7592.git.dalias@libc.org>
References: <cover.147018b7592.git.dalias@libc.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.147018b7592.git.dalias-8zAoT0mYgF4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
---
 .../devicetree/bindings/spi/jcore,spi.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt

diff --git a/Documentation/devicetree/bindings/spi/jcore,spi.txt b/Documentation/devicetree/bindings/spi/jcore,spi.txt
new file mode 100644
index 0000000..93936d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/jcore,spi.txt
@@ -0,0 +1,34 @@
+J-Core SPI master
+
+Required properties:
+
+- compatible: Must be "jcore,spi2".
+
+- reg: Memory region for registers.
+
+- #address-cells: Must be 1.
+
+- #size-cells: Must be 0.
+
+Optional properties:
+
+- clocks: If a phandle named "ref_clk" is present, SPI clock speed
+  programming is relative to the frequency of the indicated clock.
+  Necessary only if the input clock rate is something other than a
+  fixed 50 MHz.
+
+- clock-names: Clock names, one for each phandle in clocks.
+
+See spi-bus.txt for additional properties not specific to this device.
+
+Example:
+
+spi@40 {
+	compatible = "jcore,spi2";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x40 0x8>;
+	spi-max-frequency = <25000000>;
+	clocks = <&bus_clk>;
+	clock-names = "ref_clk";
+}
-- 
2.8.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
