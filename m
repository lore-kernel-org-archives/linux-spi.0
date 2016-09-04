From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 08/18] spi: fsl-espi: remove element actual_length from
 struct fsl_espi_trans
Date: Sun, 4 Sep 2016 09:59:41 +0200
Message-ID: <67c8d6d6-322e-65e0-b78d-bbb8354353c9@gmail.com>
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

If an error occurs during processing the message, then we don't have
to populate the actual_length element of struct message.
So we can get rid of element actual_length in struct
fsl_espi_transfer.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 6b60f7b..726d5fd 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -41,7 +41,6 @@ struct fsl_espi_transfer {
 	const void *tx_buf;
 	void *rx_buf;
 	unsigned len;
-	unsigned actual_length;
 };
 
 /* eSPI Controller mode register definitions */
@@ -327,8 +326,6 @@ static int fsl_espi_cmd_trans(struct spi_message *m,
 	espi_trans->rx_buf = mspi->local_buf;
 	ret = fsl_espi_do_trans(m, espi_trans);
 
-	espi_trans->actual_length = espi_trans->len;
-
 	return ret;
 }
 
@@ -350,7 +347,6 @@ static int fsl_espi_rw_trans(struct spi_message *m,
 		if (trans->len > tx_only)
 			memcpy(rx_buff, trans->rx_buf + tx_only,
 			       trans->len - tx_only);
-		trans->actual_length += trans->len;
 	}
 
 	return ret;
@@ -373,14 +369,14 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	}
 
 	espi_trans.len = xfer_len;
-	espi_trans.actual_length = 0;
 
 	if (!rx_buf)
 		ret = fsl_espi_cmd_trans(m, &espi_trans, NULL);
 	else
 		ret = fsl_espi_rw_trans(m, &espi_trans, rx_buf);
 
-	m->actual_length = espi_trans.actual_length;
+	m->actual_length = ret ? 0 : espi_trans.len;
+
 	if (m->status == -EINPROGRESS)
 		m->status = ret;
 
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
