From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: spi_check_rx_ranges can get always done" to the spi tree
Date: Tue, 05 Jan 2016 19:15:26 +0000
Message-ID: <E1aGX4o-0005fF-Oq@debutante>
References: <1450698772-2379-6-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450698772-2379-6-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: spi_check_rx_ranges can get always done

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

>From 1e8db97f0e5205c0f6fd20c9a4f38cd871bc467f Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Tue, 22 Dec 2015 18:03:25 +0000
Subject: [PATCH] spi: loopback-test: spi_check_rx_ranges can get always done

The spi_check_rx_ranges can always get executed independent of
if we have a real loopback situation.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 81fa9068df43..7f79a77c4b68 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -489,7 +489,18 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 	struct spi_transfer *xfer;
 	u8 rxb, txb;
 	size_t i;
+	int ret;
+
+	/* checks rx_buffer pattern are valid with loopback or without */
+	ret = spi_check_rx_ranges(spi, msg, rx);
+	if (ret)
+		return ret;
 
+	/* if we run without loopback, then return now */
+	if (!loopback)
+		return 0;
+
+	/* if applicable to transfer check that rx_buf is equal to tx_buf */
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* if there is no rx, then no check is needed */
 		if (!xfer->rx_buf)
@@ -521,7 +532,7 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 		}
 	}
 
-	return spi_check_rx_ranges(spi, msg, rx);
+	return 0;
 
 mismatch_error:
 	dev_err(&spi->dev,
@@ -847,10 +858,8 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 			goto exit;
 		}
 
-		/* run rx-tests when in loopback mode */
-		if (loopback)
-			ret = spi_test_check_loopback_result(spi, msg,
-							     tx, rx);
+		/* run rx-buffer tests */
+		ret = spi_test_check_loopback_result(spi, msg, tx, rx);
 	}
 
 	/* if requested or on error dump message (including data) */
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
