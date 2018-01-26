From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: [PATCH 3/4] pinctrl: mcp23s08: spi: Add HW address to gpio_chip.label
Date: Fri, 26 Jan 2018 20:16:47 +0100
Message-ID: <03c5ea4d98804e4ea6b0927e5bf103106e438142.1516997103.git.jan.kundrat@cesnet.cz>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Reid <preid@electromag.com.au>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: linux-gpio@vger.kernel.org
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1516997103.git.jan.kundrat@cesnet.cz>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When several devices are sharing one hardware SPI CS, there is no visual
clue in `lsgpio` or in /sys/kernel/debug/gpio about which one is which
one. Stuff depends on the enumeration order, and therefore lower chip
addresses always go first, but that's just an implementation detail.
This change includes the device-specific address in the debug output:

  gpiochip4: GPIOs 464-479, parent: spi/spi1.1, mcp23s17.2, can sleep:
  gpiochip3: GPIOs 480-495, parent: spi/spi1.1, mcp23s17.1, can sleep:

Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 8dc758bacdd1..c76c9d4b26c9 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -789,6 +789,7 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	int status, ret;
 	bool mirror = false;
 	struct regmap_config *one_regmap_config = NULL;
+	int raw_chip_address = (addr & ~0x40) >> 1;
 
 	mutex_init(&mcp->lock);
 
@@ -817,7 +818,8 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 					sizeof(struct regmap_config), GFP_KERNEL);
 			mcp->reg_shift = 0;
 			mcp->chip.ngpio = 8;
-			mcp->chip.label = "mcp23s08";
+			mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL,
+					"mcp23s08.%d", raw_chip_address);
 			break;
 		case MCP_TYPE_S17:
 			one_regmap_config =
@@ -825,13 +827,14 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 					sizeof(struct regmap_config), GFP_KERNEL);
 			mcp->reg_shift = 1;
 			mcp->chip.ngpio = 16;
-			mcp->chip.label = "mcp23s17";
+			mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL,
+					"mcp23s17.%d", raw_chip_address);
 			break;
 		}
 		if (!one_regmap_config)
 			return -ENOMEM;
 
-		one_regmap_config->name = devm_kasprintf(dev, GFP_KERNEL, "%d", (addr & ~0x40) >> 1);
+		one_regmap_config->name = devm_kasprintf(dev, GFP_KERNEL, "%d", raw_chip_address);
 		mcp->regmap = devm_regmap_init(dev, &mcp23sxx_spi_regmap, mcp,
 					       one_regmap_config);
 		break;
-- 
2.14.3


