From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V2 2/2] spi: imx: add devicetree binding for lpspi
Date: Tue, 15 Nov 2016 21:33:51 +0800
Message-ID: <1479216831-8709-2-git-send-email-pandy.gao@nxp.com>
References: <1479216831-8709-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>,
        <frank.li-3arQi8VN3Tc@public.gmane.org>, <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479216831-8709-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add a binding document for lpspi driver

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
new file mode 100644
index 0000000..225ace1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -0,0 +1,19 @@
+* Freescale Low Power SPI (LPSPI) for i.MX
+
+Required properties:
+- compatible :
+  - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX7ULP soc
+- reg : address and length of the lpspi master registers
+- interrupt-parent : core interrupt controller
+- interrupts : lpspi interrupt
+- clocks : lpspi clock specifier
+
+Examples:
+
+lpspi2: lpspi@40290000 {
+	compatible = "fsl,imx7ulp-spi";
+	reg = <0x40290000 0x10000>;
+	interrupt-parent = <&intc>;
+	interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX7ULP_CLK_LPSPI2>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
