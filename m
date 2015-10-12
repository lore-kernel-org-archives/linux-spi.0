From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [RFC] spi: Switch call order of spi master setup and spi_set_cs
Date: Mon, 12 Oct 2015 16:01:10 -0500
Message-ID: <1444683671-15570-1-git-send-email-fcooper@ti.com>
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, m-karicheri2-l0cyMroinI0@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Keystone 2 devices currently fail to boot in linux-next after the
below commit was applied:

spi: bitbang: switch to the generic implementation of transfer_one_message
commit: 0037686596832572bbca05ab168d9884d7d704c1

This patch allows Keystone 2 devices to boot again in linux-next.

Tested this patch on K2E evm and am437 starterkit which both have SPI
devices to insure regressions aren't seen.


Franklin S Cooper Jr (1):
  spi: Setup the master controller driver before setting the chipselect

 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
