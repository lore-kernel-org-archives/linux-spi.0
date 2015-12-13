From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback: added additional non-power of 2 transfer lengthes" to the spi tree
Date: Sun, 13 Dec 2015 20:10:34 +0000
Message-ID: <E1a8CyY-0004BF-T9@debutante>
References: <1449999986-2335-1-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449999986-2335-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback: added additional non-power of 2 transfer lengthes

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

>From 739f3e92916b6076afbfc3b524ec120468478035 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Sun, 13 Dec 2015 09:46:25 +0000
Subject: [PATCH] spi: loopback: added additional non-power of 2 transfer
 lengthes

Added additional transfer length to test that are not a power of 2.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-test.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-test.h b/drivers/spi/spi-test.h
index 7bfdbe24cf7e..922c52833239 100644
--- a/drivers/spi/spi-test.h
+++ b/drivers/spi/spi-test.h
@@ -20,7 +20,7 @@
 
 #define SPI_TEST_MAX_TRANSFERS 4
 #define SPI_TEST_MAX_SIZE (32 * PAGE_SIZE)
-#define SPI_TEST_MAX_ITERATE 16
+#define SPI_TEST_MAX_ITERATE 32
 
 /* the "dummy" start addresses used in spi_test
  * these addresses get translated at a later stage
@@ -127,9 +127,10 @@ int spi_test_run_tests(struct spi_device *spi,
 		       struct spi_test *tests);
 
 /* some of the default @spi_transfer.len to test */
-#define ITERATE_LEN 16, 32, 64, 128, 256, 1024, PAGE_SIZE, 65536
+#define ITERATE_LEN 2, 3, 7, 11, 16, 31, 32, 64, 97, 128, 251, 256, \
+		1021, 1024, 1031, 4093, PAGE_SIZE, 4099, 65536, 65537
 
-#define ITERATE_MAX_LEN ITERATE_LEN, SPI_TEST_MAX_SIZE
+#define ITERATE_MAX_LEN ITERATE_LEN, SPI_TEST_MAX_SIZE - 1, SPI_TEST_MAX_SIZE
 
 /* the default alignment to test */
 #define ITERATE_ALIGN sizeof(int)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
