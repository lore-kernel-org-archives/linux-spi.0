From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/11] spi: fsl-espi: remove unneeded check for
 SPI_QE_CPU_MODE
Date: Sun, 2 Oct 2016 14:22:48 +0200
Message-ID: <20608368-44e6-21f8-d970-5ade9990ce59@gmail.com>
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
see Documentation/devicetree/bindings/spi/fsl-spi.txt
Therefore remove the check.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 65bb70d..8281aea1 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -594,11 +594,6 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	if (ret)
 		goto err_probe;
 
-	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
-		mpc8xxx_spi->rx_shift = 16;
-		mpc8xxx_spi->tx_shift = 24;
-	}
-
 	/* SPI controller initializations */
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, 0);
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
-- 
2.10.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
