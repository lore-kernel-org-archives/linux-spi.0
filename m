From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 00/10] spi: dw: bug fix and clean up series
Date: Wed, 14 Oct 2015 23:12:15 +0300
Message-ID: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The first patch is a regression fix, second one a little fix(no need to
backport). The rest is clean up part, in particularly follow up to what
previously Jarkko started.

The driver has been tested on Intel MID platform in DMA and PIO modes.

Andy Shevchenko (10):
  spi: dw: explicitly free IRQ handler in dw_spi_remove_host()
  spi: dw: use plain struct device * at earlier ->probe()
  spi: dw: remove unneeded cr0 member of struct chip_data
  spi: dw: remove a NULL check when call ->remove()
  spi: dw: remove bits_per_word member of struct chip_data
  spi: dw: eliminate speed variable in ->transfer_one()
  spi: dw: eliminate unused threshold variables
  spi: dw: introduce spi_shutdown_chip()
  spi: dw-pci: remove unused pdev member from struct dw_spi_pci
  spi: dw-mmio: convert to unified device property API

 drivers/spi/spi-dw-mmio.c |  7 +++--
 drivers/spi/spi-dw-pci.c  | 29 +++++++-------------
 drivers/spi/spi-dw.c      | 68 +++++++++++++----------------------------------
 drivers/spi/spi-dw.h      |  6 +++++
 4 files changed, 37 insertions(+), 73 deletions(-)

-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
