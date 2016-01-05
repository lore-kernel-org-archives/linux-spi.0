From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: rename method spi_test_fill_tx to spi_test_fill_pattern" to the spi tree
Date: Tue, 05 Jan 2016 19:06:43 +0000
Message-ID: <E1aGWwN-00053F-6u@debutante>
References: <1450698772-2379-3-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450698772-2379-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: rename method spi_test_fill_tx to spi_test_fill_pattern

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

>From 339ec3ce54e5c7137287dc807555ae69934b2d2a Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Tue, 22 Dec 2015 18:03:22 +0000
Subject: [PATCH] spi: loopback-test: rename method spi_test_fill_tx to
 spi_test_fill_pattern

Rename method spi_test_fill_tx to spi_test_fill_pattern
to better describe what it does.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 8af2e4070153..81fa9068df43 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -574,7 +574,8 @@ static int spi_test_translate(struct spi_device *spi,
 	return -EINVAL;
 }
 
-static int spi_test_fill_tx(struct spi_device *spi, struct spi_test *test)
+static int spi_test_fill_pattern(struct spi_device *spi,
+				 struct spi_test *test)
 {
 	struct spi_transfer *xfers = test->transfers;
 	u8 *tx_buf;
@@ -691,8 +692,8 @@ static int _spi_test_run_iter(struct spi_device *spi,
 		spi_message_add_tail(x, msg);
 	}
 
-	/* fill in the transfer data */
-	ret = spi_test_fill_tx(spi, test);
+	/* fill in the transfer buffers with pattern */
+	ret = spi_test_fill_pattern(spi, test);
 	if (ret)
 		return ret;
 
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
