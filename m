From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 124/205] gpio: of: Handle SPI chipselect legacy bindings
Date: Fri,  8 Nov 2019 06:36:31 -0500
Message-ID: <20191108113752.12502-124-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 6953c57ab1721ce57914fc5741d0ce0568756bb0 ]

The SPI chipselects are assumed to be active low in the current
binding, so when we want to use GPIO descriptors and handle
the active low/high semantics in gpiolib, we need a special
parsing quirk to deal with this.

We check for the property "spi-cs-high" and if that is
NOT present we assume the CS line is active low.

If the line is tagged as active low in the device tree and
has no "spi-cs-high" property all is fine, the device
tree and the SPI bindings are in agreement.

If the line is tagged as active high in the device tree with
the second cell flag and has no "spi-cs-high" property we
enforce active low semantics (as this is the exception we can
just tag on the flag).

If the line is tagged as active low with the second cell flag
AND tagged with "spi-cs-high" the SPI active high property
takes precedence and we print a warning.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 50 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index e0f149bdf98ff..fa212c2a7577c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -58,7 +58,8 @@ static struct gpio_desc *of_xlate_and_get_gpiod_flags(struct gpio_chip *chip,
 }
 
 static void of_gpio_flags_quirks(struct device_node *np,
-				 enum of_gpio_flags *flags)
+				 enum of_gpio_flags *flags,
+				 int index)
 {
 	/*
 	 * Some GPIO fixed regulator quirks.
@@ -92,6 +93,51 @@ static void of_gpio_flags_quirks(struct device_node *np,
 		pr_info("%s uses legacy open drain flag - update the DTS if you can\n",
 			of_node_full_name(np));
 	}
+
+	/*
+	 * Legacy handling of SPI active high chip select. If we have a
+	 * property named "cs-gpios" we need to inspect the child node
+	 * to determine if the flags should have inverted semantics.
+	 */
+	if (IS_ENABLED(CONFIG_SPI_MASTER) &&
+	    of_property_read_bool(np, "cs-gpios")) {
+		struct device_node *child;
+		u32 cs;
+		int ret;
+
+		for_each_child_of_node(np, child) {
+			ret = of_property_read_u32(child, "reg", &cs);
+			if (!ret)
+				continue;
+			if (cs == index) {
+				/*
+				 * SPI children have active low chip selects
+				 * by default. This can be specified negatively
+				 * by just omitting "spi-cs-high" in the
+				 * device node, or actively by tagging on
+				 * GPIO_ACTIVE_LOW as flag in the device
+				 * tree. If the line is simultaneously
+				 * tagged as active low in the device tree
+				 * and has the "spi-cs-high" set, we get a
+				 * conflict and the "spi-cs-high" flag will
+				 * take precedence.
+				 */
+				if (of_property_read_bool(np, "spi-cs-high")) {
+					if (*flags & OF_GPIO_ACTIVE_LOW) {
+						pr_warn("%s GPIO handle specifies active low - ignored\n",
+							of_node_full_name(np));
+						*flags &= ~OF_GPIO_ACTIVE_LOW;
+					}
+				} else {
+					if (!(*flags & OF_GPIO_ACTIVE_LOW))
+						pr_info("%s enforce active low on chipselect handle\n",
+							of_node_full_name(np));
+					*flags |= OF_GPIO_ACTIVE_LOW;
+				}
+				break;
+			}
+		}
+	}
 }
 
 /**
@@ -132,7 +178,7 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 		goto out;
 
 	if (flags)
-		of_gpio_flags_quirks(np, flags);
+		of_gpio_flags_quirks(np, flags, index);
 
 	pr_debug("%s: parsed '%s' property of node '%pOF[%d]' - status (%d)\n",
 		 __func__, propname, np, index,
-- 
2.20.1
