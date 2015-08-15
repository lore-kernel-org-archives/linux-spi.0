From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Fix FIFO size to 64 word from 256 word" to the spi tree
Date: Sat, 15 Aug 2015 09:22:53 -0700
Message-ID: <E1ZQeEP-0007b7-51@finisterre>
References: <1434302705-31104-1-git-send-email-ykaneko0929@gmail.com>
Cc: linux-spi@vger.kernel.org
To: Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
	Yoshihiro Kaneko <ykaneko0929@gmail.com>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1434302705-31104-1-git-send-email-ykaneko0929@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Fix FIFO size to 64 word from 256 word

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

>From 8ed545ee4d491d6f2762024524842fe029c4ae86 Mon Sep 17 00:00:00 2001
From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Date: Mon, 15 Jun 2015 02:25:05 +0900
Subject: [PATCH] spi: sh-msiof: Fix FIFO size to 64 word from 256 word

The upper limit of Tx/Rx FIFO size is 64 word by the
specification of H/W. This patch corrects to 64 word from 256 word.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-sh-msiof.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 118c652..a7934ab 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -48,8 +48,8 @@ struct sh_msiof_spi_priv {
 	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
 	struct completion done;
-	int tx_fifo_size;
-	int rx_fifo_size;
+	unsigned int tx_fifo_size;
+	unsigned int rx_fifo_size;
 	void *tx_dma_page;
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
@@ -95,8 +95,6 @@ struct sh_msiof_spi_priv {
 #define MDR2_WDLEN1(i)	(((i) - 1) << 16) /* Word Count (1-64/256 (SH, A1))) */
 #define MDR2_GRPMASK1	0x00000001 /* Group Output Mask 1 (SH, A1) */
 
-#define MAX_WDLEN	256U
-
 /* TSCR and RSCR */
 #define SCR_BRPS_MASK	    0x1f00 /* Prescaler Setting (1-32) */
 #define SCR_BRPS(i)	(((i) - 1) << 8)
@@ -850,7 +848,12 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 		 *  DMA supports 32-bit words only, hence pack 8-bit and 16-bit
 		 *  words, with byte resp. word swapping.
 		 */
-		unsigned int l = min(len, MAX_WDLEN * 4);
+		unsigned int l = 0;
+
+		if (tx_buf)
+			l = min(len, p->tx_fifo_size * 4);
+		if (rx_buf)
+			l = min(len, p->rx_fifo_size * 4);
 
 		if (bits <= 8) {
 			if (l & 3)
@@ -963,7 +966,7 @@ static const struct sh_msiof_chipdata sh_data = {
 
 static const struct sh_msiof_chipdata r8a779x_data = {
 	.tx_fifo_size = 64,
-	.rx_fifo_size = 256,
+	.rx_fifo_size = 64,
 	.master_flags = SPI_MASTER_MUST_TX,
 };
 
-- 
2.5.0
