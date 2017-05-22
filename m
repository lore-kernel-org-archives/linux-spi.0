From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH linux-next 1/1] spi: imx: only allow dynamic burst in PIO mode
Date: Mon, 22 May 2017 13:51:55 +0900
Message-ID: <20170522045155.9406-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently only PIO mode supports dynamic burst length adjust,
in DMA mode, bpw (bytes per word) value still has to be used
as burst length, other wise transfer issue will be caused.

This patch avoid using dynamic burst in DMA mode by set
reset dynamic_burst when DMA mode is used.

Signed-off-by: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Reported-and-tested-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 19b30cf..2768e64 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -242,6 +242,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 		return false;
 
 	spi_imx->wml = i;
+	spi_imx->dynamic_burst = 0;
 
 	return true;
 }
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
