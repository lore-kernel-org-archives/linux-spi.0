From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: remove bytes_per_word from private driver struct" to the spi tree
Date: Tue, 06 Jun 2017 20:07:21 +0100
Message-ID: <E1dIJp3-0007bq-Ly@debutante>
References: <20170602053804.3238-6-s.hauer@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        Jiada Wang <jiada_wang@mentor.com>, linux-spi@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602053804.3238-6-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: remove bytes_per_word from private driver struct

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

>From 65017ee2cd69bfd9ccdaa1f61b220e9717408106 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 2 Jun 2017 07:38:03 +0200
Subject: [PATCH] spi: imx: remove bytes_per_word from private driver struct

We already have bits_per_word in the private driver struct and
bytes_per_word can be calculated from it, so remove bits_per_word.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 0ec8d816e033..12e5ef7beb0b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -92,7 +92,6 @@ struct spi_imx_data {
 
 	unsigned int speed_hz;
 	unsigned int bits_per_word;
-	unsigned int bytes_per_word;
 	unsigned int spi_drctl;
 
 	unsigned int count;
@@ -215,9 +214,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (!master->dma_rx)
 		return false;
 
-	bpw = transfer->bits_per_word;
-
-	bpw = spi_imx_bytes_per_word(bpw);
+	bpw = spi_imx_bytes_per_word(transfer->bits_per_word);
 
 	if (bpw != 1 && bpw != 2 && bpw != 4)
 		return false;
@@ -833,15 +830,14 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int spi_imx_dma_configure(struct spi_master *master,
-				 int bytes_per_word)
+static int spi_imx_dma_configure(struct spi_master *master)
 {
 	int ret;
 	enum dma_slave_buswidth buswidth;
 	struct dma_slave_config rx = {}, tx = {};
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	switch (bytes_per_word) {
+	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
 	case 4:
 		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
@@ -875,8 +871,6 @@ static int spi_imx_dma_configure(struct spi_master *master,
 		return ret;
 	}
 
-	spi_imx->bytes_per_word = bytes_per_word;
-
 	return 0;
 }
 
@@ -910,8 +904,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->usedma = 0;
 
 	if (spi_imx->usedma) {
-		ret = spi_imx_dma_configure(spi->master,
-					    spi_imx_bytes_per_word(spi_imx->bits_per_word));
+		ret = spi_imx_dma_configure(spi->master);
 		if (ret)
 			return ret;
 	}
-- 
2.11.0
