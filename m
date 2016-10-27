From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 01/09] spi: fsl-espi: improve check for SPI_QE_CPU_MODE
Date: Thu, 27 Oct 2016 21:24:01 +0200
Message-ID: <0b5e7849-88d6-2af5-a428-eeb0de0f2af2@gmail.com>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5b98be38-17a2-79a2-14da-fb2bb6f8820f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI_QE_CPU_MODE doesn't exist for ESPI and is set by of_mpc8xxx_spi_probe
based on DT property "mode". This property is not defined for ESPI,
see Documentation/devicetree/bindings/spi/fsl-spi.txt.
So print an error message and bail out if SPI_QE_CPU_MODE is set.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- print error message and bail out instead of removing the check
---
 drivers/spi/spi-fsl-espi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 4e8a99d..f04c246 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -583,8 +583,9 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 		goto err_probe;
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
-		mpc8xxx_spi->rx_shift = 16;
-		mpc8xxx_spi->tx_shift = 24;
+		dev_err(dev, "SPI_QE_CPU_MODE is not supported on ESPI!\n");
+		ret = -EINVAL;
+		goto err_probe;
 	}
 
 	/* SPI controller initializations */
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
