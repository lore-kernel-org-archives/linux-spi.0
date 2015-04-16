From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bcm2835: change timeout of polling driver to 1s
Date: Thu, 16 Apr 2015 07:51:26 +0000
Message-ID: <1429170693-1718-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

The way that the timeout code is written in the polling function
the timeout does also trigger when interrupted or rescheduled while
in the polling loop.

This patch changes the timeout from effectively 20ms (=2 jiffies) to
1 second and removes the time that the transfer really takes out of
the computation, as - per design - this is <30us and the jiffie resolution
is 10ms so that does not make any difference what so ever.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

---
 drivers/spi/spi-bcm2835.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

This is an alternative to:
[PATCH] spi: bcm2835: remove timeout code from polling function
that totally removes the timeout.

Where Mark has some concerns when runnig without a timeout

Test have also been done totally removing the timeout code and the result
was that 2.5B SPI messages got transferred without any issues. So in
principle even that would work...

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index f63864a..0323439 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -164,13 +164,12 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					 unsigned long xfer_time_us)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	unsigned long timeout = jiffies +
-		max(4 * xfer_time_us * HZ / 1000000, 2uL);
+	/* set timeout to 1 second of maximum polling */
+	unsigned long timeout = jiffies + HZ;

 	/* enable HW block without interrupts */
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_TA);

-	/* set timeout to 4x the expected time, or 2 jiffies */
 	/* loop until finished the transfer */
 	while (bs->rx_len) {
 		/* read from fifo as much as possible */
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
