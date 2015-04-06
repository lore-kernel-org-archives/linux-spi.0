From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first spi_setup
Date: Mon,  6 Apr 2015 17:16:31 +0000
Message-ID: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Transforms the bcm-2835 native SPI-chip select to their gpio-cs equivalent.

This allows for some support of some optimizations that are not
possible due to HW-gliches on the CS line - especially filling
the FIFO before enabling SPI interrupts (by writing to CS register)
while the transfer is already in progress (See commit: e3a2be3030e2)

This patch also works arround some issues in bcm2835-pinctrl which does not
set the value when setting the GPIO as output - it just sets up output and
(typically) leaves the GPIO as low.  When a fix for this is merged then this
gpio_set_value can get removed from bcm2835_spi_setup.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   49 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

Applies against: spi - for-next

There was a question if we could move the native-cs to GPIO in the driver
itself.

This patch implements this, but it is quite complex for the minimal gains.

Maybe the originally proposed simple warning recommending to use cs_gpio
in DT would be a sufficient alternative that introduces less code.

Tested with the following setup:
* native CS:
  * mcp2515
  * mmc_spi (patched to make it work on the RPI)
* gpio-CS:
  * mcp2515
  * enc28j60
* gpio-CS with "spi-cs-pol" set in DT:
  * fb_st7735r

Note: that there is a possible the risk that a transfer (for a different
device) is running at the time of this change - maybe some "extra" bus-locking
is needed during the change of the GPIO function to output.

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 88b808b..b2651fa 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -351,8 +351,15 @@ static void bcm2835_spi_set_cs(struct spi_device *spi, bool gpio_level)
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
 }

+static int chip_match_name(struct gpio_chip *chip, void *data)
+{
+	return !strcmp(chip->label, data);
+}
+
 static int bcm2835_spi_setup(struct spi_device *spi)
 {
+	int err;
+	struct gpio_chip *chip;
 	/*
 	 * sanity checking the native-chipselects
 	 */
@@ -360,13 +367,45 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		return 0;
 	if (gpio_is_valid(spi->cs_gpio))
 		return 0;
-	if (spi->chip_select < 3)
+	if (spi->chip_select > 1) {
+		/* error in the case of native CS requested with CS > 1
+		 * officially there is a CS2, but it is not documented
+		 * which GPIO is connected with that...
+		 */
+		dev_err(&spi->dev,
+			"setup: only two native chip-selects are supported\n");
+		return -EINVAL;
+	}
+	/* now translate native cs to GPIO */
+
+	/* get the gpio chip for the base */
+	chip = gpiochip_find("pinctrl-bcm2835", chip_match_name);
+	if (!chip)
 		return 0;

-	/* error in the case of native CS requested with CS-id > 2 */
-	dev_err(&spi->dev,
-		"setup: only three native chip-selects are supported\n");
-	return -EINVAL;
+	/* and calculate the real CS */
+	spi->cs_gpio = chip->base + 8 - spi->chip_select;
+
+	/* and set up the "mode" and level */
+	dev_info(&spi->dev, "setting up native-CS%i as GPIO %i\n",
+		 spi->chip_select, spi->cs_gpio);
+
+	/* set up GPIO as output and pull to the correct level */
+	err = gpio_direction_output(spi->cs_gpio,
+				    (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+	if (err) {
+		dev_err(&spi->dev,
+			"could not set CS%i gpio %i as output: %i",
+			spi->chip_select, spi->cs_gpio, err);
+		return err;
+	}
+	/* the implementation of pinctrl-bcm2835 currently does not
+	 * set the GPIO value when using gpio_direction_output
+	 * so we are setting it here explicitly
+	 */
+	gpio_set_value(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+
+	return 0;
 }

 static int bcm2835_spi_probe(struct platform_device *pdev)
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
