From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/3] Some fixes for slave-dma stuff for spi-rockchip
Date: Wed,  9 Mar 2016 16:10:43 +0800
Message-ID: <1457511043-2058-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


This patchset mainly do the following three things:
(1) Defer probing driver when geting EPROBE_DEFER
(2) Check the return value of dmaengine_prep_slave_sg
(3) Migrate dmaengine_terminate_all to dmaengine_terminate_async



Shawn Lin (3):
  spi: rockchip: check return value of dmaengine_prep_slave_sg
  spi: rockchip: migrate to dmaengine_terminate_async
  spi: rockchip: check requesting dma channel with EPROBE_DEFER

 drivers/spi/spi-rockchip.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
