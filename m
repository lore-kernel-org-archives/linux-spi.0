From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] spi: fsl-espi: remove unused linearization code
Date: Sat, 26 Nov 2016 00:00:28 +0100
Message-ID: <4ce7fd3d-bdb2-3e28-a362-b4a61a207a89@gmail.com>
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

After introducing direct transfers between hardware and transfer
buffers remove all code which is unused now.

This includes getting rid of the 64k linearization buffer.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 80 ----------------------------------------------
 1 file changed, 80 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index e93892d..cd28329 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -95,9 +95,6 @@ struct fsl_espi {
 	struct device *dev;
 	void __iomem *reg_base;
 
-	const void *tx;
-	void *rx;
-
 	struct list_head *m_transfers;
 	struct spi_transfer *tx_t;
 	unsigned int tx_pos;
@@ -107,11 +104,8 @@ struct fsl_espi {
 	bool rx_done;
 
 	bool swab;
-	unsigned int rx_len;
-	unsigned int tx_len;
 	unsigned int rxskip;
 
-	u8 *local_buf;
 	spinlock_t lock;
 
 	u32 spibrg;             /* SPIBRG input clock */
@@ -156,61 +150,6 @@ static inline void fsl_espi_write_reg8(struct fsl_espi *espi, int offset,
 	iowrite8(val, espi->reg_base + offset);
 }
 
-static void fsl_espi_memcpy_swab(void *to, const void *from,
-				 struct spi_message *m,
-				 struct spi_transfer *t)
-{
-	struct fsl_espi *espi = spi_master_get_devdata(m->spi->master);
-	unsigned int len = t->len;
-
-	if (!espi->swab) {
-		memcpy(to, from, len);
-		return;
-	}
-
-	while (len)
-		if (len >= 4) {
-			*(u32 *)to = swahb32p(from);
-			to += 4;
-			from += 4;
-			len -= 4;
-		} else {
-			*(u16 *)to = swab16p(from);
-			to += 2;
-			from += 2;
-			len -= 2;
-		}
-}
-
-static void fsl_espi_copy_to_buf(struct spi_message *m,
-				 struct fsl_espi *espi)
-{
-	struct spi_transfer *t;
-	u8 *buf = espi->local_buf;
-
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf)
-			fsl_espi_memcpy_swab(buf, t->tx_buf, m, t);
-		/* In RXSKIP mode controller shifts out zeros internally */
-		else if (!espi->rxskip)
-			memset(buf, 0, t->len);
-		buf += t->len;
-	}
-}
-
-static void fsl_espi_copy_from_buf(struct spi_message *m,
-				   struct fsl_espi *espi)
-{
-	struct spi_transfer *t;
-	u8 *buf = espi->local_buf;
-
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->rx_buf)
-			fsl_espi_memcpy_swab(t->rx_buf, buf, m, t);
-		buf += t->len;
-	}
-}
-
 static int fsl_espi_check_message(struct spi_message *m)
 {
 	struct fsl_espi *espi = spi_master_get_devdata(m->spi->master);
@@ -421,12 +360,6 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	u32 mask, spcom;
 	int ret;
 
-	espi->rx_len = t->len;
-	espi->tx_len = t->len;
-
-	espi->tx = t->tx_buf;
-	espi->rx = t->rx_buf;
-
 	reinit_completion(&espi->done);
 
 	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
@@ -436,10 +369,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	/* configure RXSKIP mode */
 	if (espi->rxskip) {
 		spcom |= SPCOM_RXSKIP(espi->rxskip);
-		espi->tx_len = espi->rxskip;
-		espi->rx_len = t->len - espi->rxskip;
 		rx_len = t->len - espi->rxskip;
-		espi->rx = t->rx_buf + espi->rxskip;
 		if (t->rx_nbits == SPI_NBITS_DUAL)
 			spcom |= SPCOM_DO;
 	}
@@ -497,7 +427,6 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	if (espi->rxskip)
 		espi->rx_t = list_next_entry(espi->rx_t, transfer_list);
 
-	fsl_espi_copy_to_buf(m, espi);
 	fsl_espi_setup_transfer(spi, trans);
 
 	ret = fsl_espi_bufs(spi, trans);
@@ -511,7 +440,6 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
-	struct fsl_espi *espi = spi_master_get_devdata(m->spi->master);
 	unsigned int delay_usecs = 0, rx_nbits = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
@@ -534,8 +462,6 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	trans.speed_hz = t->speed_hz;
 	trans.bits_per_word = t->bits_per_word;
 	trans.delay_usecs = delay_usecs;
-	trans.tx_buf = espi->local_buf;
-	trans.rx_buf = espi->local_buf;
 	trans.rx_nbits = rx_nbits;
 
 	if (trans.len)
@@ -773,12 +699,6 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 
 	init_completion(&espi->done);
 
-	espi->local_buf = devm_kmalloc(dev, SPCOM_TRANLEN_MAX, GFP_KERNEL);
-	if (!espi->local_buf) {
-		ret = -ENOMEM;
-		goto err_probe;
-	}
-
 	espi->reg_base = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(espi->reg_base)) {
 		ret = PTR_ERR(espi->reg_base);
-- 
2.10.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
