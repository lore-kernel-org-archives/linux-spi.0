From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: supports 32bytes buffer for DUAL and QUAD" to the spi tree
Date: Fri, 04 Nov 2016 11:23:41 -0600
Message-ID: <E1c2iDN-0006rC-Am@finisterre>
References: <1478248734-32044-2-git-send-email-cm-hiep@jinso.co.jp>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        geert+renesas@glider.be, linux-spi@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        ryusuke.sakato.bx@renesas.com, linux-renesas-soc@vger.kernel.org,
        nv-dung@jinso.co.jp, h-inayoshi@jinso.co.jp,
        linux-spi@vger.kernel.org
To: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1478248734-32044-2-git-send-email-cm-hiep@jinso.co.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: supports 32bytes buffer for DUAL and QUAD

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

>From 3be09bec42a800d4f8ead8119c462f3eb4fad435 Mon Sep 17 00:00:00 2001
From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Date: Fri, 4 Nov 2016 17:38:54 +0900
Subject: [PATCH] spi: rspi: supports 32bytes buffer for DUAL and QUAD

This patch supports 32bytes of buffer for DUAL and QUAD in QSPI by
Using Transmit/Receive Buffer Data Triggering Number.
In order to improve the DUAL and QUAD's performance of SPI
while transferring data in PIO mode, it sends/receives each 32bytes
data instead of each byte data as current situation.

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a816f07e168e..3bab75ab1b25 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -413,7 +413,7 @@ static unsigned int qspi_set_send_trigger(struct rspi_data *rspi,
 	return n;
 }
 
-static void qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
+static int qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
 {
 	unsigned int n;
 
@@ -428,6 +428,7 @@ static void qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
 		qspi_update(rspi, SPBFCR_RXTRG_MASK,
 			     SPBFCR_RXTRG_1B, QSPI_SPBFCR);
 	}
+	return n;
 }
 
 #define set_config_register(spi, n) spi->ops->set_config_register(spi, n)
@@ -514,6 +515,51 @@ static int rspi_pio_transfer(struct rspi_data *rspi, const u8 *tx, u8 *rx,
 	return 0;
 }
 
+static int rspi_pio_transfer_in_or_our(struct rspi_data *rspi, const u8 *tx,
+				       u8 *rx, unsigned int n)
+{
+	unsigned int i, len;
+	int ret;
+
+	while (n > 0) {
+		if (tx) {
+			len = qspi_set_send_trigger(rspi, n);
+			if (len == QSPI_BUFFER_SIZE) {
+				ret = rspi_wait_for_tx_empty(rspi);
+				if (ret < 0) {
+					dev_err(&rspi->master->dev, "transmit timeout\n");
+					return ret;
+				}
+				for (i = 0; i < len; i++)
+					rspi_write_data(rspi, *tx++);
+			} else {
+				ret = rspi_pio_transfer(rspi, tx, NULL, n);
+				if (ret < 0)
+					return ret;
+			}
+		}
+		if (rx) {
+			len = qspi_set_receive_trigger(rspi, n);
+			if (len == QSPI_BUFFER_SIZE) {
+				ret = rspi_wait_for_rx_full(rspi);
+				if (ret < 0) {
+					dev_err(&rspi->master->dev, "receive timeout\n");
+					return ret;
+				}
+				for (i = 0; i < len; i++)
+					*rx++ = rspi_read_data(rspi);
+			} else {
+				ret = rspi_pio_transfer(rspi, NULL, rx, n);
+				if (ret < 0)
+					return ret;
+				*rx++ = ret;
+			}
+		}
+		n -= len;
+	}
+	return 0;
+}
+
 static void rspi_dma_complete(void *arg)
 {
 	struct rspi_data *rspi = arg;
@@ -793,7 +839,7 @@ static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	ret = rspi_pio_transfer(rspi, xfer->tx_buf, NULL, xfer->len);
+	ret = rspi_pio_transfer_in_or_our(rspi, xfer->tx_buf, NULL, xfer->len);
 	if (ret < 0)
 		return ret;
 
@@ -811,7 +857,7 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	return rspi_pio_transfer(rspi, NULL, xfer->rx_buf, xfer->len);
+	return rspi_pio_transfer_in_or_our(rspi, NULL, xfer->rx_buf, xfer->len);
 }
 
 static int qspi_transfer_one(struct spi_master *master, struct spi_device *spi,
-- 
2.10.1
