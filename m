From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rspi: Use of_device_get_match_data() helper" to the spi tree
Date: Wed, 04 Oct 2017 15:51:46 +0100
Message-ID: <E1dzl1W-0008Vl-PM@debutante>
References: <1507119593-12789-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1507119593-12789-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rspi: Use of_device_get_match_data() helper

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

>From 219a7bc577e6024cd6f84571d93d939b3517aafe Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Wed, 4 Oct 2017 14:19:53 +0200
Subject: [PATCH] spi: rspi: Use of_device_get_match_data() helper

Use the of_device_get_match_data() helper instead of open coding.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 2a10b3f94ff7..2ce875764ca6 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1221,7 +1221,6 @@ static int rspi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct rspi_data *rspi;
 	int ret;
-	const struct of_device_id *of_id;
 	const struct rspi_plat_data *rspi_pd;
 	const struct spi_ops *ops;
 
@@ -1229,9 +1228,8 @@ static int rspi_probe(struct platform_device *pdev)
 	if (master == NULL)
 		return -ENOMEM;
 
-	of_id = of_match_device(rspi_of_match, &pdev->dev);
-	if (of_id) {
-		ops = of_id->data;
+	ops = of_device_get_match_data(&pdev->dev);
+	if (ops) {
 		ret = rspi_parse_dt(&pdev->dev, master);
 		if (ret)
 			goto error1;
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
