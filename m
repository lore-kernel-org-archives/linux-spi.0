From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [PATCH] spi: st-ssc4: whitespace cleanup
Date: Thu, 25 May 2017 16:05:05 +1200
Message-ID: <20170525040505.30633-1-chris.packham@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove stray single spaces after a leading hard-tab.

Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
---
 drivers/spi/spi-st-ssc4.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index e54b59638458..a4e43fc19ece 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -229,42 +229,42 @@ static int spi_st_setup(struct spi_device *spi)
 		"setting baudrate:target= %u hz, actual= %u hz, sscbrg= %u\n",
 		hz, spi_st->baud, sscbrg);
 
-	 /* Set SSC_CTL and enable SSC */
-	 var = readl_relaxed(spi_st->base + SSC_CTL);
-	 var |= SSC_CTL_MS;
+	/* Set SSC_CTL and enable SSC */
+	var = readl_relaxed(spi_st->base + SSC_CTL);
+	var |= SSC_CTL_MS;
 
-	 if (spi->mode & SPI_CPOL)
+	if (spi->mode & SPI_CPOL)
 		var |= SSC_CTL_PO;
-	 else
+	else
 		var &= ~SSC_CTL_PO;
 
-	 if (spi->mode & SPI_CPHA)
+	if (spi->mode & SPI_CPHA)
 		var |= SSC_CTL_PH;
-	 else
+	else
 		var &= ~SSC_CTL_PH;
 
-	 if ((spi->mode & SPI_LSB_FIRST) == 0)
+	if ((spi->mode & SPI_LSB_FIRST) == 0)
 		var |= SSC_CTL_HB;
-	 else
+	else
 		var &= ~SSC_CTL_HB;
 
-	 if (spi->mode & SPI_LOOP)
+	if (spi->mode & SPI_LOOP)
 		var |= SSC_CTL_LPB;
-	 else
+	else
 		var &= ~SSC_CTL_LPB;
 
-	 var &= ~SSC_CTL_DATA_WIDTH_MSK;
-	 var |= (spi->bits_per_word - 1);
+	var &= ~SSC_CTL_DATA_WIDTH_MSK;
+	var |= (spi->bits_per_word - 1);
 
-	 var |= SSC_CTL_EN_TX_FIFO | SSC_CTL_EN_RX_FIFO;
-	 var |= SSC_CTL_EN;
+	var |= SSC_CTL_EN_TX_FIFO | SSC_CTL_EN_RX_FIFO;
+	var |= SSC_CTL_EN;
 
-	 writel_relaxed(var, spi_st->base + SSC_CTL);
+	writel_relaxed(var, spi_st->base + SSC_CTL);
 
-	 /* Clear the status register */
-	 readl_relaxed(spi_st->base + SSC_RBUF);
+	/* Clear the status register */
+	readl_relaxed(spi_st->base + SSC_RBUF);
 
-	 return 0;
+	return 0;
 
 out_free_gpio:
 	gpio_free(cs);
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
