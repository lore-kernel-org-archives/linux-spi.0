From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH v2] spi: ti-qspi: cleanup wait_for_completion return handling
Date: Thu,  5 Feb 2015 10:03:42 -0500
Message-ID: <1423148622-3758-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

return type of wait_for_completion_timeout is unsigned long not int, this
patch uses the return value of wait_for_completion_timeout in the condition
directly rather than assigning it to an incorrect type variable.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

v2: fixed the broken indentation reported by Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

This patch was only compile tested with omap2plus_defconfig
(implies CONFIG_SPI_TI_QSPI=m)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/spi/spi-ti-qspi.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 6146c4c..3364e3e 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -201,7 +201,7 @@ static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
 
 static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 {
-	int wlen, count, ret;
+	int wlen, count;
 	unsigned int cmd;
 	const u8 *txbuf;
 
@@ -230,9 +230,8 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 		}
 
 		ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
-		ret = wait_for_completion_timeout(&qspi->transfer_complete,
-						  QSPI_COMPLETION_TIMEOUT);
-		if (ret == 0) {
+		if (!wait_for_completion_timeout(&qspi->transfer_complete,
+						 QSPI_COMPLETION_TIMEOUT)) {
 			dev_err(qspi->dev, "write timed out\n");
 			return -ETIMEDOUT;
 		}
@@ -245,7 +244,7 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 
 static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 {
-	int wlen, count, ret;
+	int wlen, count;
 	unsigned int cmd;
 	u8 *rxbuf;
 
@@ -268,9 +267,8 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	while (count) {
 		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
 		ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
-		ret = wait_for_completion_timeout(&qspi->transfer_complete,
-				QSPI_COMPLETION_TIMEOUT);
-		if (ret == 0) {
+		if (!wait_for_completion_timeout(&qspi->transfer_complete,
+						 QSPI_COMPLETION_TIMEOUT)) {
 			dev_err(qspi->dev, "read timed out\n");
 			return -ETIMEDOUT;
 		}
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
