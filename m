From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] spi: imx: fix little-endian build
Date: Wed, 23 Aug 2017 15:34:43 +0200
Message-ID: <20170823133452.796321-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        jiada wang <jiada_wang@mentor.com>,
        Martin Kaiser <martin@kaiser.cx>, Marek Vasut <marex@denx.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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
2.9.0
