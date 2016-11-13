From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/10] spi: fsl-espi: remove usage of mpc8xxx_spi->flags
Date: Sun, 13 Nov 2016 14:37:18 +0100
Message-ID: <ff48fe5e-da20-111d-77ef-39908c9a57eb@gmail.com>
References: <a9f9bda6-b59f-997b-ea62-e742dc55eede@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a9f9bda6-b59f-997b-ea62-e742dc55eede-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Change the check to access property "mode" directly.
This allows us to get rid of mpc8xxx_spi->flags in a subsequent
patch in this patch series as it's used nowhere else.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 6a011b0..e378622 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -620,12 +620,6 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	if (ret)
 		goto err_probe;
 
-	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
-		dev_err(dev, "SPI_QE_CPU_MODE is not supported on ESPI!\n");
-		ret = -EINVAL;
-		goto err_probe;
-	}
-
 	/* SPI controller initializations */
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, 0);
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
@@ -714,6 +708,11 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 	unsigned int irq, num_cs;
 	int ret;
 
+	if (of_property_read_bool(np, "mode")) {
+		dev_err(dev, "mode property is not supported on ESPI!\n");
+		return -EINVAL;
+	}
+
 	ret = of_mpc8xxx_spi_probe(ofdev);
 	if (ret)
 		return ret;
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
