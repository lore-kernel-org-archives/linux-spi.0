From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Add DT bindings documentation for Netlogic XLP SPI controller" to the spi tree
Date: Fri, 28 Aug 2015 18:46:23 +0100
Message-ID: <E1ZVNjL-0007Nt-Tk@finisterre>
References: <1440677969-12790-2-git-send-email-kamlakant.patel@broadcom.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440677969-12790-2-git-send-email-kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Add DT bindings documentation for Netlogic XLP SPI controller

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

>From bf9628373418328daf67b6508fc3713fc6f5067d Mon Sep 17 00:00:00 2001
From: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Date: Thu, 27 Aug 2015 17:49:29 +0530
Subject: [PATCH] spi: Add DT bindings documentation for Netlogic XLP SPI
 controller

Add DT bindings documentation for SPI controller driver used by
Netlogic XLP MIPS64 SoCs.

Signed-off-by: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-xlp.txt | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)
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
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
