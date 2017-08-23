From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: fix little-endian build" to the spi tree
Date: Wed, 23 Aug 2017 16:54:35 +0100
Message-ID: <E1dkXzH-0005Yt-2H@debutante>
References: <20170823133452.796321-1-arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        jiada wang <jiada_wang@mentor.com>,
        Martin Kaiser <martin@kaiser.cx>, Marek Vasut <marex@denx.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823133452.796321-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: fix little-endian build

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

>From 5904c9d3c9bd52f79718d1806175271b4bd20718 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 23 Aug 2017 15:34:43 +0200
Subject: [PATCH] spi: imx: fix little-endian build

The newly added dynamic burst code produces a harmless warning
on big-endian configurations:

drivers/spi/spi-imx.c: In function 'spi_imx_buf_rx_swap_u32':
drivers/spi/spi-imx.c:284:15: error: unused variable 'bytes_per_word' [-Werror=unused-variable]
  unsigned int bytes_per_word;
               ^~~~~~~~~~~~~~
drivers/spi/spi-imx.c: In function 'spi_imx_buf_tx_swap_u32':
drivers/spi/spi-imx.c:319:15: error: unused variable 'bytes_per_word' [-Werror=unused-variable]
  unsigned int bytes_per_word;

This adds another #ifdef around the variable declaration matching
the one on the use.

Fixes: 1673c81d9435 ("spi: imx: dynamic burst length adjust for PIO mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index cc808a1c765c..6fcb6adf9565 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -281,7 +281,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
 {
 	unsigned int val = readl(spi_imx->base + MXC_CSPIRXDATA);
+#ifdef __LITTLE_ENDIAN
 	unsigned int bytes_per_word;
+#endif
 
 	if (spi_imx->rx_buf) {
 #ifdef __LITTLE_ENDIAN
@@ -316,7 +318,9 @@ static void spi_imx_buf_rx_swap(struct spi_imx_data *spi_imx)
 static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
 {
 	u32 val = 0;
+#ifdef __LITTLE_ENDIAN
 	unsigned int bytes_per_word;
+#endif
 
 	if (spi_imx->tx_buf) {
 		val = *(u32 *)spi_imx->tx_buf;
-- 
2.14.1
