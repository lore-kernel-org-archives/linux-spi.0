From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 0/5] spi: dw-pci: cleanup the driver
Date: Fri, 29 Aug 2014 12:41:38 +0300
Message-ID: <1409305303-32631-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This set of small clean ups of the driver.

Changelog v3:
- rebase on top of recent linux-next keeping in mind NAck of "spi: dw-mid:
  don't leak memory on exit"

Changelog v2:
- add patch 4/5

Andy Shevchenko (5):
  spi: dw-pci: move info message at the end of probe
  spi: dw-pci: apply pci_bar and re-use pci_name
  spi: dw-pci: convert to use dev_pm_ops
  spi: dw-pci: provide platform specific data via driver_data
  spi: dw-pci: remove FSF address and update copyright

 drivers/spi/spi-dw-pci.c | 67 ++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
