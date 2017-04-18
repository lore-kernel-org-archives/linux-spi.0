From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: double time out tolerance" to the spi tree
Date: Tue, 18 Apr 2017 19:00:27 +0100
Message-ID: <E1d0XQR-0007MV-8c@debutante>
References: <20170416233805.15973-1-hauke@hauke-m.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170416233805.15973-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: double time out tolerance

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 833bfade96561216aa2129516a5926a0326860a2 Mon Sep 17 00:00:00 2001
From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Date: Mon, 17 Apr 2017 01:38:05 +0200
Subject: [PATCH] spi: double time out tolerance

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e3220c..0af62c6f93a8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1012,7 +1012,7 @@ static int spi_transfer_one_message(struct spi_master *master,
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
