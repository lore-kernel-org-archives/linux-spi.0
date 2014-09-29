From: Weike Chen <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2 v2] SPI: spi-pxa2xx: Add support for Intel Quark X1000 SPI controller
Date: Mon, 29 Sep 2014 07:22:26 -0700
Message-ID: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Hock Leong Kweh <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Boon Leong Ong <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Raymond Tan <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Alvin Chen <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,
Intel Quark X1000 consists of two SPI controllers which can be PCI enumerated.
SPI-PXA2XX PCI layer doesn't support it. Thus, we add support for Intel Quark
X1000 SPI as well.

---
v2:
  Split into two patches: one is for helper functions,
  and another is for quark supporting.

[PATCH 1/2]
* Add helper functions to access registers.
* Use 'switch' instead of 'if-else'.
[PATCH 2/2]
* Use 'switch' instead of 'if-else'.
* Add comments for the 'dds'&'clk_div' caculation.
* A couple of minor fixes.

Weike Chen (2):
  SPI: spi-pxa2xx: Add helpers for regiseters' accessing
  SPI: spi-pxa2xx: SPI support for Intel Quark X1000

 drivers/spi/spi-pxa2xx-pci.c |    8 ++
 drivers/spi/spi-pxa2xx.c     |  306 ++++++++++++++++++++++++++++++++++++------
 drivers/spi/spi-pxa2xx.h     |   16 ++-
 include/linux/pxa2xx_ssp.h   |   21 +++
 4 files changed, 306 insertions(+), 45 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
