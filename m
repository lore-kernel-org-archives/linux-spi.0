From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [RFC/PATCH 2/2] driver: spi: Add quad spi read support
Date: Sun, 4 Aug 2013 14:28:10 +0530
Message-ID: <1375606690-834-3-git-send-email-sourav.poddar@ti.com>
References: <1375606690-834-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <balbi@ti.com>, <rnayak@ti.com>, <linux-omap@vger.kernel.org>,
	Sourav Poddar <sourav.poddar@ti.com>
To: <broonie@kernel.org>, <spi-devel-general@lists.sourceforge.net>,
	<grant.likely@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1375606690-834-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since, qspi controller uses quad read.

Configuring the command register, if the transfer of data needs
dual or quad lines.

This patch has been done on top of the following patch[1], which is just the
basic idea of adding dual/quad support in spi framework.
$subject patch will undergo changes once the ongoing discussion in the
community is freezed.

This patch is posted to demonstrate how patch 1 of the series will support
quad read.

[1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/spi/spi-ti-qspi.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 4328ae2..65457f5 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -266,18 +266,30 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 {
 	int wlen, count, ret;
+	unsigned cmd = qspi->cmd;
 
 	count = t->len;
 	wlen = t->bits_per_word;
 
+	switch (t->bitwidth) {
+	case SPI_BITWIDTH_QUAD:
+		cmd |= QSPI_RD_QUAD;
+		break;
+	case SPI_BITWIDTH_DUAL:
+		cmd |= QSPI_RD_DUAL;
+		break;
+	case SPI_BITWIDTH_SINGLE:
+	default:
+		cmd |= QSPI_RD_SNGL;
+	}
+
 	if (wlen == 8) {
 		u8 *rxbuf;
 		rxbuf = t->rx_buf;
 		do {
 			dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n",
 				qspi->cmd | QSPI_RD_SNGL, qspi->dc);
-			ti_qspi_write(qspi, qspi->cmd | QSPI_RD_SNGL,
-				QSPI_SPI_CMD_REG);
+			ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
 			ret = wait_for_completion_timeout(&qspi->transfer_complete,
 				QSPI_COMPLETION_TIMEOUT);
 			if (ret == 0) {
@@ -295,8 +307,7 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 		do {
 			dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n",
 				qspi->cmd | QSPI_RD_SNGL, qspi->dc);
-			ti_qspi_write(qspi, qspi->cmd | QSPI_RD_SNGL,
-				QSPI_SPI_CMD_REG);
+			ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
 			ret = wait_for_completion_timeout(&qspi->transfer_complete,
 					QSPI_COMPLETION_TIMEOUT);
 			if (ret == 0) {
@@ -314,8 +325,7 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 		do {
 			dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n",
 				qspi->cmd | QSPI_RD_SNGL, qspi->dc);
-			ti_qspi_write(qspi, qspi->cmd | QSPI_RD_SNGL,
-				QSPI_SPI_CMD_REG);
+			ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
 			ret = wait_for_completion_timeout(&qspi->transfer_complete,
 					QSPI_COMPLETION_TIMEOUT);
 			if (ret == 0) {
-- 
1.7.1

