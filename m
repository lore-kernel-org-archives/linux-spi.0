From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] spi: rspi: Drop variable "error" in qspi_trigger_transfer_out_in()
Date: Tue, 23 Jun 2015 15:04:28 +0200
Message-ID: <1435064669-11969-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Just use "ret" instead, for consistency with other similar functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 3e82b84c9ed48b2f..f368d8f3dce869bb 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -725,24 +725,23 @@ static int qspi_trigger_transfer_out_in(struct rspi_data *rspi, const u8 *tx,
 					u8 *rx, unsigned int len)
 {
 	int i, n, ret;
-	int error;
 
 	while (len > 0) {
 		n = qspi_set_send_trigger(rspi, len);
 		qspi_set_receive_trigger(rspi, len);
 		if (n == QSPI_BUFFER_SIZE) {
-			error = rspi_wait_for_tx_empty(rspi);
-			if (error < 0) {
+			ret = rspi_wait_for_tx_empty(rspi);
+			if (ret < 0) {
 				dev_err(&rspi->master->dev, "transmit timeout\n");
-				return error;
+				return ret;
 			}
 			for (i = 0; i < n; i++)
 				rspi_write_data(rspi, *tx++);
 
-			error = rspi_wait_for_rx_full(rspi);
-			if (error < 0) {
+			ret = rspi_wait_for_rx_full(rspi);
+			if (ret < 0) {
 				dev_err(&rspi->master->dev, "receive timeout\n");
-				return error;
+				return ret;
 			}
 			for (i = 0; i < n; i++)
 				*rx++ = rspi_read_data(rspi);
-- 
1.9.1

