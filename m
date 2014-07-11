From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/4] patches for rockchip spi driver
Date: Fri, 11 Jul 2014 10:06:29 +0800
Message-ID: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Addy Ke <addy.ke-JkTZp4/KTbpWk0Htik3J/w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Addy Ke <addy.ke-JkTZp4/KTbpWk0Htik3J/w@public.gmane.org>

These patches based on:
- git: kernel/git/broonie/spi.git
- branch: topic/rockchip
- commit: c15369087ae5c7db7f3e3604822eac6ab87429bd

Addy Ke (4):
  spi/rockchip: cleanup some coding issues and uncessary output
  spi/rockchip: call wait_for_idle() for the transfer to complete
  spi/rockchip: master->mode_bits: remove SPI_CS_HIGH bit
  spi/rockchip: add compatible strings for RK3188 and RK3288

 drivers/spi/spi-rockchip.c | 74 ++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 29 deletions(-)

-- 
1.8.3.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
