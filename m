From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/3] SPI Fixes for spi-rockchip
Date: Wed,  3 Sep 2014 13:44:24 -0700
Message-ID: <1409777067-17422-1-git-send-email-dianders@chromium.org>
Cc: Alexandru Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

These three patches are random SPI fixes for spi-rockchip.  They are
unrelated and can be applied / NAKed separately.  They've been tested
in PIO mode on an rk3288 board (since SPI DMA isn't currently working
for some unknown reason).


Doug Anderson (3):
  spi/rockchip: Fix the wait_for_idle() timeout
  spi/rockchip: Don't warn if SPI is busy but disabled
  dt-bindings: spi/rockchip: Mark DMA as optional

 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 8 ++++++--
 drivers/spi/spi-rockchip.c                             | 5 +++--
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
