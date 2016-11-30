From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: determine need for byte swap only once" to the spi tree
Date: Wed, 30 Nov 2016 18:08:04 +0000
Message-ID: <E1cC9Ia-0008Po-FH@debutante>
References: <bfa9887d-ed21-6d89-7e7b-d65c67571d85@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bfa9887d-ed21-6d89-7e7b-d65c67571d85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: determine need for byte swap only once

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

>From e1cdee73dfcac393768117511e52a6142587dacf Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Fri, 25 Nov 2016 23:58:49 +0100
Subject: [PATCH] spi: fsl-espi: determine need for byte swap only once

Determine need for byte swap only once and store it in new member
swab in struct fsl_espi.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 4fbcc36fa891..4222578a4dd4 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -98,6 +98,7 @@ struct fsl_espi {
 	const void *tx;
 	void *rx;
 
+	bool swab;
 	unsigned int rx_len;
 	unsigned int tx_len;
 	unsigned int rxskip;
@@ -140,14 +141,14 @@ static void fsl_espi_memcpy_swab(void *to, const void *from,
 				 struct spi_message *m,
 				 struct spi_transfer *t)
 {
+	struct fsl_espi *espi = spi_master_get_devdata(m->spi->master);
 	unsigned int len = t->len;
 
-	if (!(m->spi->mode & SPI_LSB_FIRST) || t->bits_per_word <= 8) {
+	if (!espi->swab) {
 		memcpy(to, from, len);
 		return;
 	}
 
-	/* In case of LSB-first and bits_per_word > 8 byte-swap all words */
 	while (len)
 		if (len >= 4) {
 			*(u32 *)to = swahb32p(from);
@@ -384,6 +385,9 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	struct spi_device *spi = m->spi;
 	int ret;
 
+	/* In case of LSB-first and bits_per_word > 8 byte-swap all words */
+	espi->swab = spi->mode & SPI_LSB_FIRST && trans->bits_per_word > 8;
+
 	espi->rxskip = fsl_espi_check_rxskip_mode(m);
 	if (trans->rx_nbits == SPI_NBITS_DUAL && !espi->rxskip) {
 		dev_err(espi->dev, "Dual output mode requires RXSKIP mode!\n");
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
