From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: avoid uninitialized variable access" to the spi tree
Date: Wed, 09 Nov 2016 15:00:30 +0000
Message-ID: <E1c4UMY-0002ny-Go@finisterre>
References: <20161108134624.1905209-1-arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Hiep Cao Minh <cm-hiep@jinso.co.jp>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108134624.1905209-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: avoid uninitialized variable access

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

>From db30083813b559e98e10ae26bd09d3dc69be7fb7 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 8 Nov 2016 14:46:12 +0100
Subject: [PATCH] spi: rspi: avoid uninitialized variable access

The newly introduced rspi_pio_transfer_in_or_our() function must
take either a valid 'rx' or 'tx' pointer, and has undefined behavior
if both are NULL, as found by 'gcc -Wmaybe-unintialized':

drivers/spi/spi-rspi.c: In function 'rspi_pio_transfer_in_or_our':
drivers/spi/spi-rspi.c:558:5: error: 'len' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The analysis of the function is correct in principle, but the code
is currently safe because both callers always pass exactly one
of the two pointers.

Looking closer at this function shows that having a combined
method for rx and tx here actually increases the complexity
and the size of the file. This simplifies it again by keeping
the two separate, which then ends up avoiding that warning.

Fixes: 3be09bec42a8 ("spi: rspi: supports 32bytes buffer for DUAL and QUAD")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 94 ++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 49 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 3bab75ab1b25..9daf50031737 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -515,51 +515,6 @@ static int rspi_pio_transfer(struct rspi_data *rspi, const u8 *tx, u8 *rx,
 	return 0;
 }
 
-static int rspi_pio_transfer_in_or_our(struct rspi_data *rspi, const u8 *tx,
-				       u8 *rx, unsigned int n)
-{
-	unsigned int i, len;
-	int ret;
-
-	while (n > 0) {
-		if (tx) {
-			len = qspi_set_send_trigger(rspi, n);
-			if (len == QSPI_BUFFER_SIZE) {
-				ret = rspi_wait_for_tx_empty(rspi);
-				if (ret < 0) {
-					dev_err(&rspi->master->dev, "transmit timeout\n");
-					return ret;
-				}
-				for (i = 0; i < len; i++)
-					rspi_write_data(rspi, *tx++);
-			} else {
-				ret = rspi_pio_transfer(rspi, tx, NULL, n);
-				if (ret < 0)
-					return ret;
-			}
-		}
-		if (rx) {
-			len = qspi_set_receive_trigger(rspi, n);
-			if (len == QSPI_BUFFER_SIZE) {
-				ret = rspi_wait_for_rx_full(rspi);
-				if (ret < 0) {
-					dev_err(&rspi->master->dev, "receive timeout\n");
-					return ret;
-				}
-				for (i = 0; i < len; i++)
-					*rx++ = rspi_read_data(rspi);
-			} else {
-				ret = rspi_pio_transfer(rspi, NULL, rx, n);
-				if (ret < 0)
-					return ret;
-				*rx++ = ret;
-			}
-		}
-		n -= len;
-	}
-	return 0;
-}
-
 static void rspi_dma_complete(void *arg)
 {
 	struct rspi_data *rspi = arg;
@@ -831,6 +786,9 @@ static int qspi_transfer_out_in(struct rspi_data *rspi,
 
 static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
 {
+	const u8 *tx = xfer->tx_buf;
+	unsigned int n = xfer->len;
+	unsigned int i, len;
 	int ret;
 
 	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
@@ -839,9 +797,23 @@ static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	ret = rspi_pio_transfer_in_or_our(rspi, xfer->tx_buf, NULL, xfer->len);
-	if (ret < 0)
-		return ret;
+	while (n > 0) {
+		len = qspi_set_send_trigger(rspi, n);
+		if (len == QSPI_BUFFER_SIZE) {
+			ret = rspi_wait_for_tx_empty(rspi);
+			if (ret < 0) {
+				dev_err(&rspi->master->dev, "transmit timeout\n");
+				return ret;
+			}
+			for (i = 0; i < len; i++)
+				rspi_write_data(rspi, *tx++);
+		} else {
+			ret = rspi_pio_transfer(rspi, tx, NULL, n);
+			if (ret < 0)
+				return ret;
+		}
+		n -= len;
+	}
 
 	/* Wait for the last transmission */
 	rspi_wait_for_tx_empty(rspi);
@@ -851,13 +823,37 @@ static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
 
 static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 {
+	u8 *rx = xfer->rx_buf;
+	unsigned int n = xfer->len;
+	unsigned int i, len;
+	int ret;
+
 	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
 		int ret = rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
 		if (ret != -EAGAIN)
 			return ret;
 	}
 
-	return rspi_pio_transfer_in_or_our(rspi, NULL, xfer->rx_buf, xfer->len);
+	while (n > 0) {
+		len = qspi_set_receive_trigger(rspi, n);
+		if (len == QSPI_BUFFER_SIZE) {
+			ret = rspi_wait_for_rx_full(rspi);
+			if (ret < 0) {
+				dev_err(&rspi->master->dev, "receive timeout\n");
+				return ret;
+			}
+			for (i = 0; i < len; i++)
+				*rx++ = rspi_read_data(rspi);
+		} else {
+			ret = rspi_pio_transfer(rspi, NULL, rx, n);
+			if (ret < 0)
+				return ret;
+			*rx++ = ret;
+		}
+		n -= len;
+	}
+
+	return 0;
 }
 
 static int qspi_transfer_one(struct spi_master *master, struct spi_device *spi,
-- 
2.10.2
