From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Drop duplicate code to set master->dev.parent
Date: Tue, 26 Apr 2016 18:53:12 +0800
Message-ID: <1461667992.31714.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It's done by spi_alloc_master().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-axi-spi-engine.c | 1 -
 drivers/spi/spi-dln2.c           | 1 -
 drivers/spi/spi-pxa2xx.c         | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index c968ab2..2b1456e 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -525,7 +525,6 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_ref_clk_disable;
 
-	master->dev.parent = &pdev->dev;
 	master->dev.of_node = pdev->dev.of_node;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 4e8a862..b62a99ca 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -701,7 +701,6 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	}
 
 	dln2->master = master;
-	dln2->master->dev.parent = dev;
 	dln2->master->dev.of_node = dev->of_node;
 	dln2->pdev = pdev;
 	dln2->port = pdata->port;
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0ce82db..c625272 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1548,7 +1548,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	drv_data->pdev = pdev;
 	drv_data->ssp = ssp;
 
-	master->dev.parent = &pdev->dev;
 	master->dev.of_node = pdev->dev.of_node;
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
