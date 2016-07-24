From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pic32: fixup wait_for_completion_timeout return handling" to the spi tree
Date: Sun, 24 Jul 2016 22:06:54 +0100
Message-ID: <E1bRQbu-0004D9-Cr@debutante>
References: <1469302280-32461-1-git-send-email-hofrat@osadl.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469302280-32461-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pic32: fixup wait_for_completion_timeout return handling

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

>From 57c2b0ddd14d8831cbaab855373fe8797812ea53 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Date: Sat, 23 Jul 2016 21:31:20 +0200
Subject: [PATCH] spi: pic32: fixup wait_for_completion_timeout return handling

wait_for_completion_timeout returns unsigned long not int so the check for
<= 0 should be == 0 here.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pic32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 73db87f805a1..fefb688a3432 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -507,6 +507,7 @@ static int pic32_spi_one_transfer(struct spi_master *master,
 {
 	struct pic32_spi *pic32s;
 	bool dma_issued = false;
+	unsigned long timeout;
 	int ret;
 
 	pic32s = spi_master_get_devdata(master);
@@ -553,8 +554,8 @@ static int pic32_spi_one_transfer(struct spi_master *master,
 	}
 
 	/* wait for completion */
-	ret = wait_for_completion_timeout(&pic32s->xfer_done, 2 * HZ);
-	if (ret <= 0) {
+	timeout = wait_for_completion_timeout(&pic32s->xfer_done, 2 * HZ);
+	if (timeout == 0) {
 		dev_err(&spi->dev, "wait error/timedout\n");
 		if (dma_issued) {
 			dmaengine_terminate_all(master->dma_rx);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
