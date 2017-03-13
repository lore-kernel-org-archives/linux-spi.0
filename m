From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/bcm63xx-hsspi: document bcm63xx HS SPI devicetree bindings" to the spi tree
Date: Mon, 13 Mar 2017 16:57:18 +0000
Message-ID: <E1cnTHa-0004tq-MY@debutante>
References: <20170301090814.7097-2-jonas.gorski@gmail.com>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170301090814.7097-2-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/bcm63xx-hsspi: document bcm63xx HS SPI devicetree bindings

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

>From 8c0951afd8a7585a4281980b9a21dcc8a419cad9 Mon Sep 17 00:00:00 2001
From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 1 Mar 2017 10:08:13 +0100
Subject: [PATCH] spi/bcm63xx-hsspi: document bcm63xx HS SPI devicetree
 bindings

Add documentation for the bindings of the high speed SPI controller found
on newer bcm63xx SoCs.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-bcm63xx-hsspi.txt  | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
new file mode 100644
index 000000000000..37b29ee13860
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
@@ -0,0 +1,33 @@
+Binding for Broadcom BCM6328 High Speed SPI controller
+
+Required properties:
+- compatible: must contain of "brcm,bcm6328-hsspi".
+- reg: Base address and size of the controllers memory area.
+- interrupts: Interrupt for the SPI block.
+- clocks: phandles of the SPI clock and the PLL clock.
+- clock-names: must be "hsspi", "pll".
+- #address-cells: <1>, as required by generic SPI binding.
+- #size-cells: <0>, also as required by generic SPI binding.
+
+Optional properties:
+- num-cs: some controllers have less than 8 cs signals. Defaults to 8
+  if absent.
+
+Child nodes as per the generic SPI binding.
+
+Example:
+
+	spi@10001000 {
+		compatible = "brcm,bcm6328-hsspi";
+		reg = <0x10001000 0x600>;
+
+		interrupts = <29>;
+
+		clocks = <&clkctl 9>, <&hsspi_pll>;
+		clock-names = "hsspi", "pll";
+
+		num-cs = <2>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
