From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 10/18] spi: fsl-espi: merge fsl_espi_cmd_trans and
 fsl_espi_rw_trans
Date: Sun, 4 Sep 2016 10:00:56 +0200
Message-ID: <077f4dc7-be65-41e4-07c3-73bd8b486ae0@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

fsl_espi_cmd_trans and fsl_espi_rw_trans share most of the code so
we can merge them.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8554f18..f8a6dd1 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -299,23 +299,8 @@ static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 	return ret;
 }
 
-static int fsl_espi_cmd_trans(struct spi_message *m,
-			      struct spi_transfer *trans, u8 *rx_buff)
-{
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	int ret;
-
-	fsl_espi_copy_to_buf(m, mspi);
-
-	trans->tx_buf = mspi->local_buf;
-	trans->rx_buf = mspi->local_buf;
-	ret = fsl_espi_do_trans(m, trans);
-
-	return ret;
-}
-
-static int fsl_espi_rw_trans(struct spi_message *m,
-			     struct spi_transfer *trans, u8 *rx_buff)
+static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans,
+			  u8 *rx_buff)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	unsigned int tx_only;
@@ -327,12 +312,9 @@ static int fsl_espi_rw_trans(struct spi_message *m,
 	trans->rx_buf = mspi->local_buf;
 	ret = fsl_espi_do_trans(m, trans);
 
-	if (!ret) {
-		/* If there is at least one RX byte then copy it to rx_buff */
-		if (trans->len > tx_only)
-			memcpy(rx_buff, trans->rx_buf + tx_only,
-			       trans->len - tx_only);
-	}
+	/* If there is at least one RX byte then copy it to rx_buff */
+	if (!ret && rx_buff && trans->len > tx_only)
+		memcpy(rx_buff, trans->rx_buf + tx_only, trans->len - tx_only);
 
 	return ret;
 }
@@ -354,10 +336,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 
 	trans.len = xfer_len;
 
-	if (!rx_buf)
-		ret = fsl_espi_cmd_trans(m, &trans, NULL);
-	else
-		ret = fsl_espi_rw_trans(m, &trans, rx_buf);
+	ret = fsl_espi_trans(m, &trans, rx_buf);
 
 	m->actual_length = ret ? 0 : trans.len;
 
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
