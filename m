From: Kenth Eriksson <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] Fix broken FSL eSPI driver.
Date: Wed, 20 Jun 2012 18:20:34 +0200
Message-ID: <1340209234-4371-1-git-send-email-kenth.eriksson@transmode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kenth Eriksson <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The eSPI driver does not work on our P2010 board with an 8-bit SPI slave.

- The transmission length is always twice the expected. The length is set to (n_tx + n_rx), which is incorrect for a full duplex SPI interface.
- Bytes and characters are mixed up. The len field in struct spi_transfer is counted in bytes, while the TRANLEN field in the eSPI controller is counted in characters, and bits_per_word si the relation between the two.
- The bytes received from the controller are written at the wrong offset in the driver's receive buffer.
- The interrupt handler calculation of remaining bytes is incorrect.

This fix is based on a previous patch that was not included to lack of response, see http://sourceforge.net/mailarchive/message.php?msg_id=27820036

Signed-off-by: Kenth Eriksson <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c |   36 ++++++++++++++++++++++++++----------
 drivers/spi/spi-fsl-lib.h  |    1 +
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 249d244..2c4224b 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -232,21 +232,32 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		bits_per_word = t->bits_per_word;
 
 	mpc8xxx_spi->len = t->len;
-	len = roundup(len, 4) / 4;
 
 	mpc8xxx_spi->tx = t->tx_buf;
 	mpc8xxx_spi->rx = t->rx_buf;
+	mpc8xxx_spi->bits_per_word = bits_per_word;
 
 	INIT_COMPLETION(mpc8xxx_spi->done);
 
+	/* Convert between t->len (in bytes) and count (in
+	 * characters). For character lengths of 9 to 16 bits, each
+	 * character occupies 2 bytes in Rx/Tx FIFO.
+	 */
+	if (bits_per_word <= 8)
+		len = t->len;
+	else if (bits_per_word <= 16)
+		len = t->len >> 1;
+	else
+		return -EINVAL;
+
 	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
-	if ((t->len - 1) > SPCOM_TRANLEN_MAX) {
+	if ((len - 1) > SPCOM_TRANLEN_MAX) {
 		dev_err(mpc8xxx_spi->dev, "Transaction length (%d)"
-				" beyond the SPCOM[TRANLEN] field\n", t->len);
+			" beyond the SPCOM[TRANLEN] field\n", len);
 		return -EINVAL;
 	}
 	mpc8xxx_spi_write_reg(&reg_base->command,
-		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
+		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(len - 1)));
 
 	ret = fsl_espi_cpu_bufs(mpc8xxx_spi, t, len);
 	if (ret)
@@ -405,12 +416,12 @@ static void fsl_espi_rw_trans(struct spi_message *m,
 
 		espi_trans->n_tx = n_tx;
 		espi_trans->n_rx = trans_len;
-		espi_trans->len = trans_len + n_tx;
+		espi_trans->len = n_tx;
 		espi_trans->tx_buf = local_buf;
 		espi_trans->rx_buf = local_buf + n_tx;
 		fsl_espi_do_trans(m, espi_trans);
 
-		memcpy(rx_buf + pos, espi_trans->rx_buf + n_tx, trans_len);
+		memcpy(rx_buf + pos, espi_trans->rx_buf, trans_len);
 
 		if (loop > 0)
 			espi_trans->actual_length += espi_trans->len - n_tx;
@@ -440,7 +451,7 @@ static void fsl_espi_do_one_msg(struct spi_message *m)
 
 	espi_trans.n_tx = n_tx;
 	espi_trans.n_rx = n_rx;
-	espi_trans.len = n_tx + n_rx;
+	espi_trans.len = n_tx;
 	espi_trans.actual_length = 0;
 	espi_trans.status = 0;
 
@@ -522,6 +533,7 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 
 		if (mspi->len >= 4) {
 			rx_data = mpc8xxx_spi_read_reg(&reg_base->receive);
+			mspi->len -= 4;
 		} else {
 			tmp = mspi->len;
 			rx_data = 0;
@@ -531,10 +543,9 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 			}
 
 			rx_data <<= (4 - mspi->len) * 8;
+			mspi->len = 0;
 		}
 
-		mspi->len -= 4;
-
 		if (mspi->rx)
 			mspi->get_rx(rx_data, mspi);
 	}
@@ -554,7 +565,12 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	/* Clear the events */
 	mpc8xxx_spi_write_reg(&reg_base->event, events);
 
-	mspi->count -= 1;
+	if (mspi->bits_per_word <= 8) {
+		mspi->count = mspi->len;
+	} else if (mspi->bits_per_word <= 16) {
+		mspi->count = mspi->len >> 1;
+	}
+
 	if (mspi->count) {
 		u32 word = mspi->get_tx(mspi);
 
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index cbe881b..53c7cb6 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -57,6 +57,7 @@ struct mpc8xxx_spi {
 	void (*spi_remove) (struct mpc8xxx_spi *mspi);
 
 	unsigned int count;
+	u8 bits_per_word;
 	unsigned int irq;
 
 	unsigned nsecs;		/* (clock cycle time)/2 */
-- 
1.7.3.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
