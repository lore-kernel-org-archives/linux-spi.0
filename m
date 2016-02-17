From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: core: Use min_t(size_t,..)" to the spi tree
Date: Wed, 17 Feb 2016 19:18:28 +0000
Message-ID: <E1aW7cK-0002oc-5l@debutante>
References: <1455730948-24938-2-git-send-email-fabio.estevam@nxp.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455730948-24938-2-git-send-email-fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: core: Use min_t(size_t,..)

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

>From c8dab77a1f92095674e4d7fcb151cac4630e10f9 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Date: Wed, 17 Feb 2016 15:42:28 -0200
Subject: [PATCH] spi: core: Use min_t(size_t,..)

Use min_t(size_t,..) in order to avoid the following
build warning on ARM64:

include/linux/kernel.h:754:17: warning: comparison of distinct pointer types lacks a cast
  (void) (&_min1 == &_min2);  \
                 ^
drivers/spi/spi.c:2304:17: note: in expansion of macro 'min'
  xfers[0].len = min(maxsize, xfer[0].len);

Suggested-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Acked-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9ae199db171b..390d9ee937b6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2279,7 +2279,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
 	/* the first transfer just needs the length modified, so we
 	 * run it outside the loop
 	 */
-	xfers[0].len = min(maxsize, xfer[0].len);
+	xfers[0].len = min_t(size_t, maxsize, xfer[0].len);
 
 	/* all the others need rx_buf/tx_buf also set */
 	for (i = 1, offset = maxsize; i < count; offset += maxsize, i++) {
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
