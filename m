From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: reject MSB-first transfers with word sizes other than 8 or 16" to the spi tree
Date: Thu, 06 Oct 2016 18:03:31 +0200
Message-ID: <E1bsB8t-0001sJ-0N@finisterre>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: reject MSB-first transfers with word sizes other than 8 or 16

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

>From 3a38341deb01bf136ce40859bfc6f38f63b1c9e6 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 2 Oct 2016 14:22:35 +0200
Subject: [PATCH] spi: fsl-espi: reject MSB-first transfers with word sizes
 other than 8 or 16

According to the ESPI spec MSB-first transfers are supported for
word size 8 and 16 only.

Check for this and reject MSB-first transfers with other word sizes.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1f97cce615d3..65bb70d3bfc4 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -153,6 +153,7 @@ static int fsl_espi_check_message(struct spi_message *m)
 
 	first = list_first_entry(&m->transfers, struct spi_transfer,
 				 transfer_list);
+
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (first->bits_per_word != t->bits_per_word ||
 		    first->speed_hz != t->speed_hz) {
@@ -161,6 +162,15 @@ static int fsl_espi_check_message(struct spi_message *m)
 		}
 	}
 
+	/* ESPI supports MSB-first transfers for word size 8 / 16 only */
+	if (!(m->spi->mode & SPI_LSB_FIRST) && first->bits_per_word != 8 &&
+	    first->bits_per_word != 16) {
+		dev_err(mspi->dev,
+			"MSB-first transfer not supported for wordsize %u\n",
+			first->bits_per_word);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
