From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 0/6] spi: dw: various clean ups and a bug fix
Date: Fri, 12 Sep 2014 15:11:55 +0300
Message-ID: <1410523921-16732-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is a set of few clean ups and one bug fix in the dw spi driver.

Andy Shevchenko (6):
  spi: dw: don't use mrst prefix anymore
  spi: dw: remove FSF address
  spi: dw-mid: check that DMA was inited before exit
  spi: dw-mid: remove Moorestown support
  spi: dw-mid: remove redundant dmac member
  spi: dw-mid: remove FSF address and update copyright

 drivers/spi/Kconfig      |  2 +-
 drivers/spi/spi-dw-mid.c | 26 +++++++++++++-------------
 drivers/spi/spi-dw.c     | 36 +++++++++++++++---------------------
 drivers/spi/spi-dw.h     |  7 +++----
 4 files changed, 32 insertions(+), 39 deletions(-)

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
