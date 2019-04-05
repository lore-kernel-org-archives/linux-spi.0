From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Don't call spi_get_gpio_descs() before device name is set" to the spi tree
Date: Fri,  5 Apr 2019 10:26:39 +0700 (+07)
Message-ID: <20190405032639.3C438441D3B@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-8-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-8-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Don't call spi_get_gpio_descs() before device name is set

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

>From 0a919ae49223d32ac0e8be3494547fcd1e4aa0aa Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:28 -0700
Subject: [PATCH] spi: Don't call spi_get_gpio_descs() before device name is
 set

Move code calling spi_get_gpio_descs() to happen after ctlr->dev's
name is set in order to have proper GPIO consumer names.

Before:

cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 0-31, parent: platform/40049000.gpio, vf610-gpio:
 gpio-6   (                    |regulator-usb0-vbus ) out lo

gpiochip1: GPIOs 32-63, parent: platform/4004a000.gpio, vf610-gpio:
 gpio-36  (                    |scl                 ) in  hi
 gpio-37  (                    |sda                 ) in  hi
 gpio-40  (                    |(null) CS1          ) out lo
 gpio-41  (                    |(null) CS0          ) out lo ACTIVE LOW
 gpio-42  (                    |miso                ) in  hi
 gpio-43  (                    |mosi                ) in  lo
 gpio-44  (                    |sck                 ) out lo

After:

cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 0-31, parent: platform/40049000.gpio, vf610-gpio:
 gpio-6   (                    |regulator-usb0-vbus ) out lo

gpiochip1: GPIOs 32-63, parent: platform/4004a000.gpio, vf610-gpio:
 gpio-36  (                    |scl                 ) in  hi
 gpio-37  (                    |sda                 ) in  hi
 gpio-40  (                    |spi0 CS1            ) out lo
 gpio-41  (                    |spi0 CS0            ) out lo ACTIVE LOW
 gpio-42  (                    |miso                ) in  hi
 gpio-43  (                    |mosi                ) in  lo
 gpio-44  (                    |sck                 ) out lo

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2ad20c735b61..a83fcddf1dad 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2281,24 +2281,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (status)
 		return status;
 
-	if (!spi_controller_is_slave(ctlr)) {
-		if (ctlr->use_gpio_descriptors) {
-			status = spi_get_gpio_descs(ctlr);
-			if (status)
-				return status;
-			/*
-			 * A controller using GPIO descriptors always
-			 * supports SPI_CS_HIGH if need be.
-			 */
-			ctlr->mode_bits |= SPI_CS_HIGH;
-		} else {
-			/* Legacy code path for GPIOs from DT */
-			status = of_spi_register_master(ctlr);
-			if (status)
-				return status;
-		}
-	}
-
 	/* even if it's just one always-selected device, there must
 	 * be at least one chipselect
 	 */
@@ -2355,6 +2337,25 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 * registration fails if the bus ID is in use.
 	 */
 	dev_set_name(&ctlr->dev, "spi%u", ctlr->bus_num);
+
+	if (!spi_controller_is_slave(ctlr)) {
+		if (ctlr->use_gpio_descriptors) {
+			status = spi_get_gpio_descs(ctlr);
+			if (status)
+				return status;
+			/*
+			 * A controller using GPIO descriptors always
+			 * supports SPI_CS_HIGH if need be.
+			 */
+			ctlr->mode_bits |= SPI_CS_HIGH;
+		} else {
+			/* Legacy code path for GPIOs from DT */
+			status = of_spi_register_master(ctlr);
+			if (status)
+				return status;
+		}
+	}
+
 	status = device_add(&ctlr->dev);
 	if (status < 0) {
 		/* free bus id */
-- 
2.20.1
