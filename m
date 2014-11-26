From: Weike Chen <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2 v4] SPI: spi-pxa2xx: Add support for Intel Quark X1000 SPI controller
Date: Wed, 26 Nov 2014 02:35:08 -0800
Message-ID: <1416998110-4856-1-git-send-email-alvin.chen@intel.com>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Boon Leong Ong <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Hock Leong Kweh <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Alvin Chen <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,
Intel Quark X1000 consists of two SPI controllers which can be PCI enumerated.
SPI-PXA2XX PCI layer doesn't support it. Thus, we add support for Intel Quark
X1000 SPI as well.

---
v4:
[PATCH 1/2]
* No changes.
[PATCH 2/2]
* Move all Quark specific macros out of #ifdef 'CONFIG_ARCH_PXA'.

v3:
[PATCH 1/2]
* Improve the commit message.
* A couple of minor fixes.
[PATCH 2/2]
* Set '.num_chipselect' to '1' instead of '4'.
* A couple of minor fixes.

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
 drivers/spi/spi-pxa2xx.c     |  304 ++++++++++++++++++++++++++++++++++++------
 drivers/spi/spi-pxa2xx.h     |   16 ++-
 include/linux/pxa2xx_ssp.h   |   20 +++
 4 files changed, 303 insertions(+), 45 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
