From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 0/5] spi: dw: refactor to use SPI core message handling
Date: Tue, 24 Feb 2015 13:32:09 +0200
Message-ID: <1424777534-14246-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch series is dedicated to refactoring of spi-dw driver to use SPI core
message handling. The driver has been tested in PIO mode on Intel Medfield
device in loopback mode.

Andy Shevchenko (5):
  spi: dw: move piece of code out of condition
  spi: dw: get TX level without an additional variable
  spi: dw: refactor code that handles clk_div
  spi: dw: always reprogram CTRL0
  spi: dw: move to SPI core message handling

 drivers/spi/spi-dw-mid.c |   4 +-
 drivers/spi/spi-dw.c     | 208 ++++++++++++-----------------------------------
 drivers/spi/spi-dw.h     |  22 -----
 3 files changed, 55 insertions(+), 179 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
