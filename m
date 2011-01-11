From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] spi/bfin_spi: support for
	multiples of 8bits with hardware CS
Date: Tue, 11 Jan 2011 11:19:07 -0500
Message-ID: <1294762748-25122-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Bob Liu <lliubbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

We can do multiples of 8bit transfers when using the hardware CS and a
little bit of magic, so make it work.

Signed-off-by: Bob Liu <lliubbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |  103 +++++++++++++++++++++++++++++++--------------
 1 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 3f22351..e8d68b7 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -425,6 +425,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 	struct bfin_spi_slave_data *chip = drv_data->cur_chip;
 	struct spi_message *msg = drv_data->cur_msg;
 	int n_bytes = drv_data->n_bytes;
+	int loop = 0;
 
 	/* wait until transfer finished. */
 	while (!(read_STAT(drv_data) & BIT_STAT_RXS))
@@ -435,10 +436,15 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 		/* last read */
 		if (drv_data->rx) {
 			dev_dbg(&drv_data->pdev->dev, "last read\n");
-			if (n_bytes == 2)
-				*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
-			else if (n_bytes == 1)
-				*(u8 *) (drv_data->rx) = read_RDBR(drv_data);
+			if (n_bytes % 2) {
+				u16 *buf = (u16 *)drv_data->rx;
+				for (loop = 0; loop < n_bytes / 2; loop++)
+					*buf++ = read_RDBR(drv_data);
+			} else {
+				u8 *buf = (u8 *)drv_data->rx;
+				for (loop = 0; loop < n_bytes; loop++)
+					*buf++ = read_RDBR(drv_data);
+			}
 			drv_data->rx += n_bytes;
 		}
 
@@ -458,29 +464,53 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 	if (drv_data->rx && drv_data->tx) {
 		/* duplex */
 		dev_dbg(&drv_data->pdev->dev, "duplex: write_TDBR\n");
-		if (drv_data->n_bytes == 2) {
-			*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
-			write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
-		} else if (drv_data->n_bytes == 1) {
-			*(u8 *) (drv_data->rx) = read_RDBR(drv_data);
-			write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
+		if (n_bytes % 2) {
+			u16 *buf = (u16 *)drv_data->rx;
+			u16 *buf2 = (u16 *)drv_data->tx;
+			for (loop = 0; loop < n_bytes / 2; loop++) {
+				*buf++ = read_RDBR(drv_data);
+				write_TDBR(drv_data, *buf2++);
+			}
+		} else {
+			u8 *buf = (u8 *)drv_data->rx;
+			u8 *buf2 = (u8 *)drv_data->tx;
+			for (loop = 0; loop < n_bytes; loop++) {
+				*buf++ = read_RDBR(drv_data);
+				write_TDBR(drv_data, *buf2++);
+			}
 		}
 	} else if (drv_data->rx) {
 		/* read */
 		dev_dbg(&drv_data->pdev->dev, "read: write_TDBR\n");
-		if (drv_data->n_bytes == 2)
-			*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
-		else if (drv_data->n_bytes == 1)
-			*(u8 *) (drv_data->rx) = read_RDBR(drv_data);
-		write_TDBR(drv_data, chip->idle_tx_val);
+		if (n_bytes % 2) {
+			u16 *buf = (u16 *)drv_data->rx;
+			for (loop = 0; loop < n_bytes / 2; loop++) {
+				*buf++ = read_RDBR(drv_data);
+				write_TDBR(drv_data, chip->idle_tx_val);
+			}
+		} else {
+			u8 *buf = (u8 *)drv_data->rx;
+			for (loop = 0; loop < n_bytes; loop++) {
+				*buf++ = read_RDBR(drv_data);
+				write_TDBR(drv_data, chip->idle_tx_val);
+			}
+		}
 	} else if (drv_data->tx) {
 		/* write */
 		dev_dbg(&drv_data->pdev->dev, "write: write_TDBR\n");
-		bfin_spi_dummy_read(drv_data);
-		if (drv_data->n_bytes == 2)
-			write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
-		else if (drv_data->n_bytes == 1)
-			write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
+		if (n_bytes % 2) {
+			u16 *buf = (u16 *)drv_data->tx;
+			for (loop = 0; loop < n_bytes / 2; loop++) {
+				read_RDBR(drv_data);
+				write_TDBR(drv_data, *buf++);
+			}
+		} else {
+			u8 *buf = (u8 *)drv_data->tx;
+			for (loop = 0; loop < n_bytes; loop++) {
+				read_RDBR(drv_data);
+				write_TDBR(drv_data, *buf++);
+			}
+		}
 	}
 
 	if (drv_data->tx)
@@ -651,16 +681,16 @@ static void bfin_spi_pump_transfers(unsigned long data)
 
 	/* Bits per word setup */
 	bits_per_word = transfer->bits_per_word ? : message->spi->bits_per_word;
-	if (bits_per_word == 8) {
-		drv_data->n_bytes = 1;
-		drv_data->len = transfer->len;
-		cr_width = 0;
-		drv_data->ops = &bfin_bfin_spi_transfer_ops_u8;
-	} else if (bits_per_word == 16) {
-		drv_data->n_bytes = 2;
+	if ((bits_per_word > 0) && (bits_per_word % 16 == 0)) {
+		drv_data->n_bytes = bits_per_word/8;
 		drv_data->len = (transfer->len) >> 1;
 		cr_width = BIT_CTL_WORDSIZE;
 		drv_data->ops = &bfin_bfin_spi_transfer_ops_u16;
+	} else if ((bits_per_word > 0) && (bits_per_word % 8 == 0)) {
+		drv_data->n_bytes = bits_per_word/8;
+		drv_data->len = transfer->len;
+		cr_width = 0;
+		drv_data->ops = &bfin_bfin_spi_transfer_ops_u8;
 	} else {
 		dev_err(&drv_data->pdev->dev, "transfer: unsupported bits_per_word\n");
 		message->status = -EINVAL;
@@ -815,10 +845,19 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		if (drv_data->tx == NULL)
 			write_TDBR(drv_data, chip->idle_tx_val);
 		else {
-			if (bits_per_word == 8)
-				write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
-			else
-				write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
+			int loop;
+			if (bits_per_word % 16 == 0) {
+				u16 *buf = (u16 *)drv_data->tx;
+				for (loop = 0; loop < bits_per_word / 16;
+						loop++) {
+					write_TDBR(drv_data, *buf++);
+				}
+			} else if (bits_per_word % 8 == 0) {
+				u8 *buf = (u8 *)drv_data->tx;
+				for (loop = 0; loop < bits_per_word / 8; loop++)
+					write_TDBR(drv_data, *buf++);
+			}
+
 			drv_data->tx += drv_data->n_bytes;
 		}
 
@@ -1031,7 +1070,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 		chip->ctl_reg &= bfin_ctl_reg;
 	}
 
-	if (spi->bits_per_word != 8 && spi->bits_per_word != 16) {
+	if (spi->bits_per_word % 8) {
 		dev_err(&spi->dev, "%d bits_per_word is not supported\n",
 				spi->bits_per_word);
 		goto error;
-- 
1.7.4.rc1
