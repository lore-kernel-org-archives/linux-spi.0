From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH v4 2/2] spi: omap2-mcspi: Add gpio_request and init CS
Date: Thu,  7 May 2015 18:36:54 -0500
Message-ID: <1431041814-24757-3-git-send-email-mwelling@ieee.org>
References: <1431041814-24757-1-git-send-email-mwelling@ieee.org>
Cc: Michael Welling <mwelling@ieee.org>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431041814-24757-1-git-send-email-mwelling@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If GPIO chipselects are specified initialise the GPIO in the setup function.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/spi/spi-omap2-mcspi.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 3ac06ad..370c333 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -35,6 +35,7 @@
 #include <linux/gcd.h>
 
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
@@ -1015,6 +1016,12 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	if (gpio_is_valid(spi->cs_gpio)) {
+		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
+			gpio_direction_output(spi->cs_gpio,
+			!(spi->mode & SPI_CS_HIGH));
+	}
+
 	ret = omap2_mcspi_setup_transfer(spi, NULL);
 	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
-- 
1.7.9.5
