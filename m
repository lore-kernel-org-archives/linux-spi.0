From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fix counting in spi-loopback-test code" to the spi tree
Date: Fri, 15 Jan 2016 18:19:16 +0000
Message-ID: <E1aK8xw-0005Yx-1g@debutante>
References: <7416604.jejCLcpcOT@wuerfel>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7416604.jejCLcpcOT@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fix counting in spi-loopback-test code

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

>From ebea7c0545d4d5e554b84c3ee8072f13c3fdd2ba Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Date: Wed, 13 Jan 2016 21:51:29 +0100
Subject: [PATCH] spi: fix counting in spi-loopback-test code

These variables are always used uninitialized:

drivers/spi/spi-loopback-test.c: In function 'spi_test_run_iter':
drivers/spi/spi-loopback-test.c:768:17: warning: 'rx_count' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/spi/spi-loopback-test.c:762:17: warning: 'tx_count' may be used uninitialized in this function [-Wmaybe-uninitialized]

Adding an explicit initialization seems to be the only
workable solution here, to make the code behave correctly
and build without warning.

Fixes: 84e0c4e5e2c4 ("spi: add loopback test driver to allow for spi_master regression tests")
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Acked-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 894616f687b0..cf4bb36bee25 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -761,6 +761,7 @@ static int spi_test_run_iter(struct spi_device *spi,
 		test.iterate_transfer_mask = 1;
 
 	/* count number of transfers with tx/rx_buf != NULL */
+	rx_count = tx_count = 0;
 	for (i = 0; i < test.transfer_count; i++) {
 		if (test.transfers[i].tx_buf)
 			tx_count++;
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
