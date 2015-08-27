From: <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/2] spi: Add DT bindings documentation for Netlogic XLP SPI controller
Date: Thu, 27 Aug 2015 17:49:29 +0530
Message-ID: <1440677969-12790-2-git-send-email-kamlakant.patel@broadcom.com>
References: <1440677969-12790-1-git-send-email-kamlakant.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	<linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440677969-12790-1-git-send-email-kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Add DT bindings documentation for SPI controller driver used by
Netlogic XLP MIPS64 SoCs.

Signed-off-by: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
v1->v2:
 * removed 'clock-frequency' property and use fixed-clock framework to get
   spi frequency.

 Documentation/devicetree/bindings/spi/spi-xlp.txt |   39 +++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xlp.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-xlp.txt b/Documentation/devicetree/bindings/spi/spi-xlp.txt
new file mode 100644
index 0000000..40e82d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-xlp.txt
@@ -0,0 +1,39 @@
+SPI Master controller for Netlogic XLP MIPS64 SOCs
+==================================================
+
+Currently this SPI controller driver is supported for the following
+Netlogic XLP SoCs:
+	XLP832, XLP316, XLP208, XLP980, XLP532
+
+Required properties:
+- compatible		: Should be "netlogic,xlp832-spi".
+- #address-cells	: Number of cells required to define a chip select address
+			  on the SPI bus.
+- #size-cells		: Should be zero.
+- reg			: Should contain register location and length.
+- clocks		: Phandle of the spi clock
+- interrupts		: Interrupt number used by this controller.
+- interrupt-parent	: Phandle of the parent interrupt controller.
+
+SPI slave nodes must be children of the SPI master node and can contain
+properties described in Documentation/devicetree/bindings/spi/spi-bus.txt.
+
+Example:
+
+	spi: xlp_spi@3a100 {
+		compatible = "netlogic,xlp832-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x3a100 0x100>;
+		clocks = <&spi_clk>;
+		interrupts = <34>;
+		interrupt-parent = <&pic>;
+
+		spi_nor@1 {
+			compatible = "spansion,s25sl12801";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <1>;	/* Chip Select */
+			spi-max-frequency = <40000000>;
+		};
+};
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
