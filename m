From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [PATCH 1/2] spi: spi-ti-qspi: Fix FLEN and WLEN settings if
 bits_per_word is overridden
Date: Tue, 05 Apr 2016 20:45:28 +0100
Message-ID: <1459885528.26669.5.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Each transfer can specify 8, 16 or 32 bits per word independently of
the default for the device being addressed.  Currently we always set
the FLEN register field according to the device default.  Also, if
multiple transfers in the same message have differing bits_per_word,
we bitwise-or the different values in the WLEN register field.  Fix
both of these.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
Unfortunately I don't have a test setup where bits_per_word is
overridden.  But it is straightforward to verify that the driver is no
longer using spi->bits_per_word.

Ben.

 drivers/spi/spi-ti-qspi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 64318fcfacf2..e5cefaca0589 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -94,6 +94,7 @@ struct ti_qspi {
 #define QSPI_FLEN(n)			((n - 1) << 0)
 #define QSPI_WLEN_MAX_BITS		128
 #define QSPI_WLEN_MAX_BYTES		16
+#define QSPI_WLEN_MASK			QSPI_WLEN(QSPI_WLEN_MAX_BITS)
 
 /* STATUS REGISTER */
 #define BUSY				0x01
@@ -373,7 +374,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t;
 	int status = 0, ret;
-	int frame_length;
+	unsigned int frame_length;
 
 	/* setup device control reg */
 	qspi->dc = 0;
@@ -385,9 +386,10 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	if (spi->mode & SPI_CS_HIGH)
 		qspi->dc |= QSPI_CSPOL(spi->chip_select);
 
-	frame_length = (m->frame_length << 3) / spi->bits_per_word;
-
-	frame_length = clamp(frame_length, 0, QSPI_FRAME);
+	frame_length = 0;
+	list_for_each_entry(t, &m->transfers, transfer_list)
+		frame_length += t->len / (t->bits_per_word >> 3);
+	frame_length = min_t(unsigned int, frame_length, QSPI_FRAME);
 
 	/* setup command reg */
 	qspi->cmd = 0;
@@ -399,7 +401,8 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	mutex_lock(&qspi->list_lock);
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		qspi->cmd |= QSPI_WLEN(t->bits_per_word);
+		qspi->cmd = ((qspi->cmd & ~QSPI_WLEN_MASK) |
+			     QSPI_WLEN(t->bits_per_word));
 
 		ret = qspi_transfer_msg(qspi, t);
 		if (ret) {
-- 
2.8.0.rc3



-- 
Ben Hutchings
Software Developer, Codethink Ltd.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
