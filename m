From: Heiner Kallweit <heiner.kallweit-S0/GAf8tV78@public.gmane.org>
Subject: [PATCH 2/4] spi: fsl-espi: simplify of_fsl_espi_probe
Date: Sat, 17 Sep 2016 15:43:00 +0200
Message-ID: <5bfd3921-5bb6-b9c3-dc64-3882491bba13@web.de>
References: <1d67ce99-42ea-c816-da35-e64575cca8ff@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1d67ce99-42ea-c816-da35-e64575cca8ff-S0/GAf8tV78@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Simplify of_fsl_espi_probe.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 4f9d9ec..dee3f82 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -685,7 +685,7 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 	struct spi_master *master;
 	struct resource mem;
 	unsigned int irq;
-	int ret = -ENOMEM;
+	int ret;
 
 	ret = of_mpc8xxx_spi_probe(ofdev);
 	if (ret)
@@ -693,28 +693,21 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 
 	ret = of_fsl_espi_get_chipselects(dev);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = of_address_to_resource(np, 0, &mem);
 	if (ret)
-		goto err;
+		return ret;
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (!irq)
+		return -EINVAL;
 
 	master = fsl_espi_probe(dev, &mem, irq);
-	if (IS_ERR(master)) {
-		ret = PTR_ERR(master);
-		goto err;
-	}
+	if (IS_ERR(master))
+		return PTR_ERR(master);
 
 	return 0;
-
-err:
-	return ret;
 }
 
 static int of_fsl_espi_remove(struct platform_device *dev)
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
