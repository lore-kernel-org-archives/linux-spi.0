From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] spi: davinci: fix SPI_NO_CS functionality
Date: Thu, 21 Aug 2014 18:25:05 +0300
Message-ID: <1408634706-5762-2-git-send-email-grygorii.strashko@ti.com>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <m-karicheri2-l0cyMroinI0@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <santosh.shilimkar-l0cyMroinI0@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408634706-5762-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The driver should not touch CS lines if SPI_NO_CS flag is set.
This patch fixes it as this functionality was broken accidentally
by
commit a88e34ea213e1b ("spi: davinci: add support to configure gpio cs through dt").

Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-davinci.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 276a388..48f1d26 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -417,16 +417,16 @@ static int davinci_spi_setup(struct spi_device *spi)
 						  flags, dev_name(&spi->dev));
 			internal_cs = false;
 		}
-	}
 
-	if (retval) {
-		dev_err(&spi->dev, "GPIO %d setup failed (%d)\n",
-			spi->cs_gpio, retval);
-		return retval;
-	}
+		if (retval) {
+			dev_err(&spi->dev, "GPIO %d setup failed (%d)\n",
+				spi->cs_gpio, retval);
+			return retval;
+		}
 
-	if (internal_cs)
-		set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
+		if (internal_cs)
+			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
+	}
 
 	if (spi->mode & SPI_READY)
 		set_io_bits(dspi->base + SPIPC0, SPIPC0_SPIENA_MASK);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
