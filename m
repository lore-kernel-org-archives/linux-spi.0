From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback: fix printk format issues with size_t" to the spi tree
Date: Sun, 13 Dec 2015 20:10:36 +0000
Message-ID: <E1a8Cya-0004CB-P8@debutante>
References: <1449999775-2245-1-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449999775-2245-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback: fix printk format issues with size_t

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

>From d58b9fda129d7f75358a36b71ec5cc685b4f993e Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Sun, 13 Dec 2015 09:42:55 +0000
Subject: [PATCH] spi: loopback: fix printk format issues with size_t

Fixes the reported printk format issues reported by kbuild-test-robot.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index db207362e831..4481ac766029 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -345,7 +345,7 @@ static void spi_test_print_hex_dump(char *pre, const void *ptr, size_t len)
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       ptr, 512, 0);
 	/* print tail */
-	pr_info("%s truncated - continuing at offset %04x\n",
+	pr_info("%s truncated - continuing at offset %04zx\n",
 		pre, len - 512);
 	print_hex_dump(KERN_INFO, pre,
 		       DUMP_PREFIX_OFFSET, 16, 1,
@@ -525,7 +525,7 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 
 mismatch_error:
 	dev_err(&spi->dev,
-		"loopback strangeness - transfer missmatch on byte %04x - expected 0x%02x, but got 0x%02x\n",
+		"loopback strangeness - transfer missmatch on byte %04zx - expected 0x%02x, but got 0x%02x\n",
 		i, txb, rxb);
 
 	return -EINVAL;
@@ -777,7 +777,7 @@ static int spi_test_run_iter(struct spi_device *spi,
 		dev_info(&spi->dev, "Running test %s\n", test.description);
 	} else {
 		dev_info(&spi->dev,
-			 "  with iteration values: len = %i, tx_off = %i, rx_off = %i\n",
+			 "  with iteration values: len = %zu, tx_off = %zu, rx_off = %zu\n",
 			 len, tx_off, rx_off);
 	}
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
