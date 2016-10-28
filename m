From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: Rename len in struct mpc8xxx_spi to rx_len and make it unsigned" to the spi tree
Date: Fri, 28 Oct 2016 19:53:06 +0100
Message-ID: <E1c0CH4-00069U-4y@finisterre>
References: <611500a3-d254-f04c-ce20-6905a649bcda@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <611500a3-d254-f04c-ce20-6905a649bcda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: Rename len in struct mpc8xxx_spi to rx_len and make it unsigned

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

>From f895e27f591228704954cc8927d9c61b3f3da90f Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 27 Oct 2016 21:26:08 +0200
Subject: [PATCH] spi: fsl-espi: Rename len in struct mpc8xxx_spi to rx_len and
 make it unsigned

Now that we introduced element tx_len in struct mpc8xxx_spi let's
rename element len to rx_len as it actually is the number of bytes to
receive. In addition make it unsigned.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 22 +++++++++++-----------
 drivers/spi/spi-fsl-lib.h  |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 95c1fbfe1cbe..5a7449f3b3b8 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -284,7 +284,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	int ret;
 
-	mpc8xxx_spi->len = t->len;
+	mpc8xxx_spi->rx_len = t->len;
 	mpc8xxx_spi->tx_len = t->len;
 
 	mpc8xxx_spi->tx = t->tx_buf;
@@ -445,28 +445,28 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 		int ret;
 
 		/* Spin until RX is done */
-		if (SPIE_RXCNT(events) < min(4, mspi->len)) {
+		if (SPIE_RXCNT(events) < min(4U, mspi->rx_len)) {
 			ret = spin_event_timeout(
 				!(SPIE_RXCNT(events =
 				fsl_espi_read_reg(mspi, ESPI_SPIE)) <
-						min(4, mspi->len)),
+						min(4U, mspi->rx_len)),
 						10000, 0); /* 10 msec */
 			if (!ret)
 				dev_err(mspi->dev,
 					 "tired waiting for SPIE_RXCNT\n");
 		}
 
-		if (mspi->len >= 4) {
+		if (mspi->rx_len >= 4) {
 			rx_data = fsl_espi_read_reg(mspi, ESPI_SPIRF);
-		} else if (mspi->len <= 0) {
+		} else if (!mspi->rx_len) {
 			dev_err(mspi->dev,
 				"unexpected RX(SPIE_RNE) interrupt occurred,\n"
 				"(local rxlen %d bytes, reg rxlen %d bytes)\n",
-				min(4, mspi->len), SPIE_RXCNT(events));
+				min(4U, mspi->rx_len), SPIE_RXCNT(events));
 			rx_nr_bytes = 0;
 		} else {
-			rx_nr_bytes = mspi->len;
-			tmp = mspi->len;
+			rx_nr_bytes = mspi->rx_len;
+			tmp = mspi->rx_len;
 			rx_data = 0;
 			while (tmp--) {
 				rx_data_8 = fsl_espi_read_reg8(mspi,
@@ -474,10 +474,10 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 				rx_data |= (rx_data_8 << (tmp * 8));
 			}
 
-			rx_data <<= (4 - mspi->len) * 8;
+			rx_data <<= (4 - mspi->rx_len) * 8;
 		}
 
-		mspi->len -= rx_nr_bytes;
+		mspi->rx_len -= rx_nr_bytes;
 
 		if (rx_nr_bytes && mspi->rx) {
 			*(u32 *)mspi->rx = rx_data;
@@ -488,7 +488,7 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	if (mspi->tx_len)
 		fsl_espi_fill_tx_fifo(mspi, events);
 
-	if (!mspi->tx_len && !mspi->len)
+	if (!mspi->tx_len && !mspi->rx_len)
 		complete(&mspi->done);
 }
 
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 24d8bc84a111..35a7a1730d0c 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -29,7 +29,7 @@ struct mpc8xxx_spi {
 	const void *tx;
 	void *rx;
 #if IS_ENABLED(CONFIG_SPI_FSL_ESPI)
-	int len;
+	unsigned int rx_len;
 	unsigned int tx_len;
 	u8 *local_buf;
 	spinlock_t lock;
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
