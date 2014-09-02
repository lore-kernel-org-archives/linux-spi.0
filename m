From: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Subject: [PATCH 7/8] spi: sirf: cleanup the indentation of marcos
Date: Tue, 2 Sep 2014 17:02:36 +0800
Message-ID: <1409648557-5470-3-git-send-email-Barry.Song@csr.com>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409648557-5470-1-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

let "#define" statement keep same indentation. the old code layout is
pretty ugly.

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 74835c2..67d07b2 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -62,15 +62,15 @@
 #define SIRFSOC_SPI_TRAN_DAT_FORMAT_12	(1 << 26)
 #define SIRFSOC_SPI_TRAN_DAT_FORMAT_16	(2 << 26)
 #define SIRFSOC_SPI_TRAN_DAT_FORMAT_32	(3 << 26)
-#define SIRFSOC_SPI_CMD_BYTE_NUM(x)		((x & 3) << 28)
-#define SIRFSOC_SPI_ENA_AUTO_CLR		BIT(30)
-#define SIRFSOC_SPI_MUL_DAT_MODE		BIT(31)
+#define SIRFSOC_SPI_CMD_BYTE_NUM(x)	((x & 3) << 28)
+#define SIRFSOC_SPI_ENA_AUTO_CLR	BIT(30)
+#define SIRFSOC_SPI_MUL_DAT_MODE	BIT(31)
 
 /* Interrupt Enable */
-#define SIRFSOC_SPI_RX_DONE_INT_EN		BIT(0)
-#define SIRFSOC_SPI_TX_DONE_INT_EN		BIT(1)
-#define SIRFSOC_SPI_RX_OFLOW_INT_EN		BIT(2)
-#define SIRFSOC_SPI_TX_UFLOW_INT_EN		BIT(3)
+#define SIRFSOC_SPI_RX_DONE_INT_EN	BIT(0)
+#define SIRFSOC_SPI_TX_DONE_INT_EN	BIT(1)
+#define SIRFSOC_SPI_RX_OFLOW_INT_EN	BIT(2)
+#define SIRFSOC_SPI_TX_UFLOW_INT_EN	BIT(3)
 #define SIRFSOC_SPI_RX_IO_DMA_INT_EN	BIT(4)
 #define SIRFSOC_SPI_TX_IO_DMA_INT_EN	BIT(5)
 #define SIRFSOC_SPI_RXFIFO_FULL_INT_EN	BIT(6)
@@ -79,7 +79,7 @@
 #define SIRFSOC_SPI_TXFIFO_THD_INT_EN	BIT(9)
 #define SIRFSOC_SPI_FRM_END_INT_EN	BIT(10)
 
-#define SIRFSOC_SPI_INT_MASK_ALL		0x1FFF
+#define SIRFSOC_SPI_INT_MASK_ALL	0x1FFF
 
 /* Interrupt status */
 #define SIRFSOC_SPI_RX_DONE		BIT(0)
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
