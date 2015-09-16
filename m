From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: au1550: Simplify au1550_spi_setupxfer()" to the spi tree
Date: Wed, 16 Sep 2015 21:02:06 +0100
Message-ID: <E1ZcIu6-00081N-Vm@finisterre>
References: <1442323588-29642-6-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-6-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: au1550: Simplify au1550_spi_setupxfer()

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

>From 0beb0a6da8896da14287b1caa77596057690901a Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 15 Sep 2015 16:26:18 +0300
Subject: [PATCH] spi: au1550: Simplify au1550_spi_setupxfer()

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set. This can simplify a little the
au1550_spi_setupxfer() as there is need to check only for valid
"struct spi_transfer" pointer.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-au1550.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index f45e085..afd239d 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -233,13 +233,12 @@ static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	unsigned bpw, hz;
 	u32 cfg, stat;
 
-	bpw = spi->bits_per_word;
-	hz = spi->max_speed_hz;
 	if (t) {
-		if (t->bits_per_word)
-			bpw = t->bits_per_word;
-		if (t->speed_hz)
-			hz = t->speed_hz;
+		bpw = t->bits_per_word;
+		hz = t->speed_hz;
+	} else {
+		bpw = spi->bits_per_word;
+		hz = spi->max_speed_hz;
 	}
 
 	if (!hz)
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
