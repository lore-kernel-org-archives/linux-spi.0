From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: xilinx: Add devicetree binding for spi-xilinx" to the spi tree
Date: Thu, 10 Mar 2016 10:39:30 +0700
Message-ID: <E1adrRi-0007cp-8s@finisterre>
References: <1457513242-11202-1-git-send-email-shubhraj@xilinx.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457513242-11202-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: xilinx: Add devicetree binding for spi-xilinx

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

>From 82b3aea65f9fee161d8e07602e5a8c7b0b103fa3 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Date: Wed, 9 Mar 2016 14:17:20 +0530
Subject: [PATCH] spi: xilinx: Add devicetree binding for spi-xilinx

Add a binding document for the spi/spi-xilinx

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-xilinx.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
new file mode 100644
index 000000000000..c7b7856bd528
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -0,0 +1,22 @@
+Xilinx SPI controller Device Tree Bindings
+-------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,xps-spi-2.00.a" or "xlnx,xps-spi-2.00.b"
+- reg			: Physical base address and size of SPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller
+
+Optional properties:
+- xlnx,num-ss-bits	: Number of chip selects used.
+
+Example:
+	axi_quad_spi@41e00000 {
+			compatible = "xlnx,xps-spi-2.00.a";
+			interrupt-parent = <&intc>;
+			interrupts = <0 31 1>;
+			reg = <0x41e00000 0x10000>;
+			xlnx,num-ss-bits = <0x1>;
+	};
+
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
