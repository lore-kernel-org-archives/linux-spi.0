From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: sirf: assign spi_master's max_speed_hz member
Date: Mon, 17 Nov 2014 23:17:03 +0800
Message-ID: <1416237423-3606-2-git-send-email-21cnbao@gmail.com>
References: <1416237423-3606-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416237423-3606-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

if spi device has no frequency, spi core will setup the default frequency
to max_speed_hz of spi_master according to
int spi_setup(struct spi_device *spi)
{
	...
        if (!spi->max_speed_hz)
                spi->max_speed_hz = spi->master->max_speed_hz;
	...
}
this patch moves CSR SiRFSoC SPI frequency set to follow SPI core behaviour.

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index f63de78..90dc05b 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -134,6 +134,7 @@
 	ALIGNED(x->len) && (x->len < 2 * PAGE_SIZE))
 
 #define SIRFSOC_MAX_CMD_BYTES	4
+#define SIRFSOC_SPI_DEFAULT_FRQ 1000000
 
 struct sirfsoc_spi {
 	struct spi_bitbang bitbang;
@@ -629,9 +630,6 @@ static int spi_sirfsoc_setup(struct spi_device *spi)
 {
 	struct sirfsoc_spi *sspi;
 
-	if (!spi->max_speed_hz)
-		return -EINVAL;
-
 	sspi = spi_master_get_devdata(spi->master);
 
 	if (spi->cs_gpio == -ENOENT)
@@ -683,6 +681,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(12) |
 					SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
+	master->max_speed_hz = SIRFSOC_SPI_DEFAULT_FRQ;
 	sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
 
 	/* request DMA channels */
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
