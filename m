From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 0/2] spi: dw: bug fix and clean up series
Date: Tue, 20 Oct 2015 12:11:39 +0300
Message-ID: <1445332301-15126-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The first patch is a regression fix, second one a little fix(no need to
backport). The rest, that has been already applied, is clean up part, in
particularly follow up to what previously Jarkko started.

The driver has been tested on Intel MID platform in DMA and PIO modes.

Changelog v3:
- send with cover letter
- call free_irq() at the end of removal to keep the same flow we have at error
  path

Changelog v2:
- drop applied patches
- address Mark's comment regarding to free IRQ

Andy Shevchenko (2):
  spi: dw: explicitly free IRQ handler in dw_spi_remove_host()
  spi: dw: remove a NULL check when call ->remove()

 drivers/spi/spi-dw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
