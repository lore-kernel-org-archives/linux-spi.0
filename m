From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: add devicetree binding for lpspi" to the spi tree
Date: Wed, 23 Nov 2016 12:38:25 +0000
Message-ID: <E1c9Woj-0007In-NT@debutante>
References: <1479100967-1894-2-git-send-email-pandy.gao@nxp.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pandy.gao-3arQi8VN3Tc@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org,
        fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479100967-1894-2-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: add devicetree binding for lpspi

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a17efbc5ef9468aae32c7799a0ebc329c15cd0dc Mon Sep 17 00:00:00 2001
From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Date: Tue, 22 Nov 2016 21:52:16 +0800
Subject: [PATCH] spi: imx: add devicetree binding for lpspi

Add a binding document for lpspi driver

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
new file mode 100644
index 000000000000..225ace1d0c65
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
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
