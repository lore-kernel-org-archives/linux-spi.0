From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 20/23] spi: fsl-espi: centralize populating struct
 spi_transfer
Date: Fri, 2 Sep 2016 23:22:34 +0200
Message-ID: <fc3ba27b-b7e1-a093-23d2-82956b8476c5@gmail.com>
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

Better structure the code by population all elements of struct
spi_transfer in one place.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index a32bc3a..79c89bf 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -272,17 +272,8 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 {
 	struct spi_device *spi = m->spi;
-	struct spi_transfer *t, *first;
 	int ret = 0;
 
-	first = list_first_entry(&m->transfers, struct spi_transfer,
-			transfer_list);
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		trans->speed_hz = t->speed_hz;
-		trans->bits_per_word = t->bits_per_word;
-		trans->delay_usecs = max(first->delay_usecs, t->delay_usecs);
-	}
-
 	fsl_espi_setup_transfer(spi, trans);
 
 	if (trans->len)
@@ -305,8 +296,6 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans,
 
 	tx_only = fsl_espi_copy_to_buf(m, mspi);
 
-	trans->tx_buf = mspi->local_buf;
-	trans->rx_buf = mspi->local_buf;
 	ret = fsl_espi_do_trans(m, trans);
 
 	/* If there is at least one RX byte then copy it to rx_buff */
@@ -319,8 +308,9 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans,
 static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	u8 *rx_buf = NULL;
-	unsigned int xfer_len = 0;
+	unsigned int delay_usecs = 0, xfer_len = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
 
@@ -333,9 +323,19 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 			rx_buf = t->rx_buf;
 		if ((t->tx_buf) || (t->rx_buf))
 			xfer_len += t->len;
+		if (t->delay_usecs > delay_usecs)
+			delay_usecs = t->delay_usecs;
 	}
 
+	t = list_first_entry(&m->transfers, struct spi_transfer,
+			     transfer_list);
+
 	trans.len = xfer_len;
+	trans.speed_hz = t->speed_hz;
+	trans.bits_per_word = t->bits_per_word;
+	trans.delay_usecs = delay_usecs;
+	trans.tx_buf = mspi->local_buf;
+	trans.rx_buf = mspi->local_buf;
 
 	ret = fsl_espi_trans(m, &trans, rx_buf);
 
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
