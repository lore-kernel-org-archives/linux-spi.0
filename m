From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: add support for dual output read mode" to the spi tree
Date: Fri, 11 Nov 2016 16:01:28 +0000
Message-ID: <E1c5EGe-0003oX-F8@finisterre>
References: <e23b4753-bdcc-3c79-7307-44052fd9e0dc@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e23b4753-bdcc-3c79-7307-44052fd9e0dc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: add support for dual output read mode

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

>From 8263cb33c8636e4b333d97ef5995a2b484ea48ea Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 9 Nov 2016 22:58:34 +0100
Subject: [PATCH] spi: fsl-espi: add support for dual output read mode

This patch adds support for dual output read mode.

It was successfully tested on a P1014-based device with S25FL128S
SPINOR flash. With 50MHz SPI clock the read rate is 11MByte/s.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 9ccbfbc75933..6624c5a06ffc 100644
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
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
