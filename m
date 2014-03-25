From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: fsl-dspi: Fix memory leak
Date: Tue, 25 Mar 2014 09:19:05 +0800
Message-ID: <1395710345.29281.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The memory allocated for chip is not freed anywhere.
Convert to use devm_kzalloc to fix the memory leak.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 2249cb7..d565eee 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -342,7 +342,8 @@ static int dspi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
 	if (chip == NULL) {
-		chip = kcalloc(1, sizeof(struct chip_data), GFP_KERNEL);
+		chip = devm_kzalloc(&spi->dev, sizeof(struct chip_data),
+				    GFP_KERNEL);
 		if (!chip)
 			return -ENOMEM;
 	}
@@ -353,7 +354,6 @@ static int dspi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		fmsz = spi->bits_per_word - 1;
 	} else {
 		pr_err("Invalid wordsize\n");
-		kfree(chip);
 		return -ENODEV;
 	}
 
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
