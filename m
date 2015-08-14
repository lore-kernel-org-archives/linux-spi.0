From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm2835: fix overflow in calculation of transfer time" to the spi tree
Date: Fri, 14 Aug 2015 01:01:06 +0100
Message-ID: <E1ZQ2Qk-0003PP-7H@finisterre>
References: <1438155250-14476-1-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438155250-14476-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm2835: fix overflow in calculation of transfer time

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

>From 0122a5183088e3117bb9c8fbe248914efb502f3f Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Wed, 29 Jul 2015 07:34:10 +0000
Subject: [PATCH] spi: bcm2835: fix overflow in calculation of transfer time

This resulted in the use of polling mode when other approaches
(dma or interrupts) would have been more appropriate.

Happened for transfers longer than 477 bytes.

Reported-by: Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index c9357bb..e7874a6 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -480,7 +480,7 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					 struct spi_device *spi,
 					 struct spi_transfer *tfr,
 					 u32 cs,
-					 unsigned long xfer_time_us)
+					 unsigned long long xfer_time_us)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;
@@ -531,7 +531,8 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, cdiv;
-	unsigned long spi_used_hz, xfer_time_us;
+	unsigned long spi_used_hz;
+	unsigned long long xfer_time_us;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/* set clock */
@@ -573,9 +574,10 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	bs->rx_len = tfr->len;
 
 	/* calculate the estimated time in us the transfer runs */
-	xfer_time_us = tfr->len
+	xfer_time_us = (unsigned long long)tfr->len
 		* 9 /* clocks/byte - SPI-HW waits 1 clock after each byte */
-		* 1000000 / spi_used_hz;
+		* 1000000;
+	do_div(xfer_time_us, spi_used_hz);
 
 	/* for short requests run polling*/
 	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US)
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
