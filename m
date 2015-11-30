From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: Prevent duplicate gpio_request
Date: Mon, 30 Nov 2015 09:02:39 -0600
Message-ID: <1448895759-4282-1-git-send-email-mwelling@ieee.org>
Cc: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joseph Bell <joe-frEo4xfazcg+9D430DZnzg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Occasionally the setup function will be called multiple times. Only request
the gpio the first time otherwise -EBUSY will occur on subsequent calls to
setup.

Reported-by: Joseph Bell <joe-frEo4xfazcg+9D430DZnzg@public.gmane.org>

Signed-off-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 02aa1d0..7273820 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1025,6 +1025,16 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		spi->controller_state = cs;
 		/* Link this to context save list */
 		list_add_tail(&cs->node, &ctx->cs);
+
+		if (gpio_is_valid(spi->cs_gpio)) {
+			ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
+			if (ret) {
+				dev_err(&spi->dev, "failed to request gpio\n");
+				return ret;
+			}
+			gpio_direction_output(spi->cs_gpio,
+					 !(spi->mode & SPI_CS_HIGH));
+		}
 	}
 
 	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx) {
@@ -1033,15 +1043,6 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 			return ret;
 	}
 
-	if (gpio_is_valid(spi->cs_gpio)) {
-		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
-		if (ret) {
-			dev_err(&spi->dev, "failed to request gpio\n");
-			return ret;
-		}
-		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
-	}
-
 	ret = pm_runtime_get_sync(mcspi->dev);
 	if (ret < 0)
 		return ret;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
