From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: spidev: Use "%u" to format __u32
Date: Mon, 30 Nov 2015 15:19:06 +0100
Message-ID: <1448893146-8795-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 64-bit with CONFIG_SPI_DEBUG=y and #define VERBOSE:

    drivers/spi/spidev.c:287:3: warning: format '%zd' expects argument of type 'signed size_t', but argument 4 has type '__u32' [-Wformat=]

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 91a0fcd724230809..9a8e47c452f40cb6 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -284,7 +284,7 @@ static int spidev_message(struct spidev_data *spidev,
 			k_tmp->speed_hz = spidev->speed_hz;
 #ifdef VERBOSE
 		dev_dbg(&spidev->spi->dev,
-			"  xfer len %zd %s%s%s%dbits %u usec %uHz\n",
+			"  xfer len %u %s%s%s%dbits %u usec %uHz\n",
 			u_tmp->len,
 			u_tmp->rx_buf ? "rx " : "",
 			u_tmp->tx_buf ? "tx " : "",
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
