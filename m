From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 0/3] spi: dw: refactor to use SPI core message handling
Date: Fri, 27 Feb 2015 18:36:14 +0200
Message-ID: <1425054977-9859-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch series is dedicated to refactoring of spi-dw driver to use SPI core
message handling. The driver has been tested in PIO mode on Intel Medfield
device in loopback mode.

Note, the patch 3/3 depends on [1].

[1] http://www.spinics.net/lists/linux-spi/msg02982.html

Changelog v3:
- introduce patch 1/3 and 2/3 to make state of the SPI controller consistent
- return 1 instead of transfer length from transfer_one()
- use newly introduced handle_err()

Changelog v2:
- remove leftovers from spi-dw.h
- remove unused members of dw_spi, i.e. cur_dev, max_bits_per_word
- reuse chip->cs_control directly

Andy Shevchenko (3):
  spi: dw: make sure SPI controller is enabled
  spi: dw: program registers as soon as possible
  spi: dw: move to SPI core message handling

 drivers/spi/spi-dw-mid.c |   4 +-
 drivers/spi/spi-dw.c     | 236 +++++++++++++++--------------------------------
 drivers/spi/spi-dw.h     |  26 ------
 3 files changed, 77 insertions(+), 189 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
