From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bcm2835: fix overflow in calculation of transfer time
Date: Wed, 29 Jul 2015 07:34:10 +0000
Message-ID: <1438155250-14476-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This resulted in the use of polling mode when other approaches
(dma or interrupts) would have been more appropriate.

Happened for transfers longer than 477 bytes.

Reported-by: Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   10 ++++++----
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
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
