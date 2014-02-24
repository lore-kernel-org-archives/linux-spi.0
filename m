From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v5 7/8] Documentation: add the binding file for Freescale QuadSPI driver
Date: Mon, 24 Feb 2014 18:37:41 +0800
Message-ID: <1393238262-8622-8-git-send-email-b32955@freescale.com>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <angus.clark-qxv4g6HH51o@public.gmane.org>,
	<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <pekon-l0cyMroinI0@public.gmane.org>, <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	<broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	<b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393238262-8622-1-git-send-email-b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds the binding file for Freescale QuadSPI driver.

Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 .../devicetree/bindings/mtd/fsl-quadspi.txt        |   35 ++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
new file mode 100644
index 0000000..823d134
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
@@ -0,0 +1,35 @@
+* Freescale Quad Serial Peripheral Interface(QuadSPI)
+
+Required properties:
+  - compatible : Should be "fsl,vf610-qspi"
+  - reg : the first contains the register location and length,
+          the second contains the memory mapping address and length
+  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
+  - interrupts : Should contain the interrupt for the device
+  - clocks : The clocks needed by the QuadSPI controller
+  - clock-names : the name of the clocks
+
+Optional properties:
+  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
+                              Each bus can be connected with two NOR flashes.
+			      Most of the time, each bus only has one NOR flash
+			      connected, this is the default case.
+			      But if there are two NOR flashes connected to the
+			      bus, you should enable this property.
+			      (Please check the board's schematic.)
+
+Example:
+
+qspi0: quadspi@40044000 {
+	compatible = "fsl,vf610-qspi";
+	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
+	reg-names = "QuadSPI", "QuadSPI-memory";
+	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks VF610_CLK_QSPI0_EN>,
+		<&clks VF610_CLK_QSPI0>;
+	clock-names = "qspi_en", "qspi";
+
+	flash0: s25fl128s@0 {
+		....
+	};
+};
-- 
1.7.2.rc3


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
