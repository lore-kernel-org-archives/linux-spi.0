From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap-uwire: Remove needless bits_per_word and speed_hz tests" to the spi tree
Date: Thu, 17 Sep 2015 18:37:11 +0100
Message-ID: <E1Zcd7P-0006Wy-Eh@finisterre>
References: <1442323588-29642-8-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-8-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: omap-uwire: Remove needless bits_per_word and speed_hz tests

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

>From 160f8d0691659b65a97494c151c95b1287c377ae Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 15 Sep 2015 16:26:20 +0300
Subject: [PATCH] spi: omap-uwire: Remove needless bits_per_word and speed_hz
 tests

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set. This allows to remove two needless tests
from uwire_txrx() and uwire_setup_transfer().

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap-uwire.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 55576db..ce8dbdb 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -205,7 +205,7 @@ static void uwire_chipselect(struct spi_device *spi, int value)
 static int uwire_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
 	unsigned	len = t->len;
-	unsigned	bits = t->bits_per_word ? : spi->bits_per_word;
+	unsigned	bits = t->bits_per_word;
 	unsigned	bytes;
 	u16		val, w;
 	int		status = 0;
@@ -344,9 +344,10 @@ static int uwire_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	/* assume it's already enabled */
 	rate = clk_get_rate(uwire->ck);
 
-	hz = spi->max_speed_hz;
-	if (t != NULL && t->speed_hz)
+	if (t != NULL)
 		hz = t->speed_hz;
+	else
+		hz = spi->max_speed_hz;
 
 	if (!hz) {
 		pr_debug("%s: zero speed?\n", dev_name(&spi->dev));
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
