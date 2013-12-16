From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v3 6/7] Documentation: add the binding file for Quadspi driver
Date: Mon, 16 Dec 2013 16:58:49 +0800
Message-ID: <1387184330-14448-7-git-send-email-b32955@freescale.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <angus.clark-qxv4g6HH51o@public.gmane.org>,
	<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>, <pekon-l0cyMroinI0@public.gmane.org>,
	<sourav.poddar-l0cyMroinI0@public.gmane.org>, <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	<b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387184330-14448-1-git-send-email-b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds the binding file for Freescale Quadspi driver.

Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 .../devicetree/bindings/mtd/fsl-quadspi.txt        |   31 ++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
new file mode 100644
index 0000000..3475cfa
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
@@ -0,0 +1,31 @@
+* Freescale Quad Serial Peripheral Interface(QuadSPI)
+
+Required properties:
+- compatible : Should be "fsl,vf610-qspi"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain the interrupt for the device
+- clocks : The clocks needed by the QuadSPI controller
+- clock-names : the name of the clocks
+- fsl,nor-num : Contains the number of SPI NOR chips connected to
+                the controller.
+- fsl,nor-size : the size of each SPI NOR.
+- fsl,max-frequency : the frequency at which the SPI NOR works.
+
+Example:
+
+qspi0: quadspi@40044000 {
+	compatible = "fsl,vf610-qspi";
+	reg = <0x40044000 0x1000>;
+	interrupts = <0 24 0x04>;
+	clocks = <&clks VF610_CLK_QSPI0_EN>,
+		<&clks VF610_CLK_QSPI0>;
+	clock-names = "qspi_en", "qspi";
+	fsl,nor-num = <1>;
+	fsl,nor-size = <0x1000000>;
+	fsl,max-frequency = <66000000>;
+	status = "okay";
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
