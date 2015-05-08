From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH v2] spi: omap2-mcspi: Add gpio_request and init CS
Date: Fri,  8 May 2015 13:31:01 -0500
Message-ID: <1431109861-6853-1-git-send-email-mwelling@ieee.org>
Cc: Michael Welling <mwelling@ieee.org>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If GPIO chip select is specified, request the GPIO in the setup function
and release it in the cleanup function.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---

v2: Adds gpio_free to cleanup function.

Broken out of patch series because the other patch in the series was applied.
commit	b28cb9414db9f8e42ac18c9e360e4e99cda42489

This patch applies on top of that one.

 drivers/spi/spi-omap2-mcspi.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 3ac06ad..90cf7e7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -35,6 +35,7 @@
 #include <linux/gcd.h>
 
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
@@ -1011,6 +1012,12 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 			return ret;
 	}
 
+	if (gpio_is_valid(spi->cs_gpio)) {
+		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
+			gpio_direction_output(spi->cs_gpio,
+			!(spi->mode & SPI_CS_HIGH));
+	}
+
 	ret = pm_runtime_get_sync(mcspi->dev);
 	if (ret < 0)
 		return ret;
@@ -1050,6 +1057,9 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 			mcspi_dma->dma_tx = NULL;
 		}
 	}
+
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_free(spi->cs_gpio);
 }
 
 static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
-- 
1.7.9.5
