From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: write rx pattern also when running without tx_buf" to the spi tree
Date: Tue, 05 Jan 2016 19:06:44 +0000
Message-ID: <E1aGWwO-00053i-3l@debutante>
References: <1450698772-2379-2-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450698772-2379-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: write rx pattern also when running without tx_buf

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

>From e6520a3c8877d02c471135afb371e79b04409ab8 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Tue, 22 Dec 2015 18:03:21 +0000
Subject: [PATCH] spi: loopback-test: write rx pattern also when running
 without tx_buf

Currently the rx_buf does not get set with the
SPI_TEST_PATTERN_UNWRITTEN when tx_buf == NULL in the transfer.

Reorder code so that it gets done also under this specific condition.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 7f497acc906c..8af2e4070153 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -591,6 +591,10 @@ static int spi_test_fill_tx(struct spi_device *spi, struct spi_test *test)
 
 	/* fill all transfers with the pattern requested */
 	for (i = 0; i < test->transfer_count; i++) {
+		/* fill rx_buf with SPI_TEST_PATTERN_UNWRITTEN */
+		if (xfers[i].rx_buf)
+			memset(xfers[i].rx_buf, SPI_TEST_PATTERN_UNWRITTEN,
+			       xfers[i].len);
 		/* if tx_buf is NULL then skip */
 		tx_buf = (u8 *)xfers[i].tx_buf;
 		if (!tx_buf)
@@ -648,10 +652,6 @@ static int spi_test_fill_tx(struct spi_device *spi, struct spi_test *test)
 				return -EINVAL;
 			}
 		}
-		/* fill rx_buf with SPI_TEST_PATTERN_UNWRITTEN */
-		if (xfers[i].rx_buf)
-			memset(xfers[i].rx_buf, SPI_TEST_PATTERN_UNWRITTEN,
-			       xfers[i].len);
 	}
 
 	return 0;
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
