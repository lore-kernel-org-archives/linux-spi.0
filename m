From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sun6i: update max transfer size reported" to the spi tree
Date: Tue, 21 Mar 2017 18:46:11 +0000
Message-ID: <E1cqOnL-0001IG-NE@debutante>
Cc: Martin Ayotte <martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sun6i: update max transfer size reported

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

>From 3288d5cb40c09213e86d67b5cab09de1deb65a5c Mon Sep 17 00:00:00 2001
From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Date: Mon, 20 Mar 2017 22:38:49 +0800
Subject: [PATCH] spi: sun6i: update max transfer size reported

The spi-sun6i driver have already got the ability to do large transfers.
However, the max transfer size reported is still fifo depth - 1.

Update the max transfer size reported to the max value possible.

Reported-by: Martin Ayotte <martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sun6i.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 6e9ca93db9bf..03a773a9531a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -194,9 +194,7 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
-
-	return sspi->fifo_depth - 1;
+	return SUN6I_MAX_XFER_SIZE - 1;
 }
 
 static int sun6i_spi_transfer_one(struct spi_master *master,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
