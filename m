From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: sirf: fix word width configuration
Date: Mon, 17 Nov 2014 23:17:02 +0800
Message-ID: <1416237423-3606-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

commit 8c328a262f ("spi: sirf: Avoid duplicate code in various
bits_per_word cases") is wrong in setting data width register of
fifo is not right, it should use sspi->word_width >> 1 to set
related bits. According to hardware spec, the mapping between
register value and data width:
0 - byte
1 - WORD
2 - DWORD

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 39e2c0a..f63de78 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -562,9 +562,9 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 	sspi->word_width = DIV_ROUND_UP(bits_per_word, 8);
 	txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
-					   sspi->word_width;
+					   (sspi->word_width >> 1);
 	rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
-					   sspi->word_width;
+					   (sspi->word_width >> 1);
 
 	if (!(spi->mode & SPI_CS_HIGH))
 		regval |= SIRFSOC_SPI_CS_IDLE_STAT;
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
