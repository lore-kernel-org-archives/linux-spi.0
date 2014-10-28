From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 0/2] spi: dw-mid: fix simplex DMA transfers
Date: Tue, 28 Oct 2014 18:25:00 +0200
Message-ID: <1414513502-595-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In current shape the driver relies on both TX and RX transfers when DMA is
enabled. In case of simplex transfer the driver will stuck, since call back
function will never achieve the proper condition to finish the transfer.

This patchset fixes the potential issue.

Andy Shevchenko (2):
  spi: dw-mid: refactor to use helpers
  spi: dw-mid: split rx and tx callbacks when DMA

 drivers/spi/spi-dw-mid.c | 114 ++++++++++++++++++++++++++++++++++-------------
 drivers/spi/spi-dw.h     |   2 +-
 2 files changed, 84 insertions(+), 32 deletions(-)

-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
