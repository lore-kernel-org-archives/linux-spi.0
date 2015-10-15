From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi: Setup the master controller driver before setting the chipselect
Date: Thu, 15 Oct 2015 15:51:45 -0500
Message-ID: <1444942305-24038-1-git-send-email-fcooper@ti.com>
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, m-karicheri2-l0cyMroinI0@public.gmane.org, iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some devices depend on the master controller driver setup function being
called before calling any chipselect functions.

Insure that this is done otherwise uninitialized structures may be
accessed causing a kernel panic.

Tested-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
---
Keystone 2 devices currently fail to boot in linux-next after the
below commit was applied:

spi: bitbang: switch to the generic implementation of transfer_one_message
commit: 0037686596832572bbca05ab168d9884d7d704c1

This patch allows Keystone 2 devices to boot again in linux-next.

Tested this patch on K2E evm and am437 starterkit which both have SPI
devices to insure regressions aren't seen.

 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4c638f3..9d5525a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2059,11 +2059,11 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz = spi->master->max_speed_hz;
 
-	spi_set_cs(spi, false);
-
 	if (spi->master->setup)
 		status = spi->master->setup(spi);
 
+	spi_set_cs(spi, false);
+
 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
