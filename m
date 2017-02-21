From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/bcm63xx: document bcm63xx SPI devicetree bindings" to the spi tree
Date: Tue, 21 Feb 2017 15:05:16 -0800
Message-ID: <E1cgJUi-0004qr-RS@finisterre>
References: <20170221105822.10437-1-jonas.gorski@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170221105822.10437-1-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/bcm63xx: document bcm63xx SPI devicetree bindings

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

>From 54e43b6085f12bec3718806d0bf6ba4a3e4b2078 Mon Sep 17 00:00:00 2001
From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 21 Feb 2017 11:58:21 +0100
Subject: [PATCH] spi/bcm63xx: document bcm63xx SPI devicetree bindings

Add documentation for the bindings of the low speed SPI controller found
on most bcm63xx SoCs.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-bcm63xx.txt        | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
new file mode 100644
index 000000000000..1c16f6692613
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
@@ -0,0 +1,33 @@
+Binding for Broadcom BCM6348/BCM6358 SPI controller
+
+Required properties:
+- compatible: must contain one of "brcm,bcm6348-spi", "brcm,bcm6358-spi".
+- reg: Base address and size of the controllers memory area.
+- interrupts: Interrupt for the SPI block.
+- clocks: phandle of the SPI clock.
+- clock-names: has to be "spi".
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
+	spi@10000800 {
+		compatible = "brcm,bcm6368-spi", "brcm,bcm6358-spi";
+		reg = <0x10000800 0x70c>;
+
+		interrupts = <1>;
+
+		clocks = <&clkctl 9>;
+		clock-names = "spi";
+
+		num-cs = <5>;
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
