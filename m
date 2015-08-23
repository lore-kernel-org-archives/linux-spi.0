From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] spi: fsl-(e)spi: Migrate to devm_ functions and add runtime
 PM
Date: Sun, 23 Aug 2015 14:19:39 +0200
Message-ID: <55D9BA5B.9080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

fsl-espi tested on a TP-Link TL-WDR4900 WLAN router (P1014 based).
fsl-spi compile-tested only.

Heiner Kallweit (3):
  spi: fsl-(e)spi: migrate to using devm_ functions to simplify cleanup
  spi: fsl-(e)spi: simplify cleanup code
  spi: fsl-espi: add runtime PM

 drivers/spi/spi-fsl-espi.c | 86 +++++++++++++++++++++++++++++-----------------
 drivers/spi/spi-fsl-lib.c  | 19 ----------
 drivers/spi/spi-fsl-lib.h  |  3 --
 drivers/spi/spi-fsl-spi.c  | 40 +++++++++------------
 4 files changed, 70 insertions(+), 78 deletions(-)

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
