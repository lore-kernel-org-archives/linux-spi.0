From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: account for const type of of_device_id.data" to the spi tree
Date: Wed, 03 Jan 2018 12:22:47 +0000
Message-ID: <E1eWi4F-0003MO-Vh@debutante>
References: <1514899688-27844-11-git-send-email-Julia.Lawall@lip6.fr>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1514899688-27844-11-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: account for const type of of_device_id.data

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 230c08b2acf65863ac5905ea1fa93106bdd20af3 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Date: Tue, 2 Jan 2018 14:28:06 +0100
Subject: [PATCH] spi: spi-fsl-dspi: account for const type of
 of_device_id.data

This driver creates a number of const structures that it stores in the
data field of an of_device_id array.

The data field of an of_device_id structure has type const void *, so
there is no need for a const-discarding cast when putting const values
into such a structure.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 02d3ed7f2558..0630962ce442 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -903,10 +903,9 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 }
 
 static const struct of_device_id fsl_dspi_dt_ids[] = {
-	{ .compatible = "fsl,vf610-dspi", .data = (void *)&vf610_data, },
-	{ .compatible = "fsl,ls1021a-v1.0-dspi",
-		.data = (void *)&ls1021a_v1_data, },
-	{ .compatible = "fsl,ls2085a-dspi", .data = (void *)&ls2085a_data, },
+	{ .compatible = "fsl,vf610-dspi", .data = &vf610_data, },
+	{ .compatible = "fsl,ls1021a-v1.0-dspi", .data = &ls1021a_v1_data, },
+	{ .compatible = "fsl,ls2085a-dspi", .data = &ls2085a_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
