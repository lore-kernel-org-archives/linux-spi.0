From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Drop duplicate code to set master->dev.parent" to the spi tree
Date: Tue, 26 Apr 2016 12:08:08 +0100
Message-ID: <E1av0qe-0000hL-HR@debutante>
References: <1461667992.31714.1.camel@ingics.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461667992.31714.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Drop duplicate code to set master->dev.parent

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 71c5e53b42f3641f6066c34b2c060dfe64d0ac2e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Tue, 26 Apr 2016 18:53:12 +0800
Subject: [PATCH] spi: Drop duplicate code to set master->dev.parent

It's done by spi_alloc_master().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-axi-spi-engine.c | 1 -
 drivers/spi/spi-dln2.c           | 1 -
 drivers/spi/spi-pxa2xx.c         | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index c968ab210a51..2b1456e5e221 100644
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
index 4e8a8629d514..b62a99caacc0 100644
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
index 85e59a406a4c..e48320667b37 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1543,7 +1543,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	drv_data->pdev = pdev;
 	drv_data->ssp = ssp;
 
-	master->dev.parent = &pdev->dev;
 	master->dev.of_node = pdev->dev.of_node;
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
