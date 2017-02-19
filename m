From: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-dspi: Fix error handling
Date: Sun, 19 Feb 2017 14:19:02 +0100
Message-ID: <20170219131902.12269-1-christophe.jaillet@wanadoo.fr>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

According to error handling in this function, it is likely that going to
'out_master_put' was expected here.

Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 14c8e7ce1913..15201645bdc4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1002,7 +1002,8 @@ static int dspi_probe(struct platform_device *pdev)
 	if (IS_ERR(dspi->regmap)) {
 		dev_err(&pdev->dev, "failed to init regmap: %ld\n",
 				PTR_ERR(dspi->regmap));
-		return PTR_ERR(dspi->regmap);
+		ret = PTR_ERR(dspi->regmap);
+		goto out_master_put;
 	}
 
 	dspi_init(dspi);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
