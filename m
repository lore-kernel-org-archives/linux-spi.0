From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/10] spi: fsl-espi: remove usage of mpc8xxx_spi->irq
Date: Sun, 13 Nov 2016 14:36:47 +0100
Message-ID: <6819df7d-ddfc-49e3-1c70-76e805c5c80f@gmail.com>
References: <21625685-c2fd-be5e-f55a-c109b9b04935@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <21625685-c2fd-be5e-f55a-c109b9b04935-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There's no need to access mpc8xxx_spi->irq, we can use function
parameter irq directly.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 29cd4e0..6a011b0 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -615,8 +615,8 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	}
 
 	/* Register for SPI Interrupt */
-	ret = devm_request_irq(dev, mpc8xxx_spi->irq, fsl_espi_irq,
-			  0, "fsl_espi", mpc8xxx_spi);
+	ret = devm_request_irq(dev, irq, fsl_espi_irq, 0, "fsl_espi",
+			       mpc8xxx_spi);
 	if (ret)
 		goto err_probe;
 
@@ -675,8 +675,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	if (ret < 0)
 		goto err_pm;
 
-	dev_info(dev, "at 0x%p (irq = %d)\n", mpc8xxx_spi->reg_base,
-		 mpc8xxx_spi->irq);
+	dev_info(dev, "at 0x%p (irq = %u)\n", mpc8xxx_spi->reg_base, irq);
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
