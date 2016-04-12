From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [PATCH v2 1/2] spi: spi-ti-qspi: Fix FLEN and WLEN settings if
 bits_per_word is overridden
Date: Tue, 12 Apr 2016 12:56:25 +0100
Message-ID: <1460462185.32355.7.camel@codethink.co.uk>
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
the default for the device being addressed.  However, currently we
calculate the number of words in the frame assuming that the word size
is the device default.

If multiple transfers in the same message have differing
bits_per_word, we bitwise-or the different values in the WLEN register
field.

Fix both of these.  Also rename 'frame_length' to 'frame_len_words' to
make clear that it's not a byte count like spi_message::frame_length.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
v2: Rename frame_length to frame_len_words; improve commit message.

 drivers/spi/spi-ti-qspi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 64318fcfacf2..2137f2112804 100644
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
+	unsigned int frame_len_words;
 
 	/* setup device control reg */
 	qspi->dc = 0;
@@ -385,21 +386,23 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	if (spi->mode & SPI_CS_HIGH)
 		qspi->dc |= QSPI_CSPOL(spi->chip_select);
 
-	frame_length = (m->frame_length << 3) / spi->bits_per_word;
-
-	frame_length = clamp(frame_length, 0, QSPI_FRAME);
+	frame_len_words = 0;
+	list_for_each_entry(t, &m->transfers, transfer_list)
+		frame_len_words += t->len / (t->bits_per_word >> 3);
+	frame_len_words = min_t(unsigned int, frame_len_words, QSPI_FRAME);
 
 	/* setup command reg */
 	qspi->cmd = 0;
 	qspi->cmd |= QSPI_EN_CS(spi->chip_select);
-	qspi->cmd |= QSPI_FLEN(frame_length);
+	qspi->cmd |= QSPI_FLEN(frame_len_words);
 
 	ti_qspi_write(qspi, qspi->dc, QSPI_SPI_DC_REG);
 
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
