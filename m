From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/10] spi: fsl-espi: remove usage of pdata->initial_spmode
Date: Sun, 13 Nov 2016 14:36:01 +0100
Message-ID: <87e8e8eb-d52b-e207-473b-423bcd2379a7@gmail.com>
References: <882d05f1-a963-c03a-38ae-2dd701f561a6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <882d05f1-a963-c03a-38ae-2dd701f561a6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove pdata->initial_spmode as it is nowhere set.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 6624c5a..a1e1b68 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -661,7 +661,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	}
 
 	/* Enable SPI interface */
-	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
+	regval = SPMODE_INIT_VAL | SPMODE_ENABLE;
 
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
 
@@ -786,7 +786,7 @@ static int of_fsl_espi_resume(struct device *dev)
 				      CSMODE_INIT_VAL);
 
 	/* Enable SPI interface */
-	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
+	regval = SPMODE_INIT_VAL | SPMODE_ENABLE;
 
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
 
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
