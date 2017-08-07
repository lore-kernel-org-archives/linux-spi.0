From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/3] Fix clock handling in rockchip spi suspend/resume/remove
Date: Mon,  7 Aug 2017 20:40:17 +0800
Message-ID: <1502109620-26813-1-git-send-email-jeffy.chen@rock-chips.com>
Cc: briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org,
        Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


I saw unpaired spi clock disable warnings when suspend/unbind spi device.
Fix them follow spi-s3c64xx.c.



Jeffy Chen (3):
  spi: rockchip: Slightly rework return value handling
  spi: rockchip: Fix clock handling in remove
  spi: rockchip: Fix clock handling in suspend/resume

 drivers/spi/spi-rockchip.c | 51 +++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

-- 
2.1.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
