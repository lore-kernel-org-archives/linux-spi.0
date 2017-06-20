From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] spi: imx: Check for allocation failure earlier
Date: Tue, 20 Jun 2017 13:50:55 -0300
Message-ID: <1497977455-15964-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In case of spi_alloc_master() failure it is better to return the
error immediately, so move the error check right after the allocation.

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-imx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e544f45..f9698b7 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1169,15 +1169,15 @@ static int spi_imx_probe(struct platform_device *pdev)
 	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
+	if (!master)
+		return -ENOMEM;
+
 	ret = of_property_read_u32(np, "fsl,spi-rdy-drctl", &spi_drctl);
 	if ((ret < 0) || (spi_drctl >= 0x3)) {
 		/* '11' is reserved */
 		spi_drctl = 0;
 	}
 
-	if (!master)
-		return -ENOMEM;
-
 	platform_set_drvdata(pdev, master);
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
