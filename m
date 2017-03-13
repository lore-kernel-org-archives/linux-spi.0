From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl: Call irq_dispose_mapping in err path" to the spi tree
Date: Mon, 13 Mar 2017 16:57:12 +0000
Message-ID: <E1cnTHU-0004rn-N8@debutante>
References: <1489070401-5663-1-git-send-email-liu.xiang6@zte.com.cn>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liu Xiang <liu.xiang6-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489070401-5663-1-git-send-email-liu.xiang6-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl: Call irq_dispose_mapping in err path

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

>From 500a32abaf818b3f4afe5b7f0ba9ca9b7a3aa65e Mon Sep 17 00:00:00 2001
From: Liu Xiang <liu.xiang6-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org>
Date: Thu, 9 Mar 2017 22:40:01 +0800
Subject: [PATCH] spi: fsl: Call irq_dispose_mapping in err path

Irq_dispose_mapping should be called in err path to release
the resources that irq_of_parse_and_map requested.

Signed-off-by: Liu Xiang <liu.xiang6-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 8b290d9d7935..592034320a41 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -813,7 +813,7 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct spi_master *master;
 	struct resource mem;
-	int irq, type;
+	int irq = 0, type;
 	int ret = -ENOMEM;
 
 	ret = of_mpc8xxx_spi_probe(ofdev);
@@ -846,6 +846,7 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	return 0;
 
 err:
+	irq_dispose_mapping(irq);
 	if (type == TYPE_FSL)
 		of_fsl_spi_free_chipselects(dev);
 	return ret;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
