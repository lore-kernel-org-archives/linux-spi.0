From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] spi: davinci: fix to support more than 2 chip selects
Date: Thu, 31 Jul 2014 20:33:14 +0300
Message-ID: <1406827995-30913-2-git-send-email-grygorii.strashko@ti.com>
References: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>,
	Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406827995-30913-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>

Currently, the driver defines SPI_MAX_CHIPSELECT as 2 and
use per device array bytes_per_word based on this. This breaks
if num_chipselect per device is greater than 2. This patch
fix this and allocate memory for this array based on
num_chipselect.

It's preparation patch to enable GPIO CS feature for
Davinci SPI.

Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-davinci.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 50f7509..2477af4 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -38,8 +38,6 @@
 
 #define SPI_NO_RESOURCE		((resource_size_t)-1)
 
-#define SPI_MAX_CHIPSELECT	2
-
 #define CS_DEFAULT	0xFF
 
 #define SPIFMT_PHASE_MASK	BIT(16)
@@ -142,7 +140,7 @@ struct davinci_spi {
 	void			(*get_rx)(u32 rx_data, struct davinci_spi *);
 	u32			(*get_tx)(struct davinci_spi *);
 
-	u8			bytes_per_word[SPI_MAX_CHIPSELECT];
+	u8			*bytes_per_word;
 };
 
 static struct davinci_spi_config davinci_spi_default_cfg;
@@ -876,6 +874,14 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	/* pdata in dspi is now updated and point pdata to that */
 	pdata = &dspi->pdata;
 
+	dspi->bytes_per_word = devm_kzalloc(&pdev->dev,
+					    sizeof(*dspi->bytes_per_word) *
+					    pdata->num_chipselect, GFP_KERNEL);
+	if (dspi->bytes_per_word == NULL) {
+		ret = -ENOMEM;
+		goto free_master;
+	}
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		ret = -ENOENT;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
