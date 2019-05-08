From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm2835: bcm2835_spi_transfer_one_poll remove
 unnecessary argument" to the spi tree
Date: Wed,  8 May 2019 10:08:56 +0100 (BST)
Message-ID: <20190508090856.7596B440010@finisterre.sirena.org.uk>
References: <20190423201513.8073-2-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190423201513.8073-2-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm2835: bcm2835_spi_transfer_one_poll remove unnecessary argument

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From 9ac3f90db46b7805a37df2bc419faf369025d64a Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Tue, 23 Apr 2019 20:15:08 +0000
Subject: [PATCH] spi: bcm2835: bcm2835_spi_transfer_one_poll remove
 unnecessary argument

Remove the unnecessary argument of xfer_time_us when calling
bcm2835_spi_transfer_one_poll.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 8aa22713c483..6c73e694794a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -697,8 +697,7 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					 struct spi_device *spi,
 					 struct spi_transfer *tfr,
-					 u32 cs,
-					 unsigned long long xfer_time_us)
+					 u32 cs)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;
@@ -799,8 +798,7 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 
 	/* for short requests run polling*/
 	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US)
-		return bcm2835_spi_transfer_one_poll(master, spi, tfr,
-						     cs, xfer_time_us);
+		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);
 
 	/* run in dma mode if conditions are right */
 	if (master->can_dma && bcm2835_spi_can_dma(master, spi, tfr))
-- 
2.20.1
