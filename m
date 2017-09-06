From: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Subject: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum ADI controller documentation
Date: Wed, 6 Sep 2017 14:10:43 +0800
Message-ID: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>,
        <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch adds the binding documentation for Spreadtrum ADI
controller device.

Signed-off-by: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-sprd-adi.txt       |   44 ++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
new file mode 100644
index 0000000..11c5259
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
@@ -0,0 +1,44 @@
+Spreadtrum ADI controller based on SPI framework
+
+ADI is the abbreviation of Anolog-Digital interface, which is used to access
+analog chip (such as PMIC) from digital chip. ADI controller follows the SPI
+framework for its hardware implementation is alike to SPI bus and its timing
+is compatile to SPI timing.
+
+ADI controller has 50 channels including 2 software read/write channels and
+48 hardware channels to access analog chip. For hardware channels, we introduce
+one property named "sprd,hw-channels" to configure hardware channels, the first
+value specifies the channel id, and the second value specifies the address which
+is mapped into analog chip space.
+
+Since we have multi-subsystems will use ADI to access analog chip, then we need
+one hardware spinlock to synchronize between the multiple subsystems.
+
+Required properties:
+- compatible: Should be "sprd,sc9860-adi".
+- reg: Offset and length of ADI-SPI controller register space.
+- hwlocks: Reference to a phandle of a hwlock provider node.
+- hwlock-names: Reference to hwlock name strings defined in the same order
+	as the hwlocks.
+- #address-cells: Number of cells required to define a chip select address
+	on the ADI-SPI bus. Should be set to 1.
+- #size-cells: Size of cells required to define a chip select address size
+	on the ADI-SPI bus. Should be set to 0.
+
+Optional properties:
+- sprd,hw-channels: Specify the hardware channel number and mapped address
+	for hardware channel accessing.
+
+SPI slave nodes must be children of the SPI controller node and can contain
+properties described in Documentation/devicetree/bindings/spi/spi-bus.txt.
+
+Example:
+	adi_bus: spi@40030000 {
+		compatible = "sprd,sc9860-adi";
+		reg = <0 0x40030000 0 0x10000>;
+		hwlocks = <&hwlock1 0>;
+		hwlock-names = "adi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		sprd,hw-channels = <30 0x8c20>;
+	};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
