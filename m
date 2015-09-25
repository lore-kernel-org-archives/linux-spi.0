From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: atmel: Remove needless bits_per_word and speed_hz tests" to the spi tree
Date: Fri, 25 Sep 2015 11:09:45 -0700
Message-ID: <E1ZfXRJ-0002w4-Pf@finisterre>
References: <1442323588-29642-10-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-10-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: atmel: Remove needless bits_per_word and speed_hz tests

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

>From e8646580cc9a6ae24ab3d05f90e71334f50cdedf Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Fri, 25 Sep 2015 09:03:01 +0300
Subject: [PATCH] spi: atmel: Remove needless bits_per_word and speed_hz tests

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set. This makes possible to remove two if
statements and remove one code block that is never executed.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index bf9ed38..1cc1f1e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -871,14 +871,7 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 	 * Calculate the lowest divider that satisfies the
 	 * constraint, assuming div32/fdiv/mbz == 0.
 	 */
-	if (xfer->speed_hz)
-		scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
-	else
-		/*
-		 * This can happend if max_speed is null.
-		 * In this case, we set the lowest possible speed
-		 */
-		scbr = 0xff;
+	scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
 
 	/*
 	 * If the resulting divider doesn't fit into the
@@ -1300,14 +1293,12 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		return -EINVAL;
 	}
 
-	if (xfer->bits_per_word) {
-		asd = spi->controller_state;
-		bits = (asd->csr >> 4) & 0xf;
-		if (bits != xfer->bits_per_word - 8) {
-			dev_dbg(&spi->dev,
+	asd = spi->controller_state;
+	bits = (asd->csr >> 4) & 0xf;
+	if (bits != xfer->bits_per_word - 8) {
+		dev_dbg(&spi->dev,
 			"you can't yet change bits_per_word in transfers\n");
-			return -ENOPROTOOPT;
-		}
+		return -ENOPROTOOPT;
 	}
 
 	/*
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
