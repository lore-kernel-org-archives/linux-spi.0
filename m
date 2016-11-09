From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: fsl-espi: add support for dual output read mode
Date: Wed, 9 Nov 2016 22:58:34 +0100
Message-ID: <e23b4753-bdcc-3c79-7307-44052fd9e0dc@gmail.com>
References: <c9f32ebc-43e9-41a5-809c-7e11751deef7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c9f32ebc-43e9-41a5-809c-7e11751deef7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds support for dual output read mode.

It was successfully tested on a P1014-based device with S25FL128S
SPINOR flash. With 50MHz SPI clock the read rate is 11MByte/s.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index e147fa7..789ca06 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -334,6 +334,8 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		mpc8xxx_spi->tx_len = mpc8xxx_spi->rxskip;
 		mpc8xxx_spi->rx_len = t->len - mpc8xxx_spi->rxskip;
 		mpc8xxx_spi->rx = t->rx_buf + mpc8xxx_spi->rxskip;
+		if (t->rx_nbits == SPI_NBITS_DUAL)
+			spcom |= SPCOM_DO;
 	}
 
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM, spcom);
@@ -369,6 +371,11 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	int ret;
 
 	mspi->rxskip = fsl_espi_check_rxskip_mode(m);
+	if (trans->rx_nbits == SPI_NBITS_DUAL && !mspi->rxskip) {
+		dev_err(mspi->dev, "Dual output mode requires RXSKIP mode!\n");
+		return -EINVAL;
+	}
+
 	fsl_espi_copy_to_buf(m, mspi);
 	fsl_espi_setup_transfer(spi, trans);
 
@@ -387,7 +394,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	unsigned int delay_usecs = 0;
+	unsigned int delay_usecs = 0, rx_nbits = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
 
@@ -398,6 +405,8 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->delay_usecs > delay_usecs)
 			delay_usecs = t->delay_usecs;
+		if (t->rx_nbits > rx_nbits)
+			rx_nbits = t->rx_nbits;
 	}
 
 	t = list_first_entry(&m->transfers, struct spi_transfer,
@@ -409,6 +418,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	trans.delay_usecs = delay_usecs;
 	trans.tx_buf = mspi->local_buf;
 	trans.rx_buf = mspi->local_buf;
+	trans.rx_nbits = rx_nbits;
 
 	if (trans.len)
 		ret = fsl_espi_trans(m, &trans);
@@ -580,6 +590,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 
 	mpc8xxx_spi_probe(dev, mem, irq);
 
+	master->mode_bits |= SPI_RX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 	master->setup = fsl_espi_setup;
 	master->cleanup = fsl_espi_cleanup;
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
