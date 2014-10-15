From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/2] spi: fix two bugs
Date: Wed, 15 Oct 2014 19:25:11 +0800
Message-ID: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, amstan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
	sonnyrao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Patch 1: fix bug that case spi can't go as fast as slave request
Patch 2: fix bug that cause spi transfer timed out in DMA duplex mode

Tested on rk3288-pinky-version2 board.

Addy Ke (2):
  spi/rockchip: fix bug that case spi can't go as fast as slave request
  spi/rockchip: fix bug that cause spi transfer timed out in DMA duplex
    mode

 drivers/spi/spi-rockchip.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

-- 
1.8.3.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
