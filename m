From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: core: propagate return code of __spi_validate_bits_per_word()" to the spi tree
Date: Fri, 16 Oct 2015 17:41:26 +0100
Message-ID: <E1Zn84M-0008HA-QP@debutante>
References: <1444851787-38604-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444851787-38604-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: core: propagate return code of __spi_validate_bits_per_word()

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

>From 5ab8d262122bc951b308e51cdcc55bc67b1f5fdb Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 14 Oct 2015 22:43:07 +0300
Subject: [PATCH] spi: core: propagate return code of
 __spi_validate_bits_per_word()

Propagate the actual return code of __spi_validate_bits_per_word() in
spi_setup().

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40c9afac047f..64c1aedde481 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1956,7 +1956,7 @@ static int __spi_validate_bits_per_word(struct spi_master *master, u8 bits_per_w
 int spi_setup(struct spi_device *spi)
 {
 	unsigned	bad_bits, ugly_bits;
-	int		status = 0;
+	int		status;
 
 	/* check mode to prevent that DUAL and QUAD set at the same time
 	 */
@@ -1993,8 +1993,9 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
 
-	if (__spi_validate_bits_per_word(spi->master, spi->bits_per_word))
-		return -EINVAL;
+	status = __spi_validate_bits_per_word(spi->master, spi->bits_per_word);
+	if (status)
+		return status;
 
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz = spi->master->max_speed_hz;
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
