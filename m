From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 6/6] spi: imx: rename 'bpw' variables
Date: Fri,  2 Jun 2017 07:38:04 +0200
Message-ID: <20170602053804.3238-7-s.hauer@pengutronix.de>
References: <20170602053804.3238-1-s.hauer@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        Jiada Wang <jiada_wang@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602053804.3238-1-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

'bpw' is ambiguous and only the context makes sure if bytes_per_word
or bits_per_word is meant. Use the full names instead to make reading
the code easier.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 12e5ef7beb0b..e544f45348cc 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -200,27 +200,27 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 	return i;
 }
 
-static int spi_imx_bytes_per_word(const int bpw)
+static int spi_imx_bytes_per_word(const int bits_per_word)
 {
-	return DIV_ROUND_UP(bpw, BITS_PER_BYTE);
+	return DIV_ROUND_UP(bits_per_word, BITS_PER_BYTE);
 }
 
 static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 			 struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
-	unsigned int bpw, i;
+	unsigned int bytes_per_word, i;
 
 	if (!master->dma_rx)
 		return false;
 
-	bpw = spi_imx_bytes_per_word(transfer->bits_per_word);
+	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
 
-	if (bpw != 1 && bpw != 2 && bpw != 4)
+	if (bytes_per_word != 1 && bytes_per_word != 2 && bytes_per_word != 4)
 		return false;
 
 	for (i = spi_imx_get_fifosize(spi_imx) / 2; i > 0; i--) {
-		if (!(transfer->len % (i * bpw)))
+		if (!(transfer->len % (i * bytes_per_word)))
 			break;
 	}
 
-- 
2.11.0
