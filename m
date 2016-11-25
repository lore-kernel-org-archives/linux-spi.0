From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] spi: fsl-espi: determine need for byte swap only once
Date: Fri, 25 Nov 2016 23:58:49 +0100
Message-ID: <bfa9887d-ed21-6d89-7e7b-d65c67571d85@gmail.com>
References: <2424ba57-be1a-d32d-0c14-1662c2d02409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2424ba57-be1a-d32d-0c14-1662c2d02409-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Determine need for byte swap only once and store it in new member
swab in struct fsl_espi.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
This extension is needed for subsequent patches of this series.
---
 drivers/spi/spi-fsl-espi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 4fbcc36..4222578 100644
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
