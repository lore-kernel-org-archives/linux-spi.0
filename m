From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 17/18] spi: fsl-espi: improve message length handling
Date: Sun, 4 Sep 2016 10:02:35 +0200
Message-ID: <7d4a66bb-11ed-a870-7d3d-5c64cc0bd7e4@gmail.com>
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

Move checking for a zero-length message up in the call chain and
use m->frame_length instead of re-calculating the overall length
of all transfers in the message.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 88935a3..84355bb 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -283,8 +283,7 @@ static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 
 	fsl_espi_setup_transfer(spi, trans);
 
-	if (trans->len)
-		ret = fsl_espi_bufs(spi, trans);
+	ret = fsl_espi_bufs(spi, trans);
 
 	if (trans->delay_usecs)
 		udelay(trans->delay_usecs);
@@ -313,7 +312,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	unsigned int delay_usecs = 0, xfer_len = 0;
+	unsigned int delay_usecs = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
 
@@ -322,8 +321,6 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 		goto out;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if ((t->tx_buf) || (t->rx_buf))
-			xfer_len += t->len;
 		if (t->delay_usecs > delay_usecs)
 			delay_usecs = t->delay_usecs;
 	}
@@ -331,14 +328,15 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	t = list_first_entry(&m->transfers, struct spi_transfer,
 			     transfer_list);
 
-	trans.len = xfer_len;
+	trans.len = m->frame_length;
 	trans.speed_hz = t->speed_hz;
 	trans.bits_per_word = t->bits_per_word;
 	trans.delay_usecs = delay_usecs;
 	trans.tx_buf = mspi->local_buf;
 	trans.rx_buf = mspi->local_buf;
 
-	ret = fsl_espi_trans(m, &trans);
+	if (trans.len)
+		ret = fsl_espi_trans(m, &trans);
 
 	m->actual_length = ret ? 0 : trans.len;
 out:
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
