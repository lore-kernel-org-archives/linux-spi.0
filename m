From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/7] spi: remove unnecessary OOM messages
Date: Tue, 29 Apr 2014 17:17:43 +0900
Message-ID: <002401cf6383$7e9ce1f0$7bd6a5d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. For example,
k.alloc and v.alloc failures use dump_stack().

Jingoo Han (7):
      spi: pl022: remove unnecessary OOM messages
      spi: pxa2xx: remove unnecessary OOM messages
      spi: s3c24xx: remove unnecessary OOM messages
      spi: s3c64xx: remove unnecessary OOM messages
      spi: sh-msiof: remove unnecessary OOM messages
      spi: tle62x0: remove unnecessary OOM messages
      spi: topcliff-pch: remove unnecessary OOM messages

---
 drivers/spi/spi-pl022.c        |   13 +++----------
 drivers/spi/spi-pxa2xx.c       |   10 ++--------
 drivers/spi/spi-s3c24xx.c      |    4 +---
 drivers/spi/spi-s3c64xx.c      |    5 +----
 drivers/spi/spi-sh-msiof.c     |    4 +---
 drivers/spi/spi-tle62x0.c      |    4 +---
 drivers/spi/spi-topcliff-pch.c |    5 +----
 7 files changed, 10 insertions(+), 35 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
