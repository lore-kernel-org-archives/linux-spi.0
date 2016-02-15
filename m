From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/3] Some rockchip_spi fixes and debug support
Date: Mon, 15 Feb 2016 16:27:28 +0800
Message-ID: <1455524848-2646-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


This patchset fix some missing err handles of rockchip_spi.
And it also add debugfs support for rockchip_spi in order to trace
the driver's and controller's state.



Shawn Lin (3):
  spi: rockchip: disable runtime pm when in err case
  spi: rockchip: add missing spi_master_put
  spi: rockchip: add debug interface support

 drivers/spi/spi-rockchip.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
