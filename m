From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/23] spi: fsl-espi: remove unneeded variable in
 fsl_espi_do_trans
Date: Thu, 25 Aug 2016 06:45:55 +0200
Message-ID: <683bca81-4522-78d7-338f-0e1a137f4f4f@gmail.com>
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

Creating a message, adding one transfer, and then iterating over
all transfers in the message doesn't make sense.
We can simply use the original transfer directly.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index b3c3612..494a7bf 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -256,11 +256,9 @@ static void fsl_espi_do_trans(struct spi_message *m,
 	struct spi_device *spi = m->spi;
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
 	struct fsl_espi_transfer *espi_trans = tr;
-	struct spi_message message;
 	struct spi_transfer *t, *first, trans;
 	int status = 0;
 
-	spi_message_init(&message);
 	memset(&trans, 0, sizeof(trans));
 
 	first = list_first_entry(&m->transfers, struct spi_transfer,
@@ -282,23 +280,18 @@ static void fsl_espi_do_trans(struct spi_message *m,
 	trans.len = espi_trans->len;
 	trans.tx_buf = espi_trans->tx_buf;
 	trans.rx_buf = espi_trans->rx_buf;
-	spi_message_add_tail(&trans, &message);
 
-	list_for_each_entry(t, &message.transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz)
-			fsl_espi_setup_transfer(spi, t);
+	if (trans.bits_per_word || trans.speed_hz)
+		fsl_espi_setup_transfer(spi, &trans);
 
-		if (t->len)
-			status = fsl_espi_bufs(spi, t);
+	if (trans.len)
+		status = fsl_espi_bufs(spi, &trans);
 
-		if (status) {
-			status = -EMSGSIZE;
-			break;
-		}
+	if (status)
+		status = -EMSGSIZE;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
-	}
+	if (trans.delay_usecs)
+		udelay(trans.delay_usecs);
 
 	espi_trans->status = status;
 	fsl_espi_setup_transfer(spi, NULL);
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
