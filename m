From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 5/5] spi: ti-qspi: cleanup wait_for_completion return handling
Date: Mon,  2 Feb 2015 03:30:36 -0500
Message-ID: <1422865837-10357-5-git-send-email-hofrat@osadl.org>
References: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <hofrat@osadl.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int, this
patch uses the return value of wait_for_completion_timeout in the condition
directly rather than assigning it to an incorrect type variable.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

The return type of wait_for_completion_timeout is unsigned long not
int. This patch resolves the type mismatch by moving the call to
wait_for_completion_timeout into the condition.

This patch was only compile tested with omap2plus_defconfig

Patch is against 3.19.0-rc6 -next-20150130

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
+		    QSPI_COMPLETION_TIMEOUT)) {
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
+		    QSPI_COMPLETION_TIMEOUT)) {
 			dev_err(qspi->dev, "read timed out\n");
 			return -ETIMEDOUT;
 		}
-- 
1.7.10.4
