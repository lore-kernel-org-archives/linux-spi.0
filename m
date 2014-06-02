From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 01/18] spi: rspi: Extract rspi_wait_for_{tx_empty,rx_full}()
Date: Mon,  2 Jun 2014 15:38:03 +0200
Message-ID: <1401716301-29612-2-git-send-email-geert+renesas@glider.be>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 5639f9529e0b..d04a4acce231 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -405,11 +405,22 @@ static int rspi_wait_for_interrupt(struct rspi_data *rspi, u8 wait_mask,
 	return 0;
 }
 
+static inline int rspi_wait_for_tx_empty(struct rspi_data *rspi)
+{
+	return rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
+}
+
+static inline int rspi_wait_for_rx_full(struct rspi_data *rspi)
+{
+	return rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE);
+}
+
 static int rspi_data_out(struct rspi_data *rspi, u8 data)
 {
-	if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE) < 0) {
+	int error = rspi_wait_for_tx_empty(rspi);
+	if (error < 0) {
 		dev_err(&rspi->master->dev, "transmit timeout\n");
-		return -ETIMEDOUT;
+		return error;
 	}
 	rspi_write_data(rspi, data);
 	return 0;
@@ -417,11 +428,13 @@ static int rspi_data_out(struct rspi_data *rspi, u8 data)
 
 static int rspi_data_in(struct rspi_data *rspi)
 {
+	int error;
 	u8 data;
 
-	if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
+	error = rspi_wait_for_rx_full(rspi);
+	if (error < 0) {
 		dev_err(&rspi->master->dev, "receive timeout\n");
-		return -ETIMEDOUT;
+		return error;
 	}
 	data = rspi_read_data(rspi);
 	return data;
@@ -737,7 +750,7 @@ static int rspi_transfer_out_in(struct rspi_data *rspi,
 	}
 
 	/* Wait for the last transmission */
-	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
+	rspi_wait_for_tx_empty(rspi);
 
 	return 0;
 }
@@ -783,7 +796,7 @@ static int rspi_rz_transfer_out_in(struct rspi_data *rspi,
 	}
 
 	/* Wait for the last transmission */
-	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
+	rspi_wait_for_tx_empty(rspi);
 
 	return 0;
 }
@@ -818,7 +831,7 @@ static int qspi_transfer_out_in(struct rspi_data *rspi,
 	}
 
 	/* Wait for the last transmission */
-	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
+	rspi_wait_for_tx_empty(rspi);
 
 	return 0;
 }
@@ -836,7 +849,7 @@ static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
 	}
 
 	/* Wait for the last transmission */
-	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
+	rspi_wait_for_tx_empty(rspi);
 
 	return 0;
 }
-- 
1.9.1

