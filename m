From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] spi: omap2-mcspi: Convert to let spi core validate
 transfer speed
Date: Tue, 18 Feb 2014 22:02:47 +0800
Message-ID: <1392732167.22192.1.camel@phoenix>
References: <1392732096.22192.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan =?ISO-8859-1?Q?S=F8rensen?=
	<stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>,
	Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392732096.22192.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set master->max_speed_hz and master->min_speed_hz then spi core will handle
checking transfer speed. So we can remove the same checking in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 82cbe73..2941c5b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1212,8 +1212,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 		void		*rx_buf = t->rx_buf;
 		unsigned	len = t->len;
 
-		if (t->speed_hz > OMAP2_MCSPI_MAX_FREQ
-				|| (len && !(rx_buf || tx_buf))) {
+		if ((len && !(rx_buf || tx_buf))) {
 			dev_dbg(mcspi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
 					t->speed_hz,
 					len,
@@ -1222,12 +1221,6 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 					t->bits_per_word);
 			return -EINVAL;
 		}
-		if (t->speed_hz && t->speed_hz < (OMAP2_MCSPI_MAX_FREQ >> 15)) {
-			dev_dbg(mcspi->dev, "speed_hz %d below minimum %d Hz\n",
-					t->speed_hz,
-					OMAP2_MCSPI_MAX_FREQ >> 15);
-			return -EINVAL;
-		}
 
 		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
 			continue;
@@ -1339,6 +1332,8 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->transfer_one_message = omap2_mcspi_transfer_one_message;
 	master->cleanup = omap2_mcspi_cleanup;
 	master->dev.of_node = node;
+	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
+	master->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
 
 	platform_set_drvdata(pdev, master);
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
