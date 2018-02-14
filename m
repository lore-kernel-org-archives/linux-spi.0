From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-gpio: Augment device tree bindings" to the spi tree
Date: Wed, 14 Feb 2018 16:28:44 +0000
Message-ID: <E1elzvI-0005pZ-U3@debutante>
References: <20180101133749.29567-4-linus.walleij@linaro.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101133749.29567-4-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-gpio: Augment device tree bindings

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 77a060533c0468069d0b4a5d1968a42259763f08 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date: Mon, 12 Feb 2018 13:45:32 +0100
Subject: [PATCH] spi: spi-gpio: Augment device tree bindings

After we augmented the core to handle "gpio-sck"/"sck-gpios",
"gpio-mosi"/"mosi-gpios", "gpio-miso"/"miso-gpios" alike,
deprecate the old binding and put the strict modern and
recommended binding practice into place as the default for
GPIO-based SPI.

This reflects the similar change in I2C:
commit 7d29f509d2cf
("dt-bindings: i2c: i2c-gpio: Add support for named gpios")

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-gpio.txt | 24 ++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.txt b/Documentation/devicetree/bindings/spi/spi-gpio.txt
index a95603bcf6ff..52db562f17a4 100644
--- a/Documentation/devicetree/bindings/spi/spi-gpio.txt
+++ b/Documentation/devicetree/bindings/spi/spi-gpio.txt
@@ -1,18 +1,30 @@
 SPI-GPIO devicetree bindings
 
+This represents a group of 3-n GPIO lines used for bit-banged SPI on dedicated
+GPIO lines.
+
 Required properties:
 
  - compatible: should be set to "spi-gpio"
  - #address-cells: should be set to <0x1>
  - ranges
- - gpio-sck: GPIO spec for the SCK line to use
- - gpio-miso: GPIO spec for the MISO line to use
- - gpio-mosi: GPIO spec for the MOSI line to use
+ - sck-gpios: GPIO spec for the SCK line to use
+ - miso-gpios: GPIO spec for the MISO line to use
+ - mosi-gpios: GPIO spec for the MOSI line to use
  - cs-gpios: GPIOs to use for chipselect lines.
              Not needed if num-chipselects = <0>.
  - num-chipselects: Number of chipselect lines. Should be <0> if a single device
                     with no chip select is connected.
 
+Deprecated bindings:
+
+These legacy GPIO line bindings can alternatively be used to define the
+GPIO lines used, they should not be used in new device trees.
+
+ - gpio-sck: GPIO spec for the SCK line to use
+ - gpio-miso: GPIO spec for the MISO line to use
+ - gpio-mosi: GPIO spec for the MOSI line to use
+
 Example:
 
 	spi {
@@ -20,9 +32,9 @@ Example:
 		#address-cells = <0x1>;
 		ranges;
 
-		gpio-sck = <&gpio 95 0>;
-		gpio-miso = <&gpio 98 0>;
-		gpio-mosi = <&gpio 97 0>;
+		sck-gpios = <&gpio 95 0>;
+		miso-gpios = <&gpio 98 0>;
+		mosi-gpios = <&gpio 97 0>;
 		cs-gpios = <&gpio 125 0>;
 		num-chipselects = <1>;
 
-- 
2.16.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
