From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 7/9] spi: tegra20-sflash: Fix checkpatch issue
Date: Tue, 02 Sep 2014 11:53:11 +0900
Message-ID: <002701cfc659$08938bb0$19baa310$%han@samsung.com>
References: <002101cfc658$4f627cf0$ee2776d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Laxman Dewangan' <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002101cfc658$4f627cf0$ee2776d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following checkpatch warnings.

  WARNING: macros should not use a trailing semicolon
  WARNING: Missing a blank line after declarations

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-tegra20-sflash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 3548ce25c08f..cd66fe7b78a9 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -99,7 +99,7 @@
 #define SPI_TX_TRIG_MASK		(0x3 << 16)
 #define SPI_TX_TRIG_1W			(0x0 << 16)
 #define SPI_TX_TRIG_4W			(0x1 << 16)
-#define SPI_DMA_BLK_COUNT(count)	(((count) - 1) & 0xFFFF);
+#define SPI_DMA_BLK_COUNT(count)	(((count) - 1) & 0xFFFF)
 
 #define SPI_TX_FIFO			0x10
 #define SPI_RX_FIFO			0x20
@@ -221,6 +221,7 @@ static int tegra_sflash_read_rx_fifo_to_client_rxbuf(
 	while (!(status & SPI_RXF_EMPTY)) {
 		int i;
 		u32 x = tegra_sflash_readl(tsd, SPI_RX_FIFO);
+
 		for (i = 0; (i < tsd->bytes_per_word); i++)
 			*rx_buf++ = (x >> (i*8)) & 0xFF;
 		read_words++;
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
