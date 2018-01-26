From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: [PATCH 0/4] Improvements for MCP23Sxx chips
Date: Fri, 26 Jan 2018 21:11:03 +0100
Message-ID: <cover.1516997103.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Reid <preid@electromag.com.au>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: linux-gpio@vger.kernel.org
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

a) Open-Drain output of the IRQ lane (see inside for possible caveats).
b) Improvements for multi-instances on the same SPI CS.

This chip is "special" because it supports several "instances" sharing
the same SPI CS lane. Each chip has three HW pins for specifying an
internal address. The first byte of each SPI transaction then
distinguishes which chip we're talking to. So far, so good -- that's
something that the driver already supports.

The actual implementation simply instantiates several regmap and pinctrl
instances sharing the same parent (the spi/spiX.Y dev). That leads to
clashes as soon as more HW chips are present because of naming clashes
within debugfs.

Fixing this for regmap is pretty straightforward. The patch which
implements something similar for the pinctrl subsystem is a bit more
involved because it touches the pinctrl core. The resulting names are
ugly and the `strcmp` in there is largely a hack in order to not force
even more ugliness to the existing chips.

Jan Kundrát (4):
  pinctrl: mcp23s08: IRQ behavior for open-drain interrupts
  pinctrl: mcp23s08: spi: Fix regmap debugfs entries
  pinctrl: mcp23s08: spi: Add HW address to gpio_chip.label
  pinctrl: mcp23s08: spi: Fix duplicate pinctrl debugfs entries

 .../bindings/pinctrl/pinctrl-mcp23s08.txt          |   4 +
 drivers/pinctrl/core.c                             |  18 ++-
 drivers/pinctrl/pinctrl-mcp23s08.c                 | 131 +++++++++++++++------
 3 files changed, 114 insertions(+), 39 deletions(-)

-- 
2.14.3


