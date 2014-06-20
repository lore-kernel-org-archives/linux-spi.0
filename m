From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/5] spi: sh-msiof: Refactor sh_msiof_transfer_one()
Date: Fri, 20 Jun 2014 12:16:19 +0200
Message-ID: <1403259380-13634-5-git-send-email-geert+renesas@glider.be>
References: <1403259380-13634-1-git-send-email-geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1403259380-13634-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

  - Move buffer pointer and length setup to the top,
  - Make unsigned values unsigned,
  - Loop over words and increment pointers instead of recalculating them,
    which allows to kill bytes_done.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 29dee0436a9a..ef831f1c1803 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -616,16 +616,17 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(master);
 	void (*tx_fifo)(struct sh_msiof_spi_priv *, const void *, int, int);
 	void (*rx_fifo)(struct sh_msiof_spi_priv *, void *, int, int);
-	int bits;
-	int bytes_per_word;
-	int bytes_done;
-	int words;
+	const void *tx_buf = t->tx_buf;
+	void *rx_buf = t->rx_buf;
+	unsigned int len = t->len;
+	unsigned int bits = t->bits_per_word;
+	unsigned int bytes_per_word;
+	unsigned int words;
 	int n;
 	bool swab;
 
-	bits = t->bits_per_word;
 
-	if (bits <= 8 && t->len > 15 && !(t->len & 3)) {
+	if (bits <= 8 && len > 15 && !(len & 3)) {
 		bits = 32;
 		swab = true;
 	} else {
@@ -639,34 +640,34 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 		rx_fifo = sh_msiof_spi_read_fifo_8;
 	} else if (bits <= 16) {
 		bytes_per_word = 2;
-		if ((unsigned long)t->tx_buf & 0x01)
+		if ((unsigned long)tx_buf & 0x01)
 			tx_fifo = sh_msiof_spi_write_fifo_16u;
 		else
 			tx_fifo = sh_msiof_spi_write_fifo_16;
 
-		if ((unsigned long)t->rx_buf & 0x01)
+		if ((unsigned long)rx_buf & 0x01)
 			rx_fifo = sh_msiof_spi_read_fifo_16u;
 		else
 			rx_fifo = sh_msiof_spi_read_fifo_16;
 	} else if (swab) {
 		bytes_per_word = 4;
-		if ((unsigned long)t->tx_buf & 0x03)
+		if ((unsigned long)tx_buf & 0x03)
 			tx_fifo = sh_msiof_spi_write_fifo_s32u;
 		else
 			tx_fifo = sh_msiof_spi_write_fifo_s32;
 
-		if ((unsigned long)t->rx_buf & 0x03)
+		if ((unsigned long)rx_buf & 0x03)
 			rx_fifo = sh_msiof_spi_read_fifo_s32u;
 		else
 			rx_fifo = sh_msiof_spi_read_fifo_s32;
 	} else {
 		bytes_per_word = 4;
-		if ((unsigned long)t->tx_buf & 0x03)
+		if ((unsigned long)tx_buf & 0x03)
 			tx_fifo = sh_msiof_spi_write_fifo_32u;
 		else
 			tx_fifo = sh_msiof_spi_write_fifo_32;
 
-		if ((unsigned long)t->rx_buf & 0x03)
+		if ((unsigned long)rx_buf & 0x03)
 			rx_fifo = sh_msiof_spi_read_fifo_32u;
 		else
 			rx_fifo = sh_msiof_spi_read_fifo_32;
@@ -676,20 +677,18 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
 
 	/* transfer in fifo sized chunks */
-	words = t->len / bytes_per_word;
-	bytes_done = 0;
-
-	while (bytes_done < t->len) {
-		void *rx_buf = t->rx_buf ? t->rx_buf + bytes_done : NULL;
-		const void *tx_buf = t->tx_buf ? t->tx_buf + bytes_done : NULL;
-		n = sh_msiof_spi_txrx_once(p, tx_fifo, rx_fifo,
-					   tx_buf,
-					   rx_buf,
+	words = len / bytes_per_word;
+
+	while (words > 0) {
+		n = sh_msiof_spi_txrx_once(p, tx_fifo, rx_fifo, tx_buf, rx_buf,
 					   words, bits);
 		if (n < 0)
 			return n;
 
-		bytes_done += n * bytes_per_word;
+		if (tx_buf)
+			tx_buf += n * bytes_per_word;
+		if (rx_buf)
+			rx_buf += n * bytes_per_word;
 		words -= n;
 	}
 
-- 
1.9.1

