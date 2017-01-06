From: <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] spi: imx: adjust watermark level according to transfer length
Date: Fri, 6 Jan 2017 04:22:18 -0800
Message-ID: <1483705338-3797-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

Previously DMA watermark level is configured to fifosize/2,
DMA mode can be used only when transfer length can be divided
by 'watermark level * bpw', which makes DMA mode not pratical.

This patch adjusts watermark level to largest number (no bigger
than fifosize/2) which can divide 'tranfer length / bpw' for
each transfer.

Signed-off-by: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-imx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 32ced64..9a7c62f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -211,7 +211,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 			 struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
-	unsigned int bpw;
+	unsigned int bpw, i;
 
 	if (!master->dma_rx)
 		return false;
@@ -228,12 +228,16 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (bpw != 1 && bpw != 2 && bpw != 4)
 		return false;
 
-	if (transfer->len < spi_imx->wml * bpw)
-		return false;
+	for (i = spi_imx_get_fifosize(spi_imx) / 2; i > 0; i--) {
+		if (!(transfer->len % (i * bpw)))
+			break;
+	}
 
-	if (transfer->len % (spi_imx->wml * bpw))
+	if (i == 0)
 		return false;
 
+	spi_imx->wml = i;
+
 	return true;
 }
 
@@ -837,10 +841,6 @@ static int spi_imx_dma_configure(struct spi_master *master,
 	struct dma_slave_config rx = {}, tx = {};
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	if (bytes_per_word == spi_imx->bytes_per_word)
-		/* Same as last time */
-		return 0;
-
 	switch (bytes_per_word) {
 	case 4:
 		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
