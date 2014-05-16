From: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi/fsl-espi: fix rx_buf in fsl_espi_cmd_trans()/fsl_espi_rw_trans()
Date: Fri, 16 May 2014 16:46:21 +0200
Message-ID: <1400251581-26617-1-git-send-email-valentin.longchamp@keymile.com>
Cc: Mark Marshall <markmarshall14-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
To: Linux SPI <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

By default for every espi transfer, the rx_buf is placed right after the
tx_buf. This can lead to a buffer overflow when the size of both the TX
and RX data cumulated is higher than the allocated 64K buffer for the
transfer (this is the case when sending for instance a read command and
reading 64K back, please see:
http://article.gmane.org/gmane.linux.drivers.mtd/53411 )

This gets fixed by always setting the RX buffer pointer at the begining
of the transfer buffer.

Signed-off-by: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>

---

 drivers/spi/spi-fsl-espi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index e767f58..f17d6bd 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -348,7 +348,7 @@ static void fsl_espi_cmd_trans(struct spi_message *m,
 	}
 
 	espi_trans->tx_buf = local_buf;
-	espi_trans->rx_buf = local_buf + espi_trans->n_tx;
+	espi_trans->rx_buf = local_buf;
 	fsl_espi_do_trans(m, espi_trans);
 
 	espi_trans->actual_length = espi_trans->len;
@@ -397,7 +397,7 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 		espi_trans->n_rx = trans_len;
 		espi_trans->len = trans_len + n_tx;
 		espi_trans->tx_buf = local_buf;
-		espi_trans->rx_buf = local_buf + n_tx;
+		espi_trans->rx_buf = local_buf;
 		fsl_espi_do_trans(m, espi_trans);
 
 		memcpy(rx_buf + pos, espi_trans->rx_buf + n_tx, trans_len);
-- 
1.8.0.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
