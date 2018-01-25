From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: [PATCH 2/4] pinctrl: mcp23s08: spi: Fix regmap debugfs entries
Date: Thu, 25 Jan 2018 18:29:15 +0100
Message-ID: <de8fbb7902652b5a512f67e2ee0813571e9d2372.1516997103.git.jan.kundrat@cesnet.cz>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>,
        Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
To: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1516997103.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The SPI version of this chip allows several devices to be present on the
same SPI bus via a local address. If this is in action and if the kernel
has debugfs, however, the code attempts to create duplicate entries for
the regmap's debugfs:

  mcp23s08 spi1.1: Failed to create debugfs directory

This patch simply assigns a local name matching the device logical
address to the `struct regmap_config`.

No changes are needed for MCP23S18 because that device does not support
any logical addressing. Similarly, I2C devices do not need any action,
either, because they are already different in their I2C address.

A similar problem is present for the pinctrl debugfs instance, but that
one is not addressed by this patch.

Signed-off-by: Jan Kundrát <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 186101c575e3..8dc758bacdd1 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -788,6 +788,7 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 {
 	int status, ret;
 	bool mirror = false;
+	struct regmap_config *one_regmap_config = NULL;
 
 	mutex_init(&mcp->lock);
 
@@ -808,22 +809,36 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	switch (type) {
 #ifdef CONFIG_SPI_MASTER
 	case MCP_TYPE_S08:
-		mcp->regmap = devm_regmap_init(dev, &mcp23sxx_spi_regmap, mcp,
-					       &mcp23x08_regmap);
-		mcp->reg_shift = 0;
-		mcp->chip.ngpio = 8;
-		mcp->chip.label = "mcp23s08";
-		break;
-
 	case MCP_TYPE_S17:
+		switch (type) {
+		case MCP_TYPE_S08:
+			one_regmap_config =
+				devm_kmemdup(dev, &mcp23x08_regmap,
+					sizeof(struct regmap_config), GFP_KERNEL);
+			mcp->reg_shift = 0;
+			mcp->chip.ngpio = 8;
+			mcp->chip.label = "mcp23s08";
+			break;
+		case MCP_TYPE_S17:
+			one_regmap_config =
+				devm_kmemdup(dev, &mcp23x17_regmap,
+					sizeof(struct regmap_config), GFP_KERNEL);
+			mcp->reg_shift = 1;
+			mcp->chip.ngpio = 16;
+			mcp->chip.label = "mcp23s17";
+			break;
+		}
+		if (!one_regmap_config)
+			return -ENOMEM;
+
+		one_regmap_config->name = devm_kasprintf(dev, GFP_KERNEL, "%d", (addr & ~0x40) >> 1);
 		mcp->regmap = devm_regmap_init(dev, &mcp23sxx_spi_regmap, mcp,
-					       &mcp23x17_regmap);
-		mcp->reg_shift = 1;
-		mcp->chip.ngpio = 16;
-		mcp->chip.label = "mcp23s17";
+					       one_regmap_config);
 		break;
 
 	case MCP_TYPE_S18:
+		if (!one_regmap_config)
+			return -ENOMEM;
 		mcp->regmap = devm_regmap_init(dev, &mcp23sxx_spi_regmap, mcp,
 					       &mcp23x17_regmap);
 		mcp->reg_shift = 1;
-- 
2.14.3


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
