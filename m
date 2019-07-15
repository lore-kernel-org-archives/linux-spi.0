From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] Revert "gpio/spi: Fix spi-gpio regression on active high CS"
Date: Mon, 15 Jul 2019 22:45:29 +0200
Message-ID: <20190715204529.9539-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, stable@vger.kernel.org
To: linux-gpio@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This reverts commit fbbf145a0e0a0177e089c52275fbfa55763e7d1d.

It seems I was misguided in my fixup, which was working at the
time but did not work on the final v5.2.

The patch tried to avoid a quirk the gpiolib code not to treat
"spi-gpio" CS gpios "special" by enforcing them to be active
low, in the belief that since the "spi-gpio" driver was
parsing the device tree on its own, it did not care to inspect
the "spi-cs-high" attribute on the device nodes.

That's wrong. The SPI core was inspecting them inside the
of_spi_parse_dt() funtion and setting SPI_CS_HIGH on the
nodes, and the driver inspected this flag when driving the
line.

As of now, the core handles the GPIO and it will consistently
set the GPIO descriptor to 1 to enable CS, strictly requireing
the gpiolib to invert it. And the gpiolib should indeed
enforce active low on the CS line.

Device trees should of course put the right flag on the GPIO
handles, but it used to not matter. If we don't enforce active
low on "gpio-gpio" we may run into ABI backward compatibility
issues, so revert this.

Cc: linux-spi@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I am sorry that this at one point fixed a problem for me, it
doesn't anymore and I don't know why it ever did. :(
---
 drivers/gpio/gpiolib-of.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index f974075ff00e..a8f02f551d6b 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -118,15 +118,8 @@ static void of_gpio_flags_quirks(struct device_node *np,
 	 * Legacy handling of SPI active high chip select. If we have a
 	 * property named "cs-gpios" we need to inspect the child node
 	 * to determine if the flags should have inverted semantics.
-	 *
-	 * This does not apply to an SPI device named "spi-gpio", because
-	 * these have traditionally obtained their own GPIOs by parsing
-	 * the device tree directly and did not respect any "spi-cs-high"
-	 * property on the SPI bus children.
 	 */
-	if (IS_ENABLED(CONFIG_SPI_MASTER) &&
-	    !strcmp(propname, "cs-gpios") &&
-	    !of_device_is_compatible(np, "spi-gpio") &&
+	if (IS_ENABLED(CONFIG_SPI_MASTER) && !strcmp(propname, "cs-gpios") &&
 	    of_property_read_bool(np, "cs-gpios")) {
 		struct device_node *child;
 		u32 cs;
-- 
2.21.0
