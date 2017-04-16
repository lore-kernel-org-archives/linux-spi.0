From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH] spi: double time out tolerance
Date: Mon, 17 Apr 2017 01:38:05 +0200
Message-ID: <20170416233805.15973-1-hauke@hauke-m.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The generic SPI code calculates how long the issued transfer would take
and adds 100ms in addition to the timeout as tolerance. On my 500 MHz
Lantiq Mips SoC I am getting timeouts from the SPI like this when the
system boots up:

m25p80 spi32766.4: SPI transfer timed out
blk_update_request: I/O error, dev mtdblock3, sector 2
SQUASHFS error: squashfs_read_data failed to read block 0x6e

After increasing the tolerance for the timeout to 200ms I haven't seen
these SPI transfer time outs any more.
The Lantiq SPI driver in use here has an extra work queue in between,
which gets triggered when the controller send the last word and the
hardware FIFOs used for reading and writing are only 8 words long.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 90b5b2efafbf..b4a8bb7759b2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1015,7 +1015,7 @@ static int spi_transfer_one_message(struct spi_master *master,
 				ret = 0;
 				ms = 8LL * 1000LL * xfer->len;
 				do_div(ms, xfer->speed_hz);
-				ms += ms + 100; /* some tolerance */
+				ms += ms + 200; /* some tolerance */
 
 				if (ms > UINT_MAX)
 					ms = UINT_MAX;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
